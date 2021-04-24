import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = const Color(0xFFF30070);
  static const Color darkGrey = const Color(0xFF828899);
  static const Color lightGrey = const Color(0xFFCED1D9);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color appWhite = const Color(0xFFEBEEF7);

  //shadow
  static final Shadow defaultShadow = BoxShadow(
    color: AppColors.darkGrey.withOpacity(0.3),
    spreadRadius: 2,
    offset: Offset(0, 3),
    blurRadius: 9,
  );
}
