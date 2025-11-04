# Astrology App - Premium Consultation Platform

A comprehensive cross-platform astrology application built with Flutter and Firebase, connecting users with astrologers for personalized guidance through live chat, voice calls, and video calls.

## Features

- 🔐 Multi-authentication (Email, Google, Phone OTP)
- 👥 Role-based access (Super Admin, Admin, Astrologer, Content Creator, End User)
- 🔮 Automatic Kundli & Varshphal generation
- 💬 Real-time chat system
- 📞 Voice and video calls via Agora.io
- 💳 Secure payments with Razorpay
- 📊 Comprehensive analytics dashboards
- 🌟 Daily horoscopes
- 💰 Wallet & referral system
- 🧠 AI question system (modular)
- 📱 Premium UI with smooth animations

## Architecture

The app follows clean architecture principles:
- `lib/core/` - Core utilities, constants, themes
- `lib/features/` - Feature-based modules
- `lib/shared/` - Shared widgets and services
- `lib/models/` - Data models
- `lib/providers/` - State management (Riverpod)

## Setup

1. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

2. Configure Firebase:
   - Add `google-services.json` (Android) to `android/app/`
   - Add `GoogleService-Info.plist` (iOS) to `ios/Runner/`
   - Configure Firebase in `lib/core/config/firebase_config.dart`

3. Run the app:
   ```bash
   flutter run
   ```

## Testing

Run tests with:
```bash
flutter test
```

## License

Proprietary - All rights reserved

