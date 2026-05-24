// lib/views/sections/portfolio_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../utils/app_data.dart';
import '../../models/models.dart';
import '../../responsive/responsive_helper.dart';
import '../../widgets/section_header.dart';
import '../../widgets/custom_button.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

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
                label:    'Our Work',
                title:    'Featured Projects',
                subtitle: 'A selection of products we\'ve built — from AI healthcare tools to enterprise SaaS platforms.',
              ),
              const SizedBox(height: 64),
              _PortfolioGrid(crossAxisCount: rh.gridCrossAxisCount),
              const SizedBox(height: 48),
              FadeInUp(
                child: CustomButton(
                  label:    'View All Projects',
                  variant:  ButtonVariant.outlined,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioGrid extends StatelessWidget {
  final int crossAxisCount;
  const _PortfolioGrid({required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: crossAxisCount == 1 ? 1.5 : 1.0,
      ),
      itemCount: AppData.portfolio.length,
      itemBuilder: (context, i) => FadeInUp(
        delay: Duration(milliseconds: 100 * i),
        duration: const Duration(milliseconds: 600),
        child: _PortfolioCard(item: AppData.portfolio[i]),
      ),
    );
  }
}

class _PortfolioCard extends StatefulWidget {
  final PortfolioModel item;
  const _PortfolioCard({required this.item});

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(
            color: _hovered ? item.color.withOpacity(0.4) : AppColors.border,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: item.color.withOpacity(0.15), blurRadius: 30)]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          child: Stack(
            children: [
              // Background color wash
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: _hovered ? 0.06 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(color: item.color),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: item.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: item.color.withOpacity(0.3)),
                          ),
                          child: Icon(item.icon, color: item.color, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: AppTextStyles.h3()),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item.color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(item.category, style: AppTextStyles.caption(color: item.color)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Text(item.description, style: AppTextStyles.bodyS()),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.code_rounded, color: AppColors.textSubtle, size: 14),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(item.tech, style: AppTextStyles.caption()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow on hover
              Positioned(
                top: 16, right: 16,
                child: AnimatedOpacity(
                  opacity: _hovered ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_outward, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
