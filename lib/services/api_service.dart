import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/genre.dart';
import '../models/movie.dart';

class ApiService {
  Future<String> fetchPopularMoviesRaw() async {
    final response = await http.get(Uri.parse(ApiConstants.popularMoviesUrl()));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Gagal mengambil data film');
  }

  Future<String> fetchGenresRaw() async {
    final response = await http.get(Uri.parse(ApiConstants.genresUrl()));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Gagal mengambil genre');
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(ApiConstants.searchMoviesUrl(query)),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List results = decoded['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    }
    throw Exception('Gagal mencari film');
  }

  List<Movie> parseMovies(String rawJson) {
    final decoded = jsonDecode(rawJson);
    final List results = decoded['results'];
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  List<Genre> parseGenres(String rawJson) {
    final decoded = jsonDecode(rawJson);
    final List results = decoded['genres'];
    return results.map((e) => Genre.fromJson(e)).toList();
  }
}