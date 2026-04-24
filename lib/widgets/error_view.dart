import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final Future<void> Function()? onRetry;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 42,
                color: Color(0xFF6F4EF6),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Oops, terjadi kendala',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF7B7591),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: onRetry == null ? null : () => onRetry!.call(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C5CFA),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}