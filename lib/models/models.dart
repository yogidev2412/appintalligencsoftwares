// lib/models/service_model.dart
import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final String description;
  final IconData icon;
  final List<String> features;
  final Color gradientStart;
  final Color gradientEnd;

  const ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

// lib/models/portfolio_model.dart
class PortfolioModel {
  final String title;
  final String category;
  final String description;
  final String tech;
  final IconData icon;
  final Color color;

  const PortfolioModel({
    required this.title,
    required this.category,
    required this.description,
    required this.tech,
    required this.icon,
    required this.color,
  });
}

// lib/models/stat_model.dart
class StatModel {
  final String value;
  final String label;
  final IconData icon;

  const StatModel({
    required this.value,
    required this.label,
    required this.icon,
  });
}

// lib/models/team_model.dart
class TeamModel {
  final String name;
  final String role;
  final String description;
  final IconData icon;

  const TeamModel({
    required this.name,
    required this.role,
    required this.description,
    required this.icon,
  });
}
