import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String moviesKey = 'cached_movies';
  static const String genresKey = 'cached_genres';

  Future<void> saveMovies(String rawJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(moviesKey, rawJson);
  }

  Future<String?> getMovies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(moviesKey);
  }

  Future<void> saveGenres(String rawJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(genresKey, rawJson);
  }

  Future<String?> getGenres() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(genresKey);
  }
}