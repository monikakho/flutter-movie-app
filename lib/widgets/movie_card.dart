import 'package:flutter/material.dart';
import '../core/constants/api_constants.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath.isNotEmpty
        ? '${ApiConstants.imageBaseUrl}${movie.posterPath}'
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFDFBFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.85),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2D1A5A).withOpacity(0.10),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'movie_${movie.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    children: [
                      posterUrl != null
                          ? Image.network(
                              posterUrl,
                              width: 104,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _posterPlaceholder(),
                            )
                          : _posterPlaceholder(),
                      Container(
                        width: 104,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.20),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF211C37),
                          height: 1.12,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _infoPill(
                            icon: Icons.star_rounded,
                            text: movie.voteAverage.toStringAsFixed(1),
                            iconColor: const Color(0xFFF5A623),
                            bgColor: const Color(0xFFFFF1CF),
                            textColor: const Color(0xFF7D5800),
                          ),
                          _infoPill(
                            icon: Icons.calendar_month_rounded,
                            text: movie.releaseDate.isEmpty
                                ? '-'
                                : movie.releaseDate,
                            iconColor: const Color(0xFF6D56F8),
                            bgColor: const Color(0xFFF0EBFF),
                            textColor: const Color(0xFF5440B6),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          movie.overview.isEmpty
                              ? 'Tidak ada deskripsi.'
                              : movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.2,
                            color: Color(0xFF6D6785),
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      width: 104,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFEAE4F6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Icon(
        Icons.movie_creation_outlined,
        color: Color(0xFFA79FBC),
        size: 36,
      ),
    );
  }

  Widget _infoPill({
    required IconData icon,
    required String text,
    required Color iconColor,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}