# ToYouNet - External Database Configuration Guide

This document explains how to configure the ToYouNet mobile app to read SQLite database files from external storage on Android devices.

## Overview

The app has been modified to:
- Read database files from external storage (not bundled in the app)
- Support custom database file paths
- Access databases from `/storage/emulated/0/ToYouJAN/` directory
- Allow users to select database files via file picker

## Changes Made

### 1. App Rebranding
- **App Name:** Changed from "myNET Mobile" to "ToYouNet"
- **Package Name:** Changed to `com.toyounet.app`
- **Title:** Updated throughout the app

### 2. Dependencies Added
The following packages were added to `pubspec.yaml`:
- `file_picker: ^8.0.0+1` - For selecting database files
- `shared_preferences: ^2.2.2` - For storing database path
- `permission_handler: ^11.3.0` - For requesting storage permissions

### 3. Storage Permissions
Added to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" android:minSdkVersion="30" />
```

### 4. Database Service Modifications
`lib/services/database_service.dart` now:
- Reads databases from external storage instead of assets
- Supports configurable database paths via SharedPreferences
- Auto-detects databases in default locations
- Provides methods to reload and switch databases
- No longer copies database from assets

### 5. Settings Screen
New `lib/screens/settings_screen.dart` provides:
- Database path display and configuration
- File picker for selecting custom database locations
- Database statistics (profile count, size, etc.)
- Reload database functionality
- Reset to default path option
- Storage permission management

## Setup Instructions

### For Users

#### Option 1: Default Path (Recommended)
1. Create the directory on your Android device:
   ```
   /storage/emulated/0/ToYouJAN/
   ```

2. Place your database file in this directory with one of these names:
   - `myNET.db` (preferred)
   - `JAT.db` (alternative)

3. Install and launch the ToYouNet app
4. Grant storage permissions when prompted
5. The app will automatically detect and load your database

#### Option 2: Custom Path
1. Place your database file anywhere on your device
2. Launch the ToYouNet app
3. Tap the **Settings** icon in the top-right corner
4. Tap **Select Database File**
5. Grant storage permissions if prompted
6. Navigate to your database file and select it
7. The app will load and remember this location

### For Developers

#### Building the App

1. Install dependencies:
   ```bash
   cd /Users/andrewmavliev/mynet-mobile
   flutter pub get
   ```

2. Build for Android:
   ```bash
   flutter build apk --release
   # Or for app bundle:
   flutter build appbundle --release
   ```

3. Install on device:
   ```bash
   flutter install
   # Or:
   flutter run --release
   ```

#### Testing Database Loading

1. **Test default path detection:**
   - Place `myNET.db` at `/storage/emulated/0/ToYouJAN/myNET.db`
   - Launch app
   - Verify it loads automatically

2. **Test custom path selection:**
   - Go to Settings
   - Tap "Select Database File"
   - Choose a database file
   - Verify stats are displayed

3. **Test error handling:**
   - Launch app without database file
   - Should see helpful error message
   - Go to Settings to configure path

## Database Compatibility

The app expects SQLite databases with the following schema:
- `linkedin_profiles` table
- `booth_profiles` table
- `connections` table
- `profile_notes` table
- `profile_interactions` table
- `tags` table
- Various views (e.g., `v_follow_ups_pending`)

Databases from the job search automation project (JAT.db or myNET.db) are compatible.

## File Structure

```
/Users/andrewmavliev/mynet-mobile/
├── lib/
│   ├── main.dart                      # Updated app title
│   ├── services/
│   │   └── database_service.dart      # Modified for external storage
│   ├── screens/
│   │   ├── home_screen.dart           # Added settings button
│   │   └── settings_screen.dart       # NEW: Database configuration UI
│   └── providers/
│       └── database_provider.dart     # Uses DatabaseService
├── android/
│   └── app/
│       ├── build.gradle.kts           # Updated package name
│       └── src/main/
│           └── AndroidManifest.xml    # Added storage permissions
└── pubspec.yaml                       # Updated dependencies and removed assets
```

## Troubleshooting

### App crashes on launch
**Cause:** Database file not found
**Solution:**
- Check database file exists at `/storage/emulated/0/ToYouJAN/myNET.db`
- Or use Settings to select a custom database file
- Grant storage permissions when prompted

### "Database file not found" error
**Cause:** File doesn't exist at expected path
**Solution:**
- Verify file path is correct
- Check file is named `myNET.db` or `JAT.db`
- Ensure storage permissions are granted
- Use Settings screen to select custom path

### Storage permission denied
**Cause:** User didn't grant storage permissions
**Solution:**
- Go to Android Settings > Apps > ToYouNet > Permissions
- Enable Storage or Files and Media permissions
- For Android 11+, may need to enable "All files access"

### Database stats not showing
**Cause:** Database schema doesn't match expected structure
**Solution:**
- Verify database has required tables
- Check database isn't corrupted
- Try with known-good database file

## Security Considerations

### Read/Write Mode
By default, the app opens databases in **read-write mode**. To prevent accidental modifications:

Edit `lib/services/database_service.dart` line ~90:
```dart
final db = await openDatabase(
  dbPath,
  version: 1,
  onCreate: _createDB,
  onConfigure: _onConfigure,
  onOpen: _onOpen,
  readOnly: true,  // Uncomment this line for read-only mode
);
```

### Database Backups
The app reads from the original database file on external storage. Consider:
- Keeping backups of your database files
- Using the export functionality if available
- Testing changes on a copy first

## Advanced Configuration

### Changing Default Paths
Edit `lib/services/database_service.dart` to change default paths:
```dart
// Around line 55
if (dbPath == null || dbPath.isEmpty) {
  dbPath = '/storage/emulated/0/YourCustomPath/yourdb.db';

  if (!await File(dbPath).exists()) {
    final altPath = '/storage/emulated/0/AlternativePath/altdb.db';
    if (await File(altPath).exists()) {
      dbPath = altPath;
    }
  }
}
```

### Customizing Error Messages
Edit the error message in `database_service.dart` around line 71:
```dart
throw DatabaseException(
  'Your custom error message here...',
);
```

## Migration from Bundled Database

If you have an older version of the app with bundled databases:

1. **Export existing data** (if needed):
   - Old app stores database in app's private directory
   - Path: `/data/data/com.mavliev.mynet_mobile/databases/myNET.db`
   - Requires root access or adb to extract

2. **Transfer to external storage:**
   ```bash
   # Using adb
   adb pull /data/data/com.mavliev.mynet_mobile/databases/myNET.db .
   adb push myNET.db /storage/emulated/0/ToYouJAN/myNET.db
   ```

3. **Install new version:**
   - Uninstall old app
   - Install ToYouNet
   - App will find database in external storage

## Version Information

- **App Version:** 1.0.0+1
- **Flutter SDK:** ^3.10.4
- **Minimum Android SDK:** As per flutter.minSdkVersion
- **Target Android SDK:** As per flutter.targetSdkVersion

## Support

For issues or questions:
1. Check Settings screen for database path and stats
2. Verify storage permissions are granted
3. Check database file exists and is readable
4. Review app logs for detailed error messages

## Future Enhancements

Potential improvements:
- [ ] Database sync between devices
- [ ] Cloud database support
- [ ] Automatic database backups
- [ ] Database encryption
- [ ] Multiple database profiles
- [ ] Database validation on load
- [ ] Migration tools for schema updates
