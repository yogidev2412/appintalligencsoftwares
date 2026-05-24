# App Intelligence Softwares — Flutter Web

A complete, production-ready Flutter Web website for **App Intelligence Softwares**.

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0

### 1. Install dependencies
```bash
flutter pub get
```

### 2. Run in development
```bash
flutter run -d chrome
```

### 3. Build for production
```bash
flutter build web --release --web-renderer canvaskit
```

The output is in `build/web/` — deploy to any static host (Firebase Hosting, Netlify, Vercel, etc).

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point + splash screen
├── utils/
│   ├── app_constants.dart       # Colors, sizes, strings, section keys
│   ├── text_styles.dart         # Centralised typography
│   └── app_data.dart            # All content data
├── models/
│   └── models.dart              # ServiceModel, PortfolioModel, etc.
├── views/
│   ├── home_page.dart           # Page assembler + scroll logic
│   └── sections/
│       ├── hero_section.dart    # Animated hero with rotating words
│       ├── services_section.dart # Service cards grid
│       ├── stats_section.dart   # Animated counters
│       ├── portfolio_section.dart # Project showcase grid
│       ├── about_section.dart   # About + team + testimonials
│       ├── contact_section.dart # Contact form + social links
│       └── footer_section.dart  # Footer + CTA banner
├── widgets/
│   ├── navbar.dart              # Animated sticky navbar + mobile drawer
│   ├── custom_button.dart       # Reusable button with hover effects
│   ├── section_header.dart      # Section titles + GlassCard + GradientText
│   └── scroll_animation_wrapper.dart # Viewport-triggered animations
└── responsive/
    └── responsive_helper.dart   # Breakpoints + layout helpers
```

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Background | `#0A0E1A` |
| Card | `#111827` |
| Primary | `#2563EB` |
| Accent | `#06B6D4` |
| Font | Poppins |

Breakpoints: Mobile < 600px < Tablet < 1024px < Desktop

---

## ✨ Features

- ✅ Animated hero with rotating CTA words
- ✅ Scroll-triggered section animations
- ✅ Sticky navbar with scroll detection
- ✅ Mobile bottom sheet drawer
- ✅ Glassmorphism & gradient cards
- ✅ Hover effects on all interactive elements
- ✅ Animated stat counters
- ✅ Responsive 1/2/3-column grid
- ✅ Contact form with validation
- ✅ Social media links
- ✅ SEO-friendly HTML meta tags
- ✅ Loading splash screen
- ✅ Scroll-to-top FAB

---

## 📞 Company Contact

- **Phone:** +91 6384742409
- **Email:** support.aisoftwares@gmail.com
- **Location:** Tiruchirappalli, Tamil Nadu, India

---

## 🔧 Customisation

1. **Content** — Edit `lib/utils/app_data.dart`
2. **Colors** — Edit `AppColors` in `lib/utils/app_constants.dart`
3. **Typography** — Edit `AppTextStyles` in `lib/utils/text_styles.dart`
4. **Contact info** — Edit `AppStrings` in `lib/utils/app_constants.dart`
