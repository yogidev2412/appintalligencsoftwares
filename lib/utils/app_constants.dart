// lib/utils/app_constants.dart
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────
///  COLOR PALETTE
/// ─────────────────────────────────────────
class AppColors {
  AppColors._();

  // Background
  static const Color bgDark = Color(0xFF0A0E1A);
  static const Color bgCard = Color(0xFF111827);
  static const Color bgCardLight = Color(0xFF1A2235);

  // Primary Brand Blue Gradient
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  // Accent Cyan
  static const Color accent = Color(0xFF06B6D4);
  static const Color accentLight = Color(0xFF22D3EE);

  // Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFE2E8F0);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textSubtle = Color(0xFF64748B);

  // Border
  static const Color border = Color(0xFF1E293B);
  static const Color borderGlow = Color(0xFF2563EB);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A0E1A), Color(0xFF0F172A), Color(0xFF0A0E1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A2235), Color(0xFF111827)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1A2563EB), Color(0x0A06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// ─────────────────────────────────────────
///  SPACING & SIZING
/// ─────────────────────────────────────────
class AppSizes {
  AppSizes._();

  // Breakpoints
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1280;

  // Max content width
  static const double maxWidth = 1200;

  // Padding
  static const double paddingXS = 8.0;
  static const double paddingS = 16.0;
  static const double paddingM = 24.0;
  static const double paddingL = 40.0;
  static const double paddingXL = 64.0;
  static const double paddingXXL = 96.0;

  // Border radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 100.0;

  // Navbar
  static const double navbarHeight = 70.0;
}

/// ─────────────────────────────────────────
///  COMPANY INFO
/// ─────────────────────────────────────────
class AppStrings {
  AppStrings._();

  static const String companyName = 'App Intelligence Softwares';
  static const String companyShort = 'AI Softwares';
  static const String tagline = 'Elevate Your Digital Operations.';
  static const String subTagline =
      'We craft intelligent apps, scalable web platforms, and AI-powered solutions that transform businesses and accelerate growth.';
  static const String phone = '+91 6384742409';
  static const String email = 'support.aisoftwares@gmail.com';
  static const String address = 'Coimbatore, Tamil Nadu, India';

  // Nav items
  static const List<String> navItems = [
    'Home',
    'Services',
    'Portfolio',
    'About',
    'Contact'
  ];

  // Social
  static const String linkedIn = 'https://linkedin.com';
  static const String twitter = 'https://twitter.com';
  static const String instagram = 'https://instagram.com';
  static const String github = 'https://github.com';
}

/// ─────────────────────────────────────────
///  SECTION KEYS (for scroll navigation)
/// ─────────────────────────────────────────
class SectionKeys {
  static final GlobalKey home = GlobalKey();
  static final GlobalKey services = GlobalKey();
  static final GlobalKey portfolio = GlobalKey();
  static final GlobalKey about = GlobalKey();
  static final GlobalKey contact = GlobalKey();
}
