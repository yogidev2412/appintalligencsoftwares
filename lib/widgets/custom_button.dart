// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/text_styles.dart';

enum ButtonVariant { primary, secondary, outlined, ghost }

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? width;
  final double height;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height = 52,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: _buildDecoration(),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return BoxDecoration(
          gradient: _hovered
              ? const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF22D3EE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 6))]
              : [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))],
        );
      case ButtonVariant.secondary:
        return BoxDecoration(
          color: _hovered ? AppColors.bgCardLight : AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
          border: Border.all(color: AppColors.border, width: 1.5),
        );
      case ButtonVariant.outlined:
        return BoxDecoration(
          color: _hovered ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
          border: Border.all(color: AppColors.primaryLight, width: 1.5),
        );
      case ButtonVariant.ghost:
        return BoxDecoration(
          color: _hovered ? AppColors.bgCardLight : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        );
    }
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return const Center(
        child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.prefixIcon != null) ...[
          Icon(widget.prefixIcon, size: 16, color: _iconColor),
          const SizedBox(width: 8),
        ],
        Text(widget.label, style: AppTextStyles.button(color: _textColor)),
        if (widget.suffixIcon != null) ...[
          const SizedBox(width: 8),
          Icon(widget.suffixIcon, size: 16, color: _iconColor),
        ],
      ],
    );
  }

  Color get _textColor {
    if (widget.variant == ButtonVariant.primary) return AppColors.textWhite;
    if (widget.variant == ButtonVariant.outlined) return AppColors.primaryLight;
    return AppColors.textLight;
  }

  Color get _iconColor => _textColor;
}
