import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/theme.dart';
import 'config/routes.dart';

class HospitalApp extends StatelessWidget {
  const HospitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediCare Hospital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
