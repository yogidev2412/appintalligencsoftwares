// lib/views/sections/hero_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../responsive/responsive_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/section_header.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onLearnMore;

  const HeroSection(
      {super.key, required this.onGetStarted, required this.onLearnMore});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  final List<String> _rotatingWords = [
    'Smarter',
    'Faster',
    'Scalable',
    'Intelligent'
  ];
  int _wordIndex = 0;
  late AnimationController _wordController;

  @override
  void initState() {
    super.initState();

    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
        CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));

    _wordController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _cycleWords();
  }

  void _cycleWords() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) break;
      await _wordController.forward();
      if (!mounted) break;
      setState(() => _wordIndex = (_wordIndex + 1) % _rotatingWords.length);
      _wordController.reset();
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);

    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          // Background decorations
          _buildBackgroundDecor(),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rh.horizontalPadding,
              vertical: AppSizes.paddingXXL,
            ),
            child: rh.isDesktop
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecor() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.primary.withOpacity(0.15),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.accent.withOpacity(0.1),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
            // Grid dots
            Positioned.fill(
              child: CustomPaint(painter: _GridDotPainter()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left content
        Expanded(flex: 6, child: _buildHeroContent(context)),
        const SizedBox(width: 60),
        // Right illustration
        Expanded(flex: 5, child: _buildHeroVisual()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeroVisual(),
        const SizedBox(height: 40),
        _buildHeroContent(context),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return Column(
      crossAxisAlignment:
          rh.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppColors.glassGradient,
              borderRadius: BorderRadius.circular(AppSizes.radiusRound),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: AppColors.success, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text('Transforming Businesses with Technology',
                    style: AppTextStyles.label()),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Main headline
        FadeInLeft(
          duration: const Duration(milliseconds: 700),
          child: Column(
            crossAxisAlignment: rh.isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                'Build',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: rh.isMobile ? 40 : (rh.isTablet ? 52 : 64),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                  height: 1.1,
                ),
              ),
              Row(
                mainAxisAlignment: rh.isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    'Products ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: rh.isMobile ? 40 : (rh.isTablet ? 52 : 64),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                      height: 1.1,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, 0.5), end: Offset.zero)
                          .animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: GradientText(
                      key: ValueKey(_wordIndex),
                      text: _rotatingWords[_wordIndex],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: rh.isMobile ? 40 : (rh.isTablet ? 52 : 64),
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                      gradient: AppColors.primaryGradient,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: Text(
            AppStrings.subTagline,
            style: AppTextStyles.bodyL(color: AppColors.textMuted),
            textAlign: rh.isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),

        const SizedBox(height: 40),

        // CTA Buttons
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: rh.isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              CustomButton(
                label: 'Start Your Project',
                suffixIcon: FontAwesomeIcons.arrowRight,
                onPressed: widget.onGetStarted,
                height: 52,
              ),
              CustomButton(
                label: 'Explore Services',
                variant: ButtonVariant.outlined,
                prefixIcon: FontAwesomeIcons.play,
                onPressed: widget.onLearnMore,
                height: 52,
              ),
            ],
          ),
        ),

        const SizedBox(height: 48),

        // Trust badges
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Column(
            crossAxisAlignment: rh.isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text('Trusted by teams at', style: AppTextStyles.caption()),
              const SizedBox(height: 12),
              Wrap(
                spacing: 24,
                runSpacing: 12,
                alignment:
                    rh.isMobile ? WrapAlignment.center : WrapAlignment.start,
                children: const [
                  _TrustBadge(label: '6+ Projects'),
                  _TrustBadge(label: '2+ Clients'),
                  _TrustBadge(label: '5★ Rating'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroVisual() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _floatAnimation.value),
        child: child,
      ),
      child: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: Container(
          height: 420,
          decoration: BoxDecoration(
            gradient: AppColors.glassGradient,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Stack(
            children: [
              // Main visual
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 40)
                        ],
                      ),
                      child: const Icon(FontAwesomeIcons.brain,
                          color: Colors.white, size: 48),
                    ),
                    const SizedBox(height: 24),
                    Text('AI-Powered Solutions', style: AppTextStyles.h2()),
                    const SizedBox(height: 8),
                    Text('Apps • Web • AI • SaaS',
                        style: AppTextStyles.bodyS()),
                    const SizedBox(height: 32),
                    // Floating tech chips
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: const [
                        _TechChip(label: 'Flutter', color: Color(0xFF54C5F8)),
                        _TechChip(label: 'AI/ML', color: Color(0xFFDB2777)),
                        _TechChip(label: 'React', color: Color(0xFF61DAFB)),
                        _TechChip(label: 'AWS', color: Color(0xFFFF9900)),
                        _TechChip(label: 'Python', color: Color(0xFF4CAF50)),
                        _TechChip(label: 'Firebase', color: Color(0xFFFFCA28)),
                      ],
                    ),
                  ],
                ),
              ),

              // Corner deco dots
              Positioned(
                  top: 16,
                  right: 16,
                  child: _PulseDot(color: AppColors.success)),
              Positioned(
                  bottom: 16,
                  left: 16,
                  child: _PulseDot(color: AppColors.accent)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final String label;
  const _TrustBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bgCardLight,
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(color: AppColors.border),
      ),
      child:
          Text(label, style: AppTextStyles.caption(color: AppColors.textLight)),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TechChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: AppTextStyles.caption(color: color)),
    );
  }
}

class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _a = Tween<double>(begin: 0.4, end: 1.0).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(_a.value),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: widget.color.withOpacity(0.5), blurRadius: 6)
          ],
        ),
      ),
    );
  }
}

/// Grid dot background painter
class _GridDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.04);
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
