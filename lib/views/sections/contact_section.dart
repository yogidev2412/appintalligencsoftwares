// lib/views/sections/contact_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_constants.dart';
import '../../utils/text_styles.dart';
import '../../responsive/responsive_helper.dart';
import '../../widgets/section_header.dart';
import '../../widgets/custom_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
                label:    'Get In Touch',
                title:    'Start Your Project',
                subtitle: 'Tell us about your idea and we\'ll get back to you within 24 hours.',
              ),
              const SizedBox(height: 64),
              rh.isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 4, child: _ContactInfo()),
                        const SizedBox(width: 60),
                        Expanded(flex: 6, child: _ContactForm()),
                      ],
                    )
                  : Column(
                      children: [
                        const _ContactInfo(),
                        const SizedBox(height: 40),
                        _ContactForm(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Let\'s Build Something\nAmazing Together', style: AppTextStyles.displayM()),
          const SizedBox(height: 24),
          Text(
            'Whether it\'s a new app, a SaaS platform, or an AI solution — our team is ready to turn your vision into reality.',
            style: AppTextStyles.bodyM(),
          ),
          const SizedBox(height: 40),

          // Contact details
          _ContactTile(
            icon: FontAwesomeIcons.phone,
            title: 'Call Us',
            value: AppStrings.phone,
            color: AppColors.success,
          ),
          const SizedBox(height: 16),
          _ContactTile(
            icon: FontAwesomeIcons.envelope,
            title: 'Email Us',
            value: AppStrings.email,
            color: AppColors.primaryLight,
          ),
          const SizedBox(height: 16),
          _ContactTile(
            icon: FontAwesomeIcons.locationDot,
            title: 'Location',
            value: AppStrings.address,
            color: AppColors.accent,
          ),

          const SizedBox(height: 40),

          // Social links
          Text('Follow Us', style: AppTextStyles.h3()),
          const SizedBox(height: 16),
          Row(
            children: [
              _SocialButton(icon: FontAwesomeIcons.linkedin,  color: const Color(0xFF0077B5), url: AppStrings.linkedIn),
              const SizedBox(width: 12),
              _SocialButton(icon: FontAwesomeIcons.twitter,   color: const Color(0xFF1DA1F2), url: AppStrings.twitter),
              const SizedBox(width: 12),
              _SocialButton(icon: FontAwesomeIcons.instagram, color: const Color(0xFFE1306C), url: AppStrings.instagram),
              const SizedBox(width: 12),
              _SocialButton(icon: FontAwesomeIcons.github,    color: AppColors.textLight,    url: AppStrings.github),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ContactTile({required this.icon, required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.caption()),
            Text(value, style: AppTextStyles.bodyS(color: AppColors.textLight)),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;

  const _SocialButton({required this.icon, required this.color, required this.url});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: _hovered ? widget.color.withOpacity(0.15) : AppColors.bgCardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? widget.color.withOpacity(0.5) : AppColors.border,
          ),
        ),
        child: Icon(widget.icon, color: _hovered ? widget.color : AppColors.textMuted, size: 16),
      ),
    );
  }
}

// ── Contact Form ─────────────────────────────
class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController    = TextEditingController();
  final _emailController   = TextEditingController();
  final _phoneController   = TextEditingController();
  final _serviceController = TextEditingController();
  final _messageController = TextEditingController();
  bool _loading = false;
  bool _submitted = false;

  String? _selectedService;
  final List<String> _services = [
    'Android Development', 'iOS Development', 'Web Development',
    'SaaS Product', 'AI Solution', 'Digital Marketing', 'Other',
  ];

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() { _loading = false; _submitted = true; });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _serviceController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          border: Border.all(color: AppColors.border),
        ),
        child: _submitted ? _buildSuccessState() : _buildForm(),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.success.withOpacity(0.3)),
          ),
          child: const Icon(Icons.check_rounded, color: AppColors.success, size: 36),
        ),
        const SizedBox(height: 24),
        Text('Message Sent!', style: AppTextStyles.h1()),
        const SizedBox(height: 12),
        Text('Thanks for reaching out. We\'ll get back to you within 24 hours.', style: AppTextStyles.bodyM(), textAlign: TextAlign.center),
        const SizedBox(height: 32),
        CustomButton(
          label:    'Send Another',
          variant:  ButtonVariant.outlined,
          onPressed: () => setState(() => _submitted = false),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send Us a Message', style: AppTextStyles.h2()),
          const SizedBox(height: 8),
          Text('All fields marked * are required.', style: AppTextStyles.caption()),
          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(child: _FormField(controller: _nameController, label: 'Full Name *', hint: 'Your name', icon: Icons.person_outline)),
              const SizedBox(width: 16),
              Expanded(child: _FormField(controller: _emailController, label: 'Email *', hint: 'your@email.com', icon: Icons.email_outlined, isEmail: true)),
            ],
          ),
          const SizedBox(height: 16),
          _FormField(controller: _phoneController, label: 'Phone Number', hint: '+91 XXXXX XXXXX', icon: Icons.phone_outlined),
          const SizedBox(height: 16),
          _ServiceDropdown(
            value: _selectedService,
            services: _services,
            onChanged: (v) => setState(() => _selectedService = v),
          ),
          const SizedBox(height: 16),
          _FormField(
            controller: _messageController,
            label: 'Message *',
            hint: 'Tell us about your project...',
            icon: Icons.message_outlined,
            maxLines: 5,
          ),
          const SizedBox(height: 28),
          CustomButton(
            label:     'Send Message',
            width:     double.infinity,
            height:    52,
            suffixIcon: FontAwesomeIcons.paperPlane,
            isLoading: _loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isEmail;
  final int maxLines;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isEmail = false,
    this.maxLines = 1,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.caption(color: AppColors.textMuted)),
        const SizedBox(height: 6),
        Focus(
          onFocusChange: (v) => setState(() => _focused = v),
          child: TextFormField(
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
            style: AppTextStyles.bodyS(color: AppColors.textLight),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodyS(),
              prefixIcon: Icon(widget.icon, color: _focused ? AppColors.primaryLight : AppColors.textSubtle, size: 18),
              filled: true,
              fillColor: AppColors.bgDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
                borderSide: BorderSide(color: AppColors.primaryLight, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
                borderSide: const BorderSide(color: AppColors.error),
              ),
            ),
            validator: (v) {
              if (widget.label.contains('*') && (v == null || v.isEmpty)) return 'This field is required';
              if (widget.isEmail && v != null && !v.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _ServiceDropdown extends StatelessWidget {
  final String? value;
  final List<String> services;
  final ValueChanged<String?> onChanged;

  const _ServiceDropdown({required this.value, required this.services, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Service Interested In', style: AppTextStyles.caption(color: AppColors.textMuted)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          dropdownColor: AppColors.bgCard,
          style: AppTextStyles.bodyS(color: AppColors.textLight),
          hint: Text('Select a service', style: AppTextStyles.bodyS()),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSubtle),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              borderSide: BorderSide(color: AppColors.primaryLight, width: 1.5),
            ),
          ),
          items: services.map((s) => DropdownMenuItem(
            value: s,
            child: Text(s, style: AppTextStyles.bodyS(color: AppColors.textLight)),
          )).toList(),
        ),
      ],
    );
  }
}
