import '../../models/genre.dart';

String getGenreNameById(List<Genre> genres, int id) {
  try {
    return genres.firstWhere((genre) => genre.id == id).name;
  } catch (_) {
    return 'Unknown';
  }
}