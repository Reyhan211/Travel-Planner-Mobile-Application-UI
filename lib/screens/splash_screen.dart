import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/page_transitions.dart';
import 'register_screen.dart';

/// Halaman 1: Splash Screen.
/// StatelessWidget dengan Future.delayed di initState BIASANYA butuh
/// StatefulWidget, tapi karena kita mau tetap stateless, kita pakai
/// FutureBuilder yang dijalankan langsung dari build() sebagai gantinya.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _goToRegister(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.of(context).pushReplacement(fadeTransition(const RegisterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dipanggil sekali tiap build; karena halaman ini tidak pernah
    // di-rebuild ulang selain oleh Flutter sendiri saat pertama tampil,
    // ini aman dipakai untuk auto-navigate.
    _goToRegister(context);

    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.travel_explore, color: AppColors.white, size: 64),
            SizedBox(height: 16),
            Text(
              'Travel Planner',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rencanakan perjalananmu',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
