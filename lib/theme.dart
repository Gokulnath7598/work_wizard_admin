import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      shadow: const Color(0xFFA7A8AB),
      primary: const Color(0xFF00A4EF),
      secondary: const Color(0xFF243136),
      tertiary: const Color(0xFFFDC626),
      surface: const Color(0xFFA2D5FF),
      scrim: const Color(0xFFFFFFFF),
    seedColor: const Color(0xFF00A4EF),),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp, color: const Color(0xFF442C2E), fontFamily: 'Inria-Bold'),
    titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: const Color(0xFF442C2E)),
    titleSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp, color: const Color(0xFF442C2E)),
    bodyLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: const Color(0xFF442C2E)),
    bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: const Color(0xFF442C2E)),
    bodySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF442C2E)),
  ),
);
