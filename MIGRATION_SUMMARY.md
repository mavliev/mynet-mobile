# ToYouNet Migration Summary

## Changes Completed

### 1. App Rebranding
- **Package name changed:** `mynet_mobile` → `toyounet`
- **App display name changed:** "myNET Mobile" → "ToYouNet"
- **Android package ID changed:** `com.mavliev.mynet_mobile` → `com.toyounet.app`

### 2. Files Modified

#### Configuration Files
- **pubspec.yaml**
  - Changed package name from `mynet_mobile` to `toyounet`
  - Added dependencies: `file_picker`, `shared_preferences`, `permission_handler`
  - Commented out database assets (no longer bundled with app)

- **android/app/build.gradle.kts**
  - Updated namespace to `com.toyounet.app`
  - Updated applicationId to `com.toyounet.app`

- **android/app/src/main/AndroidManifest.xml**
  - Changed app label to "ToYouNet"
  - Added storage permissions for external database access
  - Added `requestLegacyExternalStorage="true"` for Android 10 compatibility

#### Source Code Files
- **lib/main.dart**
  - Updated app title to "ToYouNet"

- **lib/screens/home_screen.dart**
  - Updated app bar title to "ToYouNet"
  - Changed account icon to settings icon
  - Added navigation to SettingsScreen

- **lib/services/database_service.dart**
  - Complete rewrite to support external database files
  - Removed asset database copying logic
  - Added SharedPreferences integration for database path storage
  - Added methods: `getDatabasePath()`, `setDatabasePath()`, `clearDatabasePath()`, `reloadDatabase()`, `getCurrentDatabasePath()`
  - Default path: `/storage/emulated/0/ToYouJAN/myNET.db`
  - Fallback path: `/storage/emulated/0/ToYouJAN/JAT.db`
  - Removed unused imports and migration logic

- **lib/screens/settings_screen.dart** (NEW FILE)
  - Complete settings UI for database management
  - File picker for selecting custom database locations
  - Database statistics display
  - Storage permission handling
  - Reload and reset functionality
  - User-friendly error messages and instructions

#### Test Files
- **integration_test/search_flow_test.dart**
  - Updated import from `package:mynet_mobile` to `package:toyounet`
  - Updated app name assertion from "myNET" to "ToYouNet"

- **test/**/*.dart**
  - Batch updated all imports from `package:mynet_mobile` to `package:toyounet`

### 3. New Dependencies Added

```yaml
file_picker: ^8.0.0+1         # File selection UI
shared_preferences: ^2.2.2    # Persistent key-value storage
permission_handler: ^11.3.0   # Android/iOS permissions API
```

### 4. Android Permissions Added

```xml
<!-- Storage permissions for external database access -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" android:minSdkVersion="30" />
```

### 5. Database Path Logic

**Default behavior:**
1. Check SharedPreferences for saved custom path
2. If no custom path, try `/storage/emulated/0/ToYouJAN/myNET.db`
3. If not found, try `/storage/emulated/0/ToYouJAN/JAT.db`
4. If neither found, throw helpful error with instructions

**Custom path:**
- User can select any .db, .sqlite, or .sqlite3 file via Settings
- Path is saved in SharedPreferences
- App remembers selection across restarts

## Next Steps

### For Building
```bash
cd /Users/andrewmavliev/mynet-mobile

# Install dependencies
flutter pub get

# Build APK
flutter build apk --release

# Or build app bundle for Play Store
flutter build appbundle --release

# Install on connected device
flutter install
```

### For Testing on Device

1. **Prepare database file:**
   ```bash
   # Using adb to push database to device
   adb push /path/to/myNET.db /storage/emulated/0/ToYouJAN/myNET.db

   # Or manually copy via USB file transfer to:
   # Internal Storage/ToYouJAN/myNET.db
   ```

2. **Install and run app:**
   ```bash
   flutter run --release
   ```

3. **Grant permissions:**
   - App will request storage permissions on first database access
   - For Android 11+, may need to manually enable "All files access" in Settings

4. **Verify:**
   - App should load database automatically
   - Go to Settings to see database path and statistics
   - Test file picker by selecting custom database location

## Breaking Changes

### What Changed
- **Database is no longer bundled with the app**
  - Previous: Database copied from assets on first launch
  - Now: Database read from external storage

- **Package name changed**
  - Previous: `com.mavliev.mynet_mobile` / `mynet_mobile`
  - Now: `com.toyounet.app` / `toyounet`

### Migration Impact
- Existing installations will need to:
  1. Export their database (if needed)
  2. Uninstall old app
  3. Install new app
  4. Place database in external storage
  5. Grant storage permissions

## Known Issues

### Analyzer Warnings
The project has pre-existing analyzer warnings unrelated to these changes:
- Deprecated Flutter widget properties (background, onBackground, groupValue, onChanged)
- Missing type annotations in some widgets
- Test files with undefined classes (Education, Experience, Skill models)

These warnings existed before the migration and don't affect the external database functionality.

### Compatibility
- **Android:** Requires Android API 21+ (as per Flutter defaults)
- **Storage Permissions:**
  - Android 10 (API 29): Uses scoped storage with `requestLegacyExternalStorage`
  - Android 11+ (API 30+): May require MANAGE_EXTERNAL_STORAGE permission
  - Android 13+ (API 33+): Uses granular media permissions

## Documentation Created

1. **EXTERNAL_DATABASE_GUIDE.md** - Comprehensive user and developer guide
2. **MIGRATION_SUMMARY.md** (this file) - Technical change summary

## Testing Checklist

- [ ] App builds successfully (`flutter build apk`)
- [ ] App installs on device
- [ ] Storage permissions are requested
- [ ] Default database path auto-detection works
- [ ] File picker opens and allows database selection
- [ ] Database statistics display correctly
- [ ] Reload database functionality works
- [ ] Reset to default path works
- [ ] Error messages show when database not found
- [ ] App remembers custom database path after restart

## Rollback Instructions

If needed to revert to bundled database:

1. Restore `pubspec.yaml` assets section
2. Restore original `database_service.dart` with asset copying
3. Remove `settings_screen.dart`
4. Restore original `home_screen.dart`
5. Remove new dependencies
6. Revert Android package name changes
7. Run `flutter pub get`

Git can help:
```bash
git diff HEAD~1 -- pubspec.yaml lib/services/database_service.dart
```

## Performance Considerations

- **External database access:** Slightly slower than internal storage, but negligible for SQLite
- **File picker:** Requires system UI interaction
- **Permissions:** First-time permission request adds friction to onboarding

## Security Considerations

- **Database access:** App opens database in read-write mode by default
- **Storage permissions:** App can read all files if MANAGE_EXTERNAL_STORAGE granted
- **Database path:** Stored in SharedPreferences (unencrypted)

For read-only mode, uncomment `readOnly: true` in `database_service.dart` line 89.

## Future Improvements

- [ ] Database schema validation on load
- [ ] Automatic database backups
- [ ] Cloud database sync
- [ ] Database encryption
- [ ] Multiple database profiles
- [ ] Import/export wizard
- [ ] Database integrity checking in Settings
