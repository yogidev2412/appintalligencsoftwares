// lib/utils/text_styles.dart
import 'package:flutter/material.dart';
import 'app_constants.dart';

/// Centralised text style definitions.
/// Use these throughout the app instead of inline styles.
class AppTextStyles {
  AppTextStyles._();

  // ── Display ─────────────────────────────
  static TextStyle displayXL({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 64,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -1.5,
    color: color ?? AppColors.textWhite,
  );

  static TextStyle displayL({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -1.0,
    color: color ?? AppColors.textWhite,
  );

  static TextStyle displayM({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: color ?? AppColors.textWhite,
  );

  // ── Heading ──────────────────────────────
  static TextStyle h1({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: color ?? AppColors.textWhite,
  );

  static TextStyle h2({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: color ?? AppColors.textWhite,
  );

  static TextStyle h3({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: color ?? AppColors.textWhite,
  );

  // ── Body ─────────────────────────────────
  static TextStyle bodyL({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.7,
    color: color ?? AppColors.textLight,
  );

  static TextStyle bodyM({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: color ?? AppColors.textLight,
  );

  static TextStyle bodyS({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: color ?? AppColors.textMuted,
  );

  // ── Label / Caption ──────────────────────
  static TextStyle label({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: color ?? AppColors.accent,
  );

  static TextStyle caption({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color ?? AppColors.textSubtle,
  );

  // ── Button ───────────────────────────────
  static TextStyle button({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: color ?? AppColors.textWhite,
  );

  // ── Nav item ─────────────────────────────
  static TextStyle navItem({Color? color}) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textLight,
  );
}
