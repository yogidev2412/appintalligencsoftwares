// lib/utils/app_data.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/models.dart';

class AppData {
  AppData._();

  // ── Services ─────────────────────────────
  static const List<ServiceModel> services = [
    ServiceModel(
      title: 'Android Development',
      description:
          'Native and cross-platform Android apps with Kotlin & Flutter. High-performance, scalable solutions for all Android devices.',
      icon: FontAwesomeIcons.android,
      features: [
        'Native Kotlin/Java',
        'Flutter Cross-platform',
        'Material Design 3',
        'Play Store Deployment'
      ],
      gradientStart: Color(0xFF2563EB),
      gradientEnd: Color(0xFF1D4ED8),
    ),
    ServiceModel(
      title: 'iOS Development',
      description:
          'Elegant iOS applications crafted with Swift & Flutter. Seamless App Store experiences optimised for iPhone & iPad.',
      icon: FontAwesomeIcons.apple,
      features: [
        'Swift / SwiftUI',
        'Flutter Cross-platform',
        'Apple HIG Design',
        'App Store Launch'
      ],
      gradientStart: Color(0xFF7C3AED),
      gradientEnd: Color(0xFF4F46E5),
    ),
    ServiceModel(
      title: 'Web Development',
      description:
          'Responsive, fast-loading websites and web apps using modern frameworks. From landing pages to enterprise portals.',
      icon: FontAwesomeIcons.globe,
      features: [
        'React / Next.js',
        'Flutter Web',
        'Progressive Web Apps',
        'SEO Optimisation'
      ],
      gradientStart: Color(0xFF06B6D4),
      gradientEnd: Color(0xFF0284C7),
    ),
    ServiceModel(
      title: 'SaaS Products',
      description:
          'End-to-end SaaS platform development with multi-tenancy, subscription billing, and cloud-native architecture.',
      icon: FontAwesomeIcons.cloud,
      features: [
        'Multi-tenancy',
        'Stripe Billing',
        'Analytics Dashboard',
        'CI/CD Pipeline'
      ],
      gradientStart: Color(0xFF059669),
      gradientEnd: Color(0xFF0D9488),
    ),
    ServiceModel(
      title: 'AI Solutions',
      description:
          'Intelligent automation, ML models, chatbots, and AI-powered features integrated seamlessly into your products.',
      icon: FontAwesomeIcons.brain,
      features: [
        'LLM Integration',
        'Custom ML Models',
        'AI Chatbots',
        'Computer Vision'
      ],
      gradientStart: Color(0xFFDB2777),
      gradientEnd: Color(0xFF9333EA),
    ),
    ServiceModel(
      title: 'Digital Marketing',
      description:
          'Data-driven digital marketing strategies — SEO, social media, PPC campaigns, and growth hacking for maximum ROI.',
      icon: FontAwesomeIcons.chartLine,
      features: [
        'SEO & SEM',
        'Social Media',
        'PPC Campaigns',
        'Analytics & Reporting'
      ],
      gradientStart: Color(0xFFF59E0B),
      gradientEnd: Color(0xFFEF4444),
    ),
  ];

  // ── Portfolio ────────────────────────────
  static const List<PortfolioModel> portfolio = [
    PortfolioModel(
      title: 'MediTrack AI',
      category: 'AI Solution',
      description:
          'AI-powered healthcare management platform with predictive diagnostics and patient tracking.',
      tech: 'Flutter • FastAPI • TensorFlow',
      icon: FontAwesomeIcons.heartPulse,
      color: Color(0xFFDB2777),
    ),
    PortfolioModel(
      title: 'RetailFlow SaaS',
      category: 'SaaS Product',
      description:
          'Multi-tenant inventory and POS system serving 500+ retail businesses across South India.',
      tech: 'React • Node.js • PostgreSQL',
      icon: FontAwesomeIcons.store,
      color: Color(0xFF059669),
    ),
    PortfolioModel(
      title: 'EduLeap App',
      category: 'Mobile App',
      description:
          'E-learning platform with adaptive quizzes, live classes and gamified progress for K-12 students.',
      tech: 'Flutter • Firebase • Dart',
      icon: FontAwesomeIcons.graduationCap,
      color: Color(0xFF7C3AED),
    ),
    PortfolioModel(
      title: 'LogiTrack Pro',
      category: 'Web Platform',
      description:
          'Real-time logistics tracking dashboard with route optimisation and driver management.',
      tech: 'Next.js • Django • Redis',
      icon: FontAwesomeIcons.truck,
      color: Color(0xFF06B6D4),
    ),
    PortfolioModel(
      title: 'FinBot Assistant',
      category: 'AI Chatbot',
      description:
          'Conversational AI for personal finance — expense tracking, budget advice, and investment tips.',
      tech: 'Flutter • OpenAI • Python',
      icon: FontAwesomeIcons.robot,
      color: Color(0xFF2563EB),
    ),
    PortfolioModel(
      title: 'BrandPulse',
      category: 'Digital Marketing',
      description:
          'Unified social media analytics and scheduling tool with AI-generated content suggestions.',
      tech: 'React • GraphQL • AWS',
      icon: FontAwesomeIcons.chartBar,
      color: Color(0xFFF59E0B),
    ),
  ];

  // ── Stats ────────────────────────────────
  static const List<StatModel> stats = [
    StatModel(
        value: '9+',
        label: 'Projects Delivered',
        icon: FontAwesomeIcons.rocket),
    StatModel(
        value: '4+', label: 'Happy Clients', icon: FontAwesomeIcons.faceSmile),
    StatModel(
        value: '3+',
        label: 'Years Experience',
        icon: FontAwesomeIcons.calendarCheck),
    StatModel(value: '4+', label: 'Team Members', icon: FontAwesomeIcons.users),
  ];

  // ── Team ─────────────────────────────────
  static const List<TeamModel> team = [
    TeamModel(
      name: 'Yogeshwaran',
      role: 'CEO & Founder',
      description:
          'Full-stack architect with 2+ years building scalable software products.',
      icon: FontAwesomeIcons.userTie,
    ),
    TeamModel(
      name: 'Yuva Dharshini',
      role: 'Head of Design',
      description:
          'UI/UX specialist crafting beautiful, intuitive digital experiences.',
      icon: FontAwesomeIcons.penNib,
    ),
    // TeamModel(
    //   name: 'Vikram S.',
    //   role: 'Lead AI Engineer',
    //   description:
    //       'ML researcher integrating cutting-edge AI into real-world products.',
    //   icon: FontAwesomeIcons.brain,
    // ),
  ];

  // ── Testimonials ─────────────────────────
  static const List<Map<String, String>> testimonials = [
    {
      'name': 'Aravind',
      'company': 'Solgen Enery Solution India',
      'review':
          'AI Softwares delivered our SaaS platform on time with exceptional quality. Their team is responsive, technically brilliant and a joy to work with.',
      'rating': '5',
    },
    // {
    //   'name': 'Divya M.',
    //   'company': 'EduPath Startup',
    //   'review':
    //       'They built our e-learning app from scratch. The Flutter code is clean, the UI is beautiful, and they genuinely care about the product outcome.',
    //   'rating': '5',
    // },
    // {
    //   'name': 'Suresh K.',
    //   'company': 'RetailMax Chain',
    //   'review':
    //       'Their AI integration transformed how we manage inventory. ROI was visible within the first month. Highly recommend for any ambitious project.',
    //   'rating': '5',
    // },
  ];

  // ── Tech Stack ───────────────────────────
  static const List<Map<String, dynamic>> techStack = [
    {'name': 'Flutter', 'icon': FontAwesomeIcons.mobile},
    {'name': 'React', 'icon': FontAwesomeIcons.react},
    {'name': 'Python', 'icon': FontAwesomeIcons.python},
    {'name': 'Firebase', 'icon': FontAwesomeIcons.fire},
    {'name': 'AWS', 'icon': FontAwesomeIcons.aws},
    {'name': 'TensorFlow', 'icon': FontAwesomeIcons.brain},
    {'name': 'Node.js', 'icon': FontAwesomeIcons.nodeJs},
    {'name': 'Docker', 'icon': FontAwesomeIcons.docker},
  ];
}
