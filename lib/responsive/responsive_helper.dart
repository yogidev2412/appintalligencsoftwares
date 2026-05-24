// lib/responsive/responsive_helper.dart
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

/// Provides responsive utilities based on screen width.
class ResponsiveHelper {
  final BuildContext context;
  late final double _width;

  ResponsiveHelper(this.context) {
    _width = MediaQuery.of(context).size.width;
  }

  bool get isMobile  => _width < AppSizes.mobile;
  bool get isTablet  => _width >= AppSizes.mobile && _width < AppSizes.tablet;
  bool get isDesktop => _width >= AppSizes.tablet;

  /// Horizontal page padding
  double get horizontalPadding {
    if (isMobile) return AppSizes.paddingS;
    if (isTablet) return AppSizes.paddingL;
    return AppSizes.paddingXL;
  }

  /// Section vertical padding
  double get sectionPadding {
    if (isMobile) return AppSizes.paddingXL;
    return AppSizes.paddingXXL;
  }

  /// Grid cross-axis count
  int get gridCrossAxisCount {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  /// Services grid cross-axis count
  int get servicesCrossAxisCount {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  /// Hero font scale
  double get heroFontScale {
    if (isMobile) return 0.55;
    if (isTablet) return 0.75;
    return 1.0;
  }

  /// Section heading font size
  double get sectionHeadingSize {
    if (isMobile) return 26;
    if (isTablet) return 32;
    return 40;
  }

  T value<T>({required T mobile, required T tablet, required T desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
}

/// Responsive builder widget
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppSizes.mobile) return mobile;
        if (constraints.maxWidth < AppSizes.tablet) return tablet ?? desktop;
        return desktop;
      },
    );
  }
}
