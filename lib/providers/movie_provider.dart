import 'package:flutter/material.dart';
import '../models/genre.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();

  List<Movie> _allMovies = [];
  List<Movie> _filteredMovies = [];
  List<Genre> _genres = [];

  bool _isLoading = false;
  bool _hasSearched = false;
  String _errorMessage = '';
  int? _selectedGenreId;
  String _currentQuery = '';

  List<Movie> get movies => _filteredMovies;
  List<Genre> get genres => _genres;
  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;
  String get errorMessage => _errorMessage;
  int? get selectedGenreId => _selectedGenreId;

  Future<void> initializeData() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final moviesRaw = await _apiService.fetchPopularMoviesRaw();
      final genresRaw = await _apiService.fetchGenresRaw();

      await _cacheService.saveMovies(moviesRaw);
      await _cacheService.saveGenres(genresRaw);

      _allMovies = _apiService.parseMovies(moviesRaw);
      _genres = _apiService.parseGenres(genresRaw);
      _filteredMovies = List.from(_allMovies);
    } catch (_) {
      final cachedMovies = await _cacheService.getMovies();
      final cachedGenres = await _cacheService.getGenres();

      if (cachedMovies != null && cachedGenres != null) {
        _allMovies = _apiService.parseMovies(cachedMovies);
        _genres = _apiService.parseGenres(cachedGenres);
        _filteredMovies = List.from(_allMovies);
        _errorMessage =
            'Tidak ada internet. Menampilkan data terakhir yang tersimpan.';
      } else {
        _errorMessage = 'Gagal memuat data. Coba lagi ya.';
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    _currentQuery = query.trim();
    _hasSearched = _currentQuery.isNotEmpty;

    if (_currentQuery.isEmpty) {
      _applyFiltersOnLocal();
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final results = await _apiService.searchMovies(_currentQuery);

      if (_selectedGenreId != null) {
        _filteredMovies = results
            .where((movie) => movie.genreIds.contains(_selectedGenreId))
            .toList();
      } else {
        _filteredMovies = results;
      }
    } catch (_) {
      _filteredMovies = [];
      _errorMessage = 'Pencarian gagal dilakukan. Coba lagi ya.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void applyGenreFilter(int? genreId) {
    _selectedGenreId = genreId;

    if (_currentQuery.isNotEmpty) {
      searchMovies(_currentQuery);
      return;
    }

    _applyFiltersOnLocal();
    notifyListeners();
  }

  void _applyFiltersOnLocal() {
    if (_selectedGenreId == null) {
      _filteredMovies = List.from(_allMovies);
    } else {
      _filteredMovies = _allMovies
          .where((movie) => movie.genreIds.contains(_selectedGenreId))
          .toList();
    }
  }

  Future<void> refreshMovies() async {
    _hasSearched = false;
    _currentQuery = '';
    await initializeData();
  }
}