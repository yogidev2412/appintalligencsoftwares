// lib/views/sections/stats_section.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../utils/app_data.dart';
import '../../responsive/responsive_helper.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: rh.horizontalPadding,
        vertical: rh.isMobile ? 48 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: rh.isMobile
              ? Column(
                  children: AppData.stats
                      .map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _StatItem(stat: s),
                          ))
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: AppData.stats
                      .map((s) => Expanded(child: _StatItem(stat: s)))
                      .toList(),
                ),
        ),
      ),
    );
  }
}

class _StatItem extends StatefulWidget {
  final dynamic stat;
  const _StatItem({required this.stat});

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('stat-${widget.stat.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_visible) {
          setState(() => _visible = true);
          _controller.forward();
        }
      },
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Column(
          children: [
            // Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.3), blurRadius: 16)
                ],
              ),
              child: Icon(widget.stat.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 16),

            // Animated number
            _AnimatedStatValue(value: widget.stat.value, isVisible: _visible),
            const SizedBox(height: 4),
            Text(widget.stat.label,
                style: AppTextStyles.bodyS(), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _AnimatedStatValue extends StatefulWidget {
  final String value;
  final bool isVisible;

  const _AnimatedStatValue({required this.value, required this.isVisible});

  @override
  State<_AnimatedStatValue> createState() => _AnimatedStatValueState();
}

class _AnimatedStatValueState extends State<_AnimatedStatValue>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  bool _started = false;

  String get _suffix => widget.value.replaceAll(RegExp(r'[0-9]'), '');
  int get _numericValue =>
      int.tryParse(widget.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _a = Tween<double>(begin: 0, end: _numericValue.toDouble())
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AnimatedStatValue old) {
    super.didUpdateWidget(old);
    if (widget.isVisible && !_started) {
      _started = true;
      _c.forward();
    }
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
      builder: (_, __) => ShaderMask(
        shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        blendMode: BlendMode.srcIn,
        child: Text(
          '${_a.value.toInt()}$_suffix',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
