import 'package:flutter/material.dart';

/// Kumpulan helper transisi halaman custom.
/// Dipakai lewat Navigator.push(context, slideTransition(NextScreen()))
/// supaya semua perpindahan halaman di app ini konsisten.

/// Transisi geser dari kanan ke kiri (dipakai untuk "masuk lebih dalam",
/// misal: Explore -> Destination Detail).
Route slideTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

/// Transisi fade (dipakai untuk perpindahan tab bawah, dan Splash -> Login).
Route fadeTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
