import 'package:flutter/material.dart';

class GenreFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF8A72FF),
                      Color(0xFF6B53F8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : const Color(0xFFE7E1F3),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF7B61FF).withOpacity(0.22),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF5C5573),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}