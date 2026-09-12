import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:travel_planner_app/main.dart';

void main() {
  testWidgets('Splash screen tampil lalu pindah ke Register', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelPlannerApp());

    // Splash screen harus menampilkan judul aplikasi
    expect(find.text('Travel Planner'), findsOneWidget);

    // Tunggu 2 detik (durasi auto-navigate di splash_screen.dart),
    // lalu harus sudah pindah ke Register screen
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text("Let's Get\nStarted"), findsOneWidget);
  });
}
