# Flutter Movie App

Aplikasi mobile berbasis Flutter untuk menampilkan data film menggunakan TMDB (The Movie Database) API.

## Fitur Utama

- Search film berdasarkan judul
- Filter film berdasarkan genre
- Menampilkan detail film
- Loading state menggunakan shimmer effect
- Error handling saat koneksi gagal atau data tidak ditemukan
- Caching untuk menyimpan data terakhir

## Struktur Project

Project ini menggunakan struktur folder modular agar kode lebih rapi dan mudah dikembangkan.

lib/
- core/constants/ : menyimpan API endpoint dan konfigurasi
- core/utils/ : menyimpan fungsi helper
- models/ : menyimpan model data Movie dan Genre
- services/ : menangani API dan caching
- providers/ : mengatur state management menggunakan Provider
- views/ : menyimpan halaman aplikasi
- widgets/ : menyimpan reusable widget

## State Management

Project ini menggunakan Provider sebagai state management karena sederhana, mudah dipahami, dan cocok untuk mengatur data dari API, loading state, error state, search, dan filter genre.

## Teknologi

- Flutter
- Dart
- Provider
- TMDB API
- HTTP Package
- Shared Preferences
- Shimmer
