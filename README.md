<div align="center">

# 📱 Hospital App — Flutter Mobile

[![Flutter](https://img.shields.io/badge/Flutter-3.16-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.2-blue?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/zuhudo/hospital-app-mobile/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/zuhudo/hospital-app-mobile/actions/workflows/flutter-ci.yml)

Cross-platform mobile app for the Hospital & Patient Management System.

[🌐 Website](https://github.com/zuhudo/hospital-app-web) • [⚙️ Backend](https://github.com/zuhudo/hospital-app-backend) • [📊 Dashboard](https://github.com/zuhudo/hospital-app-dashboard) • [📖 Wiki](https://github.com/zuhudo/hospital-app-mobile/wiki)

</div>

## 📋 Features

- 🔐 **Authentication** — Login & registration with JWT
- 🏠 **Home Dashboard** — Stats, quick actions, today's appointments
- 👥 **Patient Management** — List, search, view details
- 📅 **Appointments** — Book with calendar, view upcoming/completed/cancelled
- 👨‍⚕️ **Doctor Directory** — Browse by specialization, book appointments
- 📋 **Medical Records** — View history, prescriptions, lab results
- 👤 **Profile** — Settings, notifications, logout
- 🎨 **Material Design 3** — Teal/blue medical theme

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.2+
- iOS Simulator / Android Emulator / Physical device

### Installation

```bash
# Clone the repo
git clone https://github.com/zuhudo/hospital-app-mobile.git
cd hospital-app-mobile

# Install dependencies
flutter pub get

# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android
```

### Build

```bash
# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── config/          # Theme, routes, constants
├── models/          # Data models (Patient, Doctor, Appointment, etc.)
├── screens/         # UI screens
│   ├── auth/        # Login, Register
│   ├── home/        # Dashboard
│   ├── patients/    # Patient list & detail
│   ├── appointments/# Appointment list & booking
│   ├── doctors/     # Doctor directory
│   └── profile/     # User profile
├── widgets/         # Reusable UI components
├── services/        # API, Auth, Storage services
└── providers/       # State management
```

## 🛠️ Tech Stack

- **Flutter** 3.16 — Cross-platform framework
- **Dart** 3.2 — Programming language
- **Provider** — State management
- **GoRouter** — Navigation
- **fl_chart** — Charts & graphs
- **Google Fonts** — Typography
- **shared_preferences** — Local storage
- **http** — API client

## 📖 Documentation

- [Getting Started](https://github.com/zuhudo/hospital-app-mobile/wiki/Getting-Started)
- [Architecture](https://github.com/zuhudo/hospital-app-mobile/wiki/Architecture)
- [Screens Guide](https://github.com/zuhudo/hospital-app-mobile/wiki/Screens)
- [Theming](https://github.com/zuhudo/hospital-app-mobile/wiki/Theming)

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
