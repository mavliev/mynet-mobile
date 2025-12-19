# Running myNET Mobile on macOS

## ✅ Quick Start

The app is now configured to run on your Mac! Here's how:

### 1. Run the App (Easiest)
```bash
cd /Users/andrewmavliev/mynet-mobile
flutter run -d macos
```

The app will:
- Build for macOS (first time takes 2-3 minutes)
- Launch as a native Mac window
- Load your 2,628 LinkedIn profiles from myNET.db

### 2. Alternative: Run in Release Mode (Faster)
```bash
cd /Users/andrewmavliev/mynet-mobile
flutter run -d macos --release
```

Release mode is optimized and runs faster but takes longer to build.

---

## 🖥️ What to Expect

**First Launch:**
- Build time: 2-3 minutes (first time only)
- A macOS window will open
- Database will copy from assets (~12 MB)
- Home screen with search bar and contact list will appear

**Window Size:**
- Default: 800x600 pixels
- Resizable: Drag corners to resize
- Modern macOS app with native controls

---

## 🎮 How to Use on Mac

**Navigation:**
- Click contact cards to view profiles
- Type in search bar to filter contacts
- Click filter icon for advanced filters
- Scroll with trackpad or mouse wheel

**Keyboard Shortcuts:**
- `Cmd+Q` - Quit app
- `Cmd+W` - Close window
- `Cmd+F` - Focus search (if implemented)

**Mouse/Trackpad:**
- Click to select
- Scroll to browse list
- Hover for tooltips (if implemented)

---

## 🔧 Troubleshooting

### App Won't Build
```bash
# Clean and rebuild
cd /Users/andrewmavliev/mynet-mobile
flutter clean
flutter pub get
flutter run -d macos
```

### "No devices found"
```bash
# Enable macOS support
flutter config --enable-macos-desktop

# Verify it's enabled
flutter devices
# Should show: macOS (desktop) • macos • darwin-arm64
```

### Build Errors
```bash
# Check for issues
flutter doctor

# Update Flutter
flutter upgrade

# Rebuild
flutter run -d macos
```

### Database Issues
The app will automatically copy myNET.db from `assets/database/` to:
```
~/Library/Containers/com.mavliev.mynet_mobile/Data/Library/Application Support/databases/
```

To reset:
```bash
# Delete app data
rm -rf ~/Library/Containers/com.mavliev.mynet_mobile

# Rerun app (will recopy database)
flutter run -d macos
```

---

## 📊 Performance on Mac

**Expected Performance:**
- Startup: < 2 seconds
- Search: < 300ms response
- Smooth 60 FPS scrolling
- Low CPU usage (~5-10%)
- Memory: ~100-150 MB

**Advantages vs Android:**
- Bigger screen for viewing profiles
- Faster performance (Mac hardware)
- Easier to take screenshots
- Easier to debug with hot reload

---

## 🔥 Hot Reload (Developer Feature)

While the app is running, you can edit code and see changes instantly:

1. Make changes to any `.dart` file
2. Save the file
3. In terminal where app is running, press:
   - `r` - Hot reload (instant update)
   - `R` - Hot restart (full restart)
   - `q` - Quit app

Example:
```bash
# App is running...
# Edit lib/screens/home_screen.dart
# Save the file
# Press 'r' in terminal
# See changes instantly in the app!
```

---

## 📸 Screenshots

To take screenshots on Mac:
- `Cmd+Shift+4` - Select area
- `Cmd+Shift+5` - Screenshot/recording tool
- Screenshots save to ~/Desktop/

---

## 🚀 Build for Production (Optional)

To create a standalone Mac app:
```bash
cd /Users/andrewmavliev/mynet-mobile
flutter build macos --release

# App will be at:
# build/macos/Build/Products/Release/mynet_mobile.app

# You can double-click to run or move to Applications folder
open build/macos/Build/Products/Release/
```

---

## 🎯 Quick Commands

```bash
# Run app
flutter run -d macos

# Run in release mode (faster)
flutter run -d macos --release

# Build standalone app
flutter build macos --release

# Clean build files
flutter clean

# Check devices
flutter devices

# View logs
flutter logs
```

---

## 📝 Notes

- **Database Size:** 12 MB (same as Android version)
- **App Size:** ~25-30 MB built
- **macOS Requirements:** macOS 10.14+ (Mojave or later)
- **Architecture:** Universal (Intel + Apple Silicon)

---

## ✨ Benefits of Testing on Mac

1. **Larger Screen** - See more contacts at once
2. **Easier Navigation** - Mouse/keyboard more precise
3. **Faster Development** - Hot reload works great
4. **Better Debugging** - Easier to see console logs
5. **Screenshots** - Built-in screenshot tools
6. **Same Code** - Works identically on Android

---

**Enjoy testing on your Mac!** 🎉

The app should launch in a new window. You can resize it, use search, browse profiles, and test all features just like on Android.
