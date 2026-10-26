# Appium Testing App (Flutter)

A Flutter test automation target application featuring dedicated screens, standard widgets, and pre-configured `Key` identifiers for Appium mobile automation and Flutter testing.

---

## 📖 Automation Engineer's Guide

For full setup instructions, build steps, Appium Flutter Driver configurations, sample test scripts (Python/Java), and the locator cheat sheet:

👉 **[Read the Full Automation Guide (AUTOMATION_GUIDE.md)](AUTOMATION_GUIDE.md)**

---

## ⚡ Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Local Tests (Unit & Widget)
```bash
flutter test
```

### 3. Build Debug APK (for Appium & Automation)
```bash
flutter build apk --debug
```
*Output APK located at: `build/app/outputs/flutter-apk/app-debug.apk`*

### 4. Run App with Appium Flutter Server Listening
```bash
flutter run -t integration_test/appium_test.dart
```

---

## 📱 Test Screens Included
- **Login Form**: Text fields, validation, error states (`admin` / `password123`)
- **Input Controls**: Switch, Checkbox, Slider, Dropdown, Counter increment/decrement
- **Scrollable List**: ListView of 30 items with tap & long-press actions
- **Dialogs & Alerts**: AlertDialog, SnackBar with undo action, BottomSheet, DatePicker
- **Tabs & Swipe**: TabBar with swipeable tab views

