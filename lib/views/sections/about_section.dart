// lib/views/sections/about_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../utils/app_data.dart';
import '../../responsive/responsive_helper.dart';
import '../../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);
    return Container(
      color: const Color(0xFF080D18),
      padding: EdgeInsets.symmetric(
        horizontal: rh.horizontalPadding,
        vertical: rh.sectionPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            children: [
              SectionHeader(
                label: 'About Us',
                title: 'Who We Are',
                subtitle:
                    'A passionate team of engineers, designers and strategists building tomorrow\'s technology today.',
              ),
              const SizedBox(height: 64),
              rh.isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
              const SizedBox(height: 64),
              _TestimonialsRow(isMobile: rh.isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _AboutContent()),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: _TeamGrid()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _AboutContent(),
        const SizedBox(height: 40),
        _TeamGrid(),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Building the Future,\nOne Product at a Time.',
            style: AppTextStyles.displayM(),
          ),
          const SizedBox(height: 24),
          Text(
            'App Intelligence Softwares was founded with a single mission: make world-class technology accessible to every business. Based in Tiruchirappalli, Tamil Nadu, we serve clients across India and beyond.',
            style: AppTextStyles.bodyM(),
          ),
          const SizedBox(height: 16),
          Text(
            'Our multidisciplinary team combines deep engineering expertise with design thinking to build products that are not just functional — but delightful to use.',
            style: AppTextStyles.bodyM(),
          ),
          const SizedBox(height: 32),

          // Values
          ...const [
            _ValueRow(
                icon: FontAwesomeIcons.lightbulb,
                title: 'Innovation First',
                desc: 'We embrace cutting-edge tech to solve real problems.'),
            _ValueRow(
                icon: FontAwesomeIcons.handshake,
                title: 'Client Partnership',
                desc:
                    'Your success is our success — we\'re with you every step.'),
            _ValueRow(
                icon: FontAwesomeIcons.shieldHalved,
                title: 'Quality Assured',
                desc:
                    'Rigorous testing and code reviews ensure production-grade output.'),
          ],
          const SizedBox(height: 32),

          // Tech stack
          Text('Our Tech Stack', style: AppTextStyles.h3()),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: AppData.techStack
                .map((t) => _TechBadge(
                      label: t['name'] as String,
                      icon: t['icon'] as IconData,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _ValueRow(
      {required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.glassGradient,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 16),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3()),
                const SizedBox(height: 4),
                Text(desc, style: AppTextStyles.bodyS()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _TechBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.bgCardLight,
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryLight, size: 13),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.caption(color: AppColors.textLight)),
        ],
      ),
    );
  }
}

class _TeamGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: AppData.team
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _TeamCard(member: e.value, index: e.key),
                ))
            .toList(),
      ),
    );
  }
}

class _TeamCard extends StatefulWidget {
  final dynamic member;
  final int index;
  const _TeamCard({required this.member, required this.index});

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: _hovered
                ? AppColors.primaryLight.withOpacity(0.4)
                : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(m.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.name, style: AppTextStyles.h3()),
                  Text(m.role, style: AppTextStyles.label()),
                  const SizedBox(height: 4),
                  Text(m.description, style: AppTextStyles.bodyS()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestimonialsRow extends StatelessWidget {
  final bool isMobile;
  const _TestimonialsRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(label: 'Testimonials', title: 'What Clients Say'),
        const SizedBox(height: 40),
        isMobile
            ? Column(
                children: AppData.testimonials
                    .map((t) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _TestimonialCard(t: t),
                        ))
                    .toList(),
              )
            : Row(
                children: AppData.testimonials
                    .map((t) => Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _TestimonialCard(t: t),
                        )))
                    .toList(),
              ),
      ],
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Map<String, String> t;
  const _TestimonialCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: List.generate(
                  int.parse(t['rating']!),
                  (_) => const Icon(Icons.star_rounded,
                      color: Color(0xFFFBBF24), size: 16))),
          const SizedBox(height: 12),
          Text(t['review']!, style: AppTextStyles.bodyS()),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle),
                child: Center(
                    child: Text(t['name']![0],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t['name']!,
                      style: AppTextStyles.bodyS(color: AppColors.textWhite)),
                  Text(t['company']!, style: AppTextStyles.caption()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
