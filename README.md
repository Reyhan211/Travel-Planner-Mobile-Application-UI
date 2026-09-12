# Travel Planner App

A Travel Planner UI application, built as a group assignment. Developed using Flutter to demonstrate a complete travel app flow, from authentication, destination exploration, to personal trip management and currency conversion.

## Tech Stack

| Category | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) |
| Language | [Dart](https://dart.dev) |
| IDE / Tools | Android Studio |
| Font | Google Fonts (Poppins) |
| Plugin | `image_picker` (profile photo upload) |

## Features

- **Splash Screen** — opening screen with an automatic transition to the register page.
- **Register & Sign In** — authentication forms (UI only, not yet connected to a backend).
- **Explore** — main screen for browsing travel destinations.
- **Destination Detail** — full details for a destination selected from Explore.
- **Hotels** — list of recommended places to stay.
- **Restaurants** — list of recommended places to eat.
- **My Trips** — manage a personal list of trips, including an empty state when no trips exist yet.
- **Currency Converter** — numpad-style currency conversion calculator.
- **Profile** — user profile screen with photo upload support (via `image_picker`).

## Folder Structure

```
lib/
├── main.dart                  # App entry point
├── data/                      # Dummy data (destinations, trips, currencies)
├── theme/                     # App color and theme configuration
├── screens/                   # All main app screens
│   ├── splash_screen.dart
│   ├── register_screen.dart
│   ├── signin_screen.dart
│   ├── explore_screen.dart
│   ├── destination_detail_screen.dart
│   ├── hotels_screen.dart
│   ├── restaurants_screen.dart
│   ├── my_trips_screen.dart
│   ├── currency_converter_screen.dart
│   └── profile_screen.dart
└── widgets/                   # Reusable components (buttons, text fields, nav bar, etc.)
```

## Getting Started

1. **Clone / extract** this project.
2. Make sure the [Flutter SDK](https://docs.flutter.dev/get-started/install) is installed.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app (an emulator or physical device must be connected):
   ```bash
   flutter run
   ```

Android Studio is recommended for a better development and UI preview experience.

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  google_fonts: ^8.2.1
  image_picker: ^1.1.2
```

## Notes

This project is a group assignment focused on implementing UI/UX with Flutter. Most of the data (destinations, trips, prices) is currently dummy data and is not yet connected to a real backend or API.

---

Built with Flutter.s