# myNET Mobile - Testing Guide

**Last Updated:** December 19, 2025
**Status:** Core MVP Ready for Testing (Some widget errors remain)

---

## 🧪 Testing Status

### ✅ What Works
- ✓ Home screen with search bar
- ✓ Contact list display
- ✓ Basic search functionality
- ✓ Filter chips UI
- ✓ Profile header display
- ✓ Navigation between screens
- ✓ Database integration (SQLite)
- ✓ Riverpod state management

### ⚠️ Known Issues
- Some detail tabs may have rendering issues (Education, Experience, Skills)
- FilterState ambiguous import conflict
- InteractionHistory enum missing constants
- These won't block basic app testing

---

## 📱 Testing on Your Physical Device

### Prerequisites
1. Android device with USB debugging enabled
2. USB cable to connect device to Mac

### Steps to Test

#### 1. Enable Developer Mode on Android
```
Settings → About Phone → Tap "Build Number" 7 times
Settings → Developer Options → Enable "USB Debugging"
```

#### 2. Connect Device and Verify
```bash
# Connect your device via USB
adb devices

# You should see:
# List of devices attached
# XXXXXXXXXX	device
```

#### 3. Run the App
```bash
cd /Users/andrewmavliev/mynet-mobile

# Install and run on your device
flutter run

# Or specify device if multiple connected
flutter run -d <device-id>
```

#### 4. First Launch
On first launch, the app will:
1. Copy myNET.db from assets to app storage (~12 MB)
2. Run database migration (add notes, interactions, tags tables)
3. Load 2,628 LinkedIn + 1,850 Booth profiles
4. Show home screen with search

**Note:** First launch may take 10-30 seconds while database copies.

---

## 🧪 Test Checklist

### Basic Functionality Tests

#### Home Screen - Search & Browse
- [ ] App launches successfully
- [ ] Home screen displays
- [ ] Search bar is visible and tappable
- [ ] Contact cards are displayed (should see mock contacts initially)
- [ ] Can scroll through contact list
- [ ] Pull-to-refresh gesture works

#### Search Functionality
- [ ] Type in search bar - search updates (300ms debounce)
- [ ] Clear search button works (X icon)
- [ ] Recent searches dropdown appears
- [ ] Search filters results correctly

#### Filters
- [ ] Tap filter icon - bottom sheet opens
- [ ] Connection degree chips toggle (1°/2°/3°)
- [ ] Company filter shows options
- [ ] Location filter shows options
- [ ] Apply filters button works
- [ ] Reset filters button works

#### Contact Cards
- [ ] Cards display avatar (or initials if no photo)
- [ ] Name is visible
- [ ] Headline/title is visible
- [ ] Company name is visible
- [ ] Connection degree badge shows (1°/2°/3° with colors)
- [ ] Last interaction timestamp displays
- [ ] Tap card - navigates to profile detail

#### Profile Detail Screen
- [ ] Profile detail screen opens
- [ ] Hero animation plays (photo transitions smoothly)
- [ ] Back button works
- [ ] Profile header shows photo, name, headline
- [ ] Tabs are visible (Overview, Experience, Education, Skills, Notes)
- [ ] Can switch between tabs
- [ ] Action buttons visible (Call, Email, Add Note)

#### Gestures & Interactions
- [ ] Swipe right on contact card (call action)
- [ ] Swipe left on contact card (email action)
- [ ] Long-press on contact card (shows options menu)
- [ ] Pull-to-refresh on home screen
- [ ] Smooth scrolling performance

---

## 🐛 Issues to Report

For each issue you find, please note:
1. **Screen:** Which screen (Home, Profile Detail, etc.)
2. **Action:** What you were doing
3. **Expected:** What should happen
4. **Actual:** What actually happened
5. **Severity:** Critical / High / Medium / Low

### Example Issue Report
```
Screen: Home Screen
Action: Tapping search bar
Expected: Keyboard appears, can type search query
Actual: Nothing happens / App crashes / Keyboard doesn't appear
Severity: High
```

---

## 📊 Performance Testing

### Metrics to Observe
- **App Startup Time:** How long from tap to home screen?
  - Target: < 2 seconds

- **Search Response Time:** Type and observe delay
  - Target: < 500ms after typing stops

- **Profile Load Time:** Tap card and time until profile shows
  - Target: < 300ms

- **Scroll Performance:** Is scrolling smooth with 2,600+ profiles?
  - Target: 60 FPS, no jank

### How to Check Performance
1. **Startup:** Use stopwatch from icon tap to home screen
2. **Search:** Type quickly and observe debounce delay
3. **Navigation:** Tap card and time until detail screen renders
4. **Scrolling:** Scroll rapidly through list - should be smooth

---

## 🔧 Troubleshooting

### App Won't Install
```bash
# Uninstall old version
adb uninstall com.mavliev.mynet_mobile

# Reinstall
flutter clean
flutter pub get
flutter run
```

### Database Issues
```bash
# Clear app data
adb shell pm clear com.mavliev.mynet_mobile

# Reinstall (will recopy database)
flutter run
```

### "Device Not Found"
```bash
# Check USB connection
adb devices

# Restart ADB
adb kill-server
adb start-server

# Reconnect device
```

### App Crashes on Launch
Check logs:
```bash
flutter logs

# Or ADB logs
adb logcat | grep "mynet_mobile"
```

---

## 📸 Screenshots to Capture

Please capture screenshots of:
1. Home screen with contact list
2. Search in action (with results)
3. Filter bottom sheet open
4. Profile detail screen (Overview tab)
5. Any error screens you encounter
6. Any UI glitches or layout issues

---

## ✅ Success Criteria

The MVP is successful if:
- [x] App installs and launches on physical device
- [ ] Home screen displays contact list
- [ ] Search functionality works
- [ ] Can navigate to profile detail
- [ ] No critical crashes during 15-minute usage
- [ ] UI is responsive and smooth
- [ ] Data loads from database correctly

---

## 🚀 After Testing

Once you've tested, we can:
1. Fix any critical bugs you find
2. Improve UI/UX based on feedback
3. Implement remaining features (Add Note, Edit Profile)
4. Add comprehensive tests
5. Set up cloud sync
6. Prepare for production release

---

## 📞 Quick Commands Reference

```bash
# Check connected devices
adb devices

# Run app
cd /Users/andrewmavliev/mynet-mobile
flutter run

# View logs
flutter logs

# Reinstall fresh
flutter clean && flutter pub get && flutter run

# Take screenshot from device
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ~/Desktop/

# Record screen (CTRL+C to stop)
adb shell screenrecord /sdcard/demo.mp4
adb pull /sdcard/demo.mp4 ~/Desktop/
```

---

## 📝 Notes

- **Database Location on Device:** `/data/data/com.mavliev.mynet_mobile/databases/myNET.db`
- **App Size:** ~15-20 MB (includes 12 MB database)
- **Android Requirements:** API 21+ (Android 5.0 Lollipop or higher)
- **Permissions:** Storage (for database), Internet (future cloud sync)

---

**Happy Testing!** 🎉

Report issues directly or we can fix them together in the next session.
