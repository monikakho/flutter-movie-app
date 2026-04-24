class ApiConstants {
  static const String apiKey = '92aba56c5a8a5e29bfac109acca083be';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static String popularMoviesUrl() =>
      '$baseUrl/movie/popular?api_key=$apiKey';

  static String searchMoviesUrl(String query) =>
      '$baseUrl/search/movie?api_key=$apiKey&query=$query';

  static String genresUrl() =>
      '$baseUrl/genre/movie/list?api_key=$apiKey';

  static String movieDetailUrl(int id) =>
      '$baseUrl/movie/$id?api_key=$apiKey';
}