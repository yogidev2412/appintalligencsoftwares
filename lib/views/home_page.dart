// lib/views/home_page.dart
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/services_section.dart';
import 'sections/stats_section.dart';
import 'sections/portfolio_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _activeNavIndex = 0;

  /// Keys for each section — order must match AppStrings.navItems
  late final List<GlobalKey> _sectionKeys = [
    SectionKeys.home,
    SectionKeys.services,
    SectionKeys.portfolio,
    SectionKeys.about,
    SectionKeys.contact,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveNav);
  }

  void _updateActiveNav() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box == null) continue;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 120) {
          if (_activeNavIndex != i) setState(() => _activeNavIndex = i);
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveNav);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Offset for navbar
                const SizedBox(height: AppSizes.navbarHeight),

                // ── Sections ───────────────────
                KeyedSection(sectionKey: SectionKeys.home,      child: HeroSection(
                  onGetStarted: () => _scrollToSection(4),
                  onLearnMore:  () => _scrollToSection(1),
                )),
                KeyedSection(sectionKey: SectionKeys.services,  child: const ServicesSection()),
                const StatsSection(),
                KeyedSection(sectionKey: SectionKeys.portfolio, child: const PortfolioSection()),
                KeyedSection(sectionKey: SectionKeys.about,     child: const AboutSection()),
                KeyedSection(sectionKey: SectionKeys.contact,   child: const ContactSection()),
                FooterSection(sectionKeys: _sectionKeys, onNavTap: _scrollToSection),
              ],
            ),
          ),

          // Sticky Navbar overlay
          Positioned(
            top: 0, left: 0, right: 0,
            child: AppNavbar(
              scrollController: _scrollController,
              sectionKeys:      _sectionKeys,
              activeIndex:      _activeNavIndex,
              onNavTap:         _scrollToSection,
            ),
          ),
        ],
      ),

      // Scroll-to-top FAB
      floatingActionButton: _ScrollToTopFab(
        scrollController: _scrollController,
        onTap: () => _scrollToSection(0),
      ),
    );
  }
}

/// Wraps a section widget with its GlobalKey
class KeyedSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;

  const KeyedSection({required this.sectionKey, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: sectionKey, child: child);
  }
}

/// Floating scroll-to-top button
class _ScrollToTopFab extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onTap;

  const _ScrollToTopFab({required this.scrollController, required this.onTap});

  @override
  State<_ScrollToTopFab> createState() => _ScrollToTopFabState();
}

class _ScrollToTopFabState extends State<_ScrollToTopFab> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final visible = widget.scrollController.offset > 400;
      if (visible != _visible) setState(() => _visible = visible);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton(
        onPressed: widget.onTap,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        mini: true,
        child: const Icon(Icons.keyboard_arrow_up_rounded, size: 22),
      ),
    );
  }
}
