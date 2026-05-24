// lib/views/sections/services_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../utils/app_data.dart';
import '../../models/models.dart';
import '../../responsive/responsive_helper.dart';
import '../../widgets/section_header.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rh = ResponsiveHelper(context);

    return Container(
      color: AppColors.bgDark,
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
                label: 'What We Do',
                title: 'Our Services',
                subtitle:
                    'End-to-end technology solutions crafted to help your business grow, scale and lead.',
              ),
              const SizedBox(height: 64),
              _ServicesGrid(crossAxisCount: rh.servicesCrossAxisCount),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  final int crossAxisCount;
  const _ServicesGrid({required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: crossAxisCount == 1 ? 1.6 : 0.85,
      ),
      itemCount: AppData.services.length,
      itemBuilder: (context, i) => FadeInUp(
        delay: Duration(milliseconds: 100 * i),
        duration: const Duration(milliseconds: 600),
        child: _ServiceCard(service: AppData.services[i]),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;
  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(
            color:
                _hovered ? s.gradientStart.withOpacity(0.5) : AppColors.border,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: s.gradientStart.withOpacity(0.2), blurRadius: 30)
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [s.gradientStart, s.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                              color: s.gradientStart.withOpacity(0.4),
                              blurRadius: 20)
                        ]
                      : [],
                ),
                child: Icon(s.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 20),

              // Title
              Text(s.title, style: AppTextStyles.h3()),
              const SizedBox(height: 8),

              // Description
              Expanded(
                child: Text(s.description, style: AppTextStyles.bodyS()),
              ),
              const SizedBox(height: 16),

              // Feature tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: s.features
                    .map((f) => _FeatureTag(label: f, color: s.gradientStart))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTag extends StatelessWidget {
  final String label;
  final Color color;
  const _FeatureTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(label, style: AppTextStyles.caption(color: color)),
    );
  }
}
