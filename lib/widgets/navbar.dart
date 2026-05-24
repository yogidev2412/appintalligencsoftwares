// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_constants.dart';
import '../utils/text_styles.dart';
import '../responsive/responsive_helper.dart';
import 'custom_button.dart';

class AppNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final int activeIndex;
  final ValueChanged<int> onNavTap;

  const AppNavbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeIndex,
    required this.onNavTap,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar>
    with SingleTickerProviderStateMixin {
  bool _scrolled = false;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();

    widget.scrollController.addListener(() {
      final scrolled = widget.scrollController.offset > 20;
      if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    widget.onNavTap(index);
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: AppSizes.navbarHeight,
        decoration: BoxDecoration(
          color: _scrolled
              ? AppColors.bgDark.withOpacity(0.95)
              : Colors.transparent,
          border: _scrolled
              ? Border(
                  bottom: BorderSide(color: AppColors.border.withOpacity(0.5)))
              : null,
          boxShadow: _scrolled
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3), blurRadius: 20)
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: rh.horizontalPadding),
          child: Row(
            children: [
              // Logo
              _NavLogo(),
              const Spacer(),

              // Desktop nav
              if (rh.isDesktop) ...[
                ...List.generate(
                    AppStrings.navItems.length,
                    (i) => _NavItem(
                          label: AppStrings.navItems[i],
                          isActive: widget.activeIndex == i,
                          onTap: () => _scrollToSection(i),
                        )),
                const SizedBox(width: 24),
                CustomButton(
                  label: 'Get Started',
                  variant: ButtonVariant.primary,
                  height: 40,
                  suffixIcon: FontAwesomeIcons.arrowRight,
                  onPressed: () => _scrollToSection(4),
                ),
              ],

              // Mobile / Tablet hamburger
              if (!rh.isDesktop)
                IconButton(
                  icon: const Icon(Icons.menu_rounded,
                      color: AppColors.textLight, size: 26),
                  onPressed: () => _openDrawer(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MobileDrawer(
        activeIndex: widget.activeIndex,
        onNavTap: (i) {
          Navigator.pop(context);
          Future.delayed(
              const Duration(milliseconds: 300), () => _scrollToSection(i));
        },
      ),
    );
  }
}

class _NavLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // AI logo icon
        Container(
          width: 200,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            // gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            // child: Text('AI', style: TextStyle(
            //   fontFamily: 'Poppins',
            //   fontSize: 13,
            //   fontWeight: FontWeight.w800,
            //   color: Colors.white,
            //   letterSpacing: 0.5,
            // )),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem(
      {required this.label, required this.isActive, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.navItem(
                  color: widget.isActive || _hovered
                      ? AppColors.primaryLight
                      : AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : (_hovered ? 14 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onNavTap;

  const _MobileDrawer({required this.activeIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: AppColors.textSubtle,
                borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(height: 24),
          ...List.generate(
              AppStrings.navItems.length,
              (i) => _DrawerItem(
                    label: AppStrings.navItems[i],
                    isActive: activeIndex == i,
                    onTap: () => onNavTap(i),
                  )),
          const SizedBox(height: 16),
          CustomButton(
            label: 'Get Started',
            width: double.infinity,
            onPressed: () => onNavTap(4),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: isActive
              ? Border.all(color: AppColors.primary.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodyM(
                  color:
                      isActive ? AppColors.primaryLight : AppColors.textLight),
            ),
            if (isActive) ...[
              const Spacer(),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
