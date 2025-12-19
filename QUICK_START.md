# ToYouNet - Quick Start Guide

## For Users: Setting Up the App

### Step 1: Prepare Your Database File

Place your database file on your Android phone:
```
/storage/emulated/0/ToYouJAN/myNET.db
```

**How to do this:**

**Option A: Via USB Cable**
1. Connect your phone to computer via USB
2. Enable "File Transfer" mode on your phone
3. Create folder: `Internal Storage/ToYouJAN/`
4. Copy `myNET.db` or `JAT.db` into that folder

**Option B: Via ADB (for developers)**
```bash
# Create directory
adb shell mkdir -p /storage/emulated/0/ToYouJAN

# Push database file
adb push /path/to/myNET.db /storage/emulated/0/ToYouJAN/myNET.db
```

### Step 2: Install the App

1. Build or obtain the APK
2. Install on your device
3. Launch "ToYouNet"

### Step 3: Grant Permissions

When you first open the app:
1. Tap "Settings" (gear icon in top-right)
2. Tap "Select Database File"
3. Grant storage permissions when prompted
4. If database is in default location, it will auto-load

**For Android 11+:**
- You may need to enable "All files access" permission
- Go to: Settings > Apps > ToYouNet > Permissions > Files and Media > Allow management of all files

### Step 4: Verify It Works

In the Settings screen, you should see:
- Current database path
- Database statistics (profile count, etc.)
- Database size

If you see statistics, it's working!

## For Developers: Building the App

### Prerequisites
```bash
flutter --version  # Should be 3.10.4 or higher
```

### Build & Install

```bash
# Navigate to project
cd /Users/andrewmavliev/mynet-mobile

# Install dependencies
flutter pub get

# Connect Android device or start emulator
flutter devices

# Build and install debug version
flutter run

# Or build release APK
flutter build apk --release

# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

### Install APK on Device

```bash
# Install via ADB
adb install build/app/outputs/flutter-apk/app-release.apk

# Or use Flutter
flutter install
```

## Troubleshooting

### "Database file not found" Error

**Solution 1: Check file location**
```bash
# Verify file exists
adb shell ls -l /storage/emulated/0/ToYouJAN/

# Should show myNET.db or JAT.db
```

**Solution 2: Use custom path**
1. Place database anywhere on your phone
2. Open app Settings
3. Tap "Select Database File"
4. Navigate to your database file
5. Select it

### "Permission denied" Error

**Solution:**
1. Go to Android Settings
2. Apps > ToYouNet > Permissions
3. Enable "Storage" or "Files and Media"
4. For Android 11+: Enable "All files access"

### App crashes on startup

**Solution:**
1. Database might not exist at default path
2. Place database file in correct location
3. Or use Settings to select custom location

## File Structure on Device

```
/storage/emulated/0/
└── ToYouJAN/
    ├── myNET.db          # Primary database
    └── JAT.db            # Alternative database (optional)
```
