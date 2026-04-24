import 'package:flutter/material.dart';
import '../core/constants/api_constants.dart';
import '../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath.isNotEmpty
        ? '${ApiConstants.imageBaseUrl}${movie.posterPath}'
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _circleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Center(
                child: Hero(
                  tag: 'movie_${movie.id}',
                  child: Container(
                    width: 230,
                    height: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2D1A5A).withOpacity(0.18),
                          blurRadius: 30,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: posterUrl != null
                          ? Image.network(
                              posterUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _posterPlaceholder(),
                            )
                          : _posterPlaceholder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.9),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2D1A5A).withOpacity(0.08),
                      blurRadius: 26,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF211C37),
                        height: 1.12,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _detailPill(
                          icon: Icons.star_rounded,
                          text: movie.voteAverage.toStringAsFixed(1),
                          bg: const Color(0xFFFFF1CF),
                          iconColor: const Color(0xFFF5A623),
                          textColor: const Color(0xFF7D5800),
                        ),
                        _detailPill(
                          icon: Icons.calendar_month_rounded,
                          text: movie.releaseDate.isEmpty
                              ? '-'
                              : movie.releaseDate,
                          bg: const Color(0xFFF0EBFF),
                          iconColor: const Color(0xFF6D56F8),
                          textColor: const Color(0xFF5440B6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF211C37),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie.overview.isEmpty
                          ? 'Tidak ada deskripsi.'
                          : movie.overview,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.65,
                        color: Color(0xFF6D6785),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF211C37),
          ),
        ),
      ),
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      color: const Color(0xFFEAE4F6),
      child: const Icon(
        Icons.movie_creation_outlined,
        color: Color(0xFFA79FBC),
        size: 42,
      ),
    );
  }

  Widget _detailPill({
    required IconData icon,
    required String text,
    required Color bg,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}