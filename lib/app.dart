import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'views/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UTS Movie App',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F2FB),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7B61FF),
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            foregroundColor: Color(0xFF211C37),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF2F2A45)),
            bodyMedium: TextStyle(color: Color(0xFF6E6886)),
            titleLarge: TextStyle(
              color: Color(0xFF211C37),
              fontWeight: FontWeight.w800,
            ),
            titleMedium: TextStyle(
              color: Color(0xFF211C37),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}