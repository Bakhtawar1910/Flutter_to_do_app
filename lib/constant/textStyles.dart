import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/constant/colors.dart';

class AppTextStyles {
  static final heading = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final greyBody = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.secondary,
  );

  static final blueBody = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.primary,
  );

  static final button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
