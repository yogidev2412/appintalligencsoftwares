// lib/widgets/section_header.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/app_constants.dart';
import '../utils/text_styles.dart';

/// Reusable section header with label + title + subtitle
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          // Label chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.glassGradient,
              borderRadius: BorderRadius.circular(AppSizes.radiusRound),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(label.toUpperCase(), style: AppTextStyles.label()),
          ),
          const SizedBox(height: 16),

          // Title with gradient
          GradientText(
            text: title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: _titleSize(context),
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            gradient: AppColors.primaryGradient,
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 16),
            Text(
              subtitle!,
              style: AppTextStyles.bodyM(),
              textAlign: alignment == CrossAxisAlignment.center ? TextAlign.center : TextAlign.left,
            ),
          ],
        ],
      ),
    );
  }

  double _titleSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600)  return 26;
    if (w < 1024) return 34;
    return 42;
  }
}

/// Text widget with gradient colour
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign textAlign;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: Text(text, style: style.copyWith(color: Colors.white), textAlign: textAlign),
    );
  }
}

/// Glassmorphism container
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final bool glowOnHover;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.glowOnHover = false,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCardInner(
      padding: padding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      glowOnHover: glowOnHover,
      child: child,
    );
  }
}

class _GlassCardInner extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final bool glowOnHover;

  const _GlassCardInner({
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.glowOnHover = false,
  });

  @override
  State<_GlassCardInner> createState() => _GlassCardInnerState();
}

class _GlassCardInnerState extends State<_GlassCardInner> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: widget.padding ?? const EdgeInsets.all(AppSizes.paddingM),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? AppSizes.radiusL),
          border: Border.all(
            color: _hovered && widget.glowOnHover
                ? AppColors.primary.withOpacity(0.5)
                : (widget.borderColor ?? AppColors.border),
            width: 1.5,
          ),
          boxShadow: _hovered && widget.glowOnHover
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.15), blurRadius: 30, spreadRadius: 0)]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Animated counter widget
class AnimatedCounter extends StatefulWidget {
  final int end;
  final String prefix;
  final String suffix;
  final TextStyle style;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.prefix = '',
    this.suffix = '',
    required this.style,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation  = Tween<double>(begin: 0, end: widget.end.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Text(
          '${widget.prefix}${_animation.value.toInt()}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
