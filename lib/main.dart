// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/home_page.dart';
import 'utils/app_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const AISoftwaresApp());
}

class AISoftwaresApp extends StatelessWidget {
  const AISoftwaresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Intelligence Softwares',
      debugShowCheckedModeBanner: false,

      // ── SEO meta (Flutter Web) ──────────────
      // Web title set via index.html

      // ── Theme ──────────────────────────────
      theme: _buildTheme(),
      darkTheme: _buildTheme(),
      themeMode: ThemeMode.dark,

      home: const AppLoadingWrapper(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.bgCard,
        error: AppColors.error,
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textLight, fontFamily: 'Poppins'),
        bodyMedium:
            TextStyle(color: AppColors.textMuted, fontFamily: 'Poppins'),
        bodySmall:
            TextStyle(color: AppColors.textSubtle, fontFamily: 'Poppins'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
        trackColor: WidgetStateProperty.all(AppColors.bgCardLight),
      ),
    );
  }
}

/// Loading splash screen before home page
class AppLoadingWrapper extends StatefulWidget {
  const AppLoadingWrapper({super.key});

  @override
  State<AppLoadingWrapper> createState() => _AppLoadingWrapperState();
}

class _AppLoadingWrapperState extends State<AppLoadingWrapper>
    with SingleTickerProviderStateMixin {
  bool _loaded = false;
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        _controller.forward().then((_) {
          if (mounted) setState(() => _loaded = true);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded) return const HomePage();
    return HomePage();
  }
}

class _SplashScreen extends StatefulWidget {
  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _scale = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.elasticOut));
    _fade = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeIn));
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Center(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) => FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 40)
                      ],
                    ),
                    child: const Center(
                      child: Text('AI',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('App Intelligence Softwares',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      )),
                  const SizedBox(height: 8),
                  const Text('Loading...',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.textMuted,
                      )),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.bgCardLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
