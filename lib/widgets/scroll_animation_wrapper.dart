// lib/widgets/scroll_animation_wrapper.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps a child with a fade+slide-in animation triggered when it enters the viewport.
class ScrollAnimationWrapper extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset beginOffset;

  const ScrollAnimationWrapper({
    super.key,
    required this.child,
    this.delay     = Duration.zero,
    this.duration  = const Duration(milliseconds: 600),
    this.beginOffset = const Offset(0, 0.1),
  });

  @override
  State<ScrollAnimationWrapper> createState() => _ScrollAnimationWrapperState();
}

class _ScrollAnimationWrapperState extends State<ScrollAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>   _opacity;
  late Animation<Offset>   _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_triggered) {
          _triggered = true;
          Future.delayed(widget.delay, () {
            if (mounted) _controller.forward();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) => FadeTransition(
          opacity: _opacity,
          child: SlideTransition(position: _slide, child: child),
        ),
        child: widget.child,
      ),
    );
  }
}
