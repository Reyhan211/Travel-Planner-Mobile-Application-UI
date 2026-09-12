import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      // Cukup satu halaman awal di sini. Semua perpindahan halaman
      // selanjutnya dilakukan lewat Navigator.push(...) langsung di
      // masing-masing screen (lihat lib/widgets/page_transitions.dart),
      // bukan lewat named routes — supaya gampang dibaca untuk pemula.
      home: const SplashScreen(),
    );
  }
}
