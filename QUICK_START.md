# Quick Start Guide - Search & List View

## Prerequisites

- Flutter SDK 3.10.4 or later
- Dart SDK 3.10.4 or later
- iOS Simulator, Android Emulator, or physical device

## Installation

### 1. Navigate to Project Directory
```bash
cd /Users/andrewmavliev/mynet-mobile
```

### 2. Install Dependencies
```bash
flutter pub get
```

This will install:
- flutter_riverpod (state management)
- intl (date/time formatting)
- flutter_staggered_animations (UI animations)
- And other dependencies

### 3. Verify Installation
```bash
flutter doctor
```

Ensure all checks pass.

## Running the App

### On iOS Simulator
```bash
flutter run -d ios
```

### On Android Emulator
```bash
flutter run -d android
```

### On Chrome (Web)
```bash
flutter run -d chrome
```

### On macOS Desktop
```bash
flutter run -d macos
```

## Features to Test

### 1. Search Functionality
- Tap the search bar at the top
- Type a contact name (e.g., "Sarah")
- Results update in real-time after 300ms debounce
- Tap the X button to clear search

### 2. Filter by Connection Degree
- Tap any of the degree chips (1°, 2°, 3°)
- List filters to show only that degree
- Tap again to deselect
- Notice the filter count badge on the filter icon

### 3. Advanced Filters
- Tap the filter icon in the top right
- Opens bottom sheet with advanced options
- Try filtering by:
  - Company (TechCorp, StartupX, etc.)
  - Location (San Francisco, New York, etc.)
  - Last interaction date
  - Tags
- Tap "Apply" to apply filters
- Tap "Clear All" to reset

### 4. Sort Options
- Tap "Sort: Recent" dropdown
- Select different sort options:
  - Recent (by last interaction)
  - Name (A-Z)
  - Name (Z-A)
  - Company
  - Connection degree

### 5. Contact Card Interactions
- **Tap** a contact card → Shows navigation message
- **Long press** a contact card → Opens quick actions menu
  - Call
  - Email
  - Add Note
- **Swipe right** → Quick call action
- **Swipe left** → Quick email action

### 6. Pull to Refresh
- Pull down on the contact list
- Shows refresh indicator
- Displays "Contacts synced" message

### 7. FAB (Floating Action Button)
- Tap the green + button in bottom right
- Shows "Add Contact" message

### 8. Empty States
- Search for "NonExistent"
- See empty state with "No contacts match your search"
- Tap "Clear filters" to restore list

## Mock Data

The app includes 8 sample contacts:

1. **Sarah Johnson** - VP Engineering @ TechCorp (1°)
2. **Michael Chen** - Product Manager @ StartupX (2°)
3. **Emily Rodriguez** - CTO @ FinanceAI (1°)
4. **David Park** - Sr. Software Engineer @ BigCo Inc (3°)
5. **Jessica Williams** - Design Lead @ Creative Studios (1°)
6. **Alex Thompson** - Data Scientist @ DataCorp (2°)
7. **Maria Garcia** - Marketing Director @ GrowthCo (1°)
8. **James Anderson** - DevOps Engineer @ CloudTech (2°)

## Project Structure

```
lib/
├── models/              # Data models
│   ├── connection_degree.dart
│   ├── contact.dart
│   └── filter_state.dart
├── providers/           # Riverpod state providers
│   └── search_provider.dart
├── screens/             # Main screens
│   └── home_screen.dart
├── theme/               # Material Design 3 theme
│   └── app_theme.dart
├── widgets/             # Reusable widgets
│   ├── contact_card.dart
│   ├── filter_bottom_sheet.dart
│   └── search_bar_widget.dart
└── main.dart           # App entry point
```

## Key Files

### Main Entry Point
- `/Users/andrewmavliev/mynet-mobile/lib/main.dart`

### Home Screen
- `/Users/andrewmavliev/mynet-mobile/lib/screens/home_screen.dart`

### Contact Card Widget
- `/Users/andrewmavliev/mynet-mobile/lib/widgets/contact_card.dart`

### Search Provider (Mock Data)
- `/Users/andrewmavliev/mynet-mobile/lib/providers/search_provider.dart`

## Customization

### Change Mock Data
Edit `/Users/andrewmavliev/mynet-mobile/lib/providers/search_provider.dart`

Find the `mockContactsProvider` and modify the contact list.

### Change Theme Colors
Edit `/Users/andrewmavliev/mynet-mobile/lib/theme/app_theme.dart`

Modify the color constants:
```dart
static const Color primary = Color(0xFF1976D2);  // Primary blue
static const Color secondary = Color(0xFF4CAF50); // Secondary green
```

### Toggle Dark Mode
The app automatically follows system theme settings. To test:
- **iOS:** Settings → Display & Brightness → Dark
- **Android:** Settings → Display → Dark theme
- **macOS:** System Preferences → Appearance → Dark

## Troubleshooting

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

### Dependency Issues
```bash
flutter pub upgrade
```

### Clear Cache
```bash
flutter clean
rm -rf build/
flutter pub get
```

### Hot Reload Not Working
Press `r` in terminal or cmd+\ (Mac) / ctrl+\ (Windows/Linux)

### Performance Issues
Run in release mode:
```bash
flutter run --release
```

## Next Steps

1. **Database Integration**: Replace mock data with SQLite queries
2. **Profile Detail Screen**: Implement full contact profile view
3. **Add Contact Flow**: Implement contact creation
4. **Voice Search**: Add voice input functionality
5. **Grid View**: Implement grid layout option

## Documentation

- **Implementation Details**: `SEARCH_VIEW_README.md`
- **Summary**: `IMPLEMENTATION_SUMMARY.md`
- **UI Spec**: `docs/UI_UX_SPEC.md`

## Support

For issues or questions, refer to:
- Flutter documentation: https://docs.flutter.dev
- Riverpod documentation: https://riverpod.dev
- Material Design 3: https://m3.material.io

## Development Mode Features

### Hot Reload
Make changes to any Dart file and press `r` to hot reload instantly.

### Debug Menu (Flutter DevTools)
1. Run app in debug mode
2. Press `p` for widget inspector
3. Press `h` for widget hierarchy
4. Press `o` for performance overlay

### Inspect Widget Tree
```bash
flutter run --observatory-port=8888
```
Then open Flutter DevTools in browser.

---

**Last Updated:** 2025-12-19
**Version:** 1.0.0
**Status:** Ready for Development
