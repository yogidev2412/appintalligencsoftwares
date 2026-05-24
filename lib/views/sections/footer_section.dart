// lib/views/sections/footer_section.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../responsive/responsive_helper.dart';

class FooterSection extends StatelessWidget {
  final List<GlobalKey> sectionKeys;
  final ValueChanged<int> onNavTap;

  const FooterSection({
    super.key,
    required this.sectionKeys,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return Container(
      color: const Color(0xFF060A14),
      child: Column(
        children: [
          // CTA Banner
          _CtaBanner(onGetStarted: () => onNavTap(4)),
          // Main footer
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rh.horizontalPadding,
              vertical: 64,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
                child: rh.isMobile
                    ? _buildMobileFooter(context)
                    : _buildDesktopFooter(context),
              ),
            ),
          ),
          // Bottom bar
          _BottomBar(),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _FooterBrand()),
        const SizedBox(width: 60),
        Expanded(
            flex: 2,
            child: _FooterLinks(title: 'Services', links: const [
              'Android Development',
              'iOS Development',
              'Web Development',
              'SaaS Products',
              'AI Solutions',
              'Digital Marketing',
            ])),
        Expanded(
            flex: 2,
            child: _FooterLinks(title: 'Company', links: const [
              'About Us',
              'Portfolio',
              'Careers',
              'Blog',
              'Privacy Policy',
            ])),
        Expanded(flex: 2, child: _FooterContact()),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterBrand(),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _FooterLinks(title: 'Services', links: const [
              'Android Dev',
              'iOS Dev',
              'Web Dev',
              'SaaS',
              'AI Solutions',
            ])),
            Expanded(
                child: _FooterLinks(title: 'Company', links: const [
              'About',
              'Portfolio',
              'Careers',
              'Blog',
            ])),
          ],
        ),
        const SizedBox(height: 32),
        _FooterContact(),
      ],
    );
  }
}

class _CtaBanner extends StatelessWidget {
  final VoidCallback onGetStarted;
  const _CtaBanner({required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: rh.horizontalPadding, vertical: 48),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF0E7490)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 40)
        ],
      ),
      child: rh.isDesktop
          ? Row(
              children: [
                Expanded(child: _buildBannerText()),
                _buildBannerButton(onGetStarted),
              ],
            )
          : Column(
              children: [
                _buildBannerText(),
                const SizedBox(height: 24),
                _buildBannerButton(onGetStarted),
              ],
            ),
    );
  }

  Widget _buildBannerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ready to Build Your Next Product?',
            style: AppTextStyles.displayM()),
        const SizedBox(height: 8),
        Text('Get a free consultation and project estimate within 24 hours.',
            style: AppTextStyles.bodyM()),
      ],
    );
  }

  Widget _buildBannerButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 20)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Get Free Consultation',
                style: AppTextStyles.button(color: AppColors.primaryDark)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded,
                color: AppColors.primaryDark, size: 18),
          ],
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text('AI',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ))),
            ),
            const SizedBox(width: 10),
            Text('App Intelligence\nSoftwares', style: AppTextStyles.h3()),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Building intelligent, scalable software\nsolutions for businesses across India and beyond.',
          style: AppTextStyles.bodyS(),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _FooterSocial(
                icon: FontAwesomeIcons.linkedin, url: AppStrings.linkedIn),
            const SizedBox(width: 10),
            _FooterSocial(
                icon: FontAwesomeIcons.twitter, url: AppStrings.twitter),
            const SizedBox(width: 10),
            _FooterSocial(
                icon: FontAwesomeIcons.instagram, url: AppStrings.instagram),
            const SizedBox(width: 10),
            _FooterSocial(
                icon: FontAwesomeIcons.github, url: AppStrings.github),
          ],
        ),
      ],
    );
  }
}

class _FooterSocial extends StatefulWidget {
  final IconData icon;
  final String url;
  const _FooterSocial({required this.icon, required this.url});

  @override
  State<_FooterSocial> createState() => _FooterSocialState();
}

class _FooterSocialState extends State<_FooterSocial> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primaryLight.withOpacity(0.15)
              : AppColors.bgCardLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: _hovered
                  ? AppColors.primaryLight.withOpacity(0.4)
                  : AppColors.border),
        ),
        child: Icon(widget.icon,
            color: _hovered ? AppColors.primaryLight : AppColors.textSubtle,
            size: 14),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FooterLinks({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h3()),
        const SizedBox(height: 16),
        ...links.map((l) => _FooterLink(label: l)),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          widget.label,
          style: AppTextStyles.bodyS(
              color: _hovered ? AppColors.primaryLight : AppColors.textSubtle),
        ),
      ),
    );
  }
}

class _FooterContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact', style: AppTextStyles.h3()),
        const SizedBox(height: 16),
        _ContactLine(icon: FontAwesomeIcons.phone, text: AppStrings.phone),
        const SizedBox(height: 10),
        _ContactLine(icon: FontAwesomeIcons.envelope, text: AppStrings.email),
        const SizedBox(height: 10),
        _ContactLine(
            icon: FontAwesomeIcons.locationDot, text: AppStrings.address),
      ],
    );
  }
}

class _ContactLine extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 14),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppTextStyles.bodyS())),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              '© ${DateTime.now().year} App Intelligence Softwares. All rights reserved.',
              style: AppTextStyles.caption()),
          Text('Made with ❤️ in Tamil Nadu', style: AppTextStyles.caption()),
        ],
      ),
    );
  }
}
