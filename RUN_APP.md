# How to Run the Astrology App

## Quick Start

Since Flutter is not currently in your PATH, here are the steps to run the app:

### Option 1: Install Flutter (Recommended)

1. **Download Flutter SDK:**
   ```bash
   # Visit https://flutter.dev/docs/get-started/install/macos
   # Or download directly:
   cd ~
   git clone https://github.com/flutter/flutter.git -b stable
   ```

2. **Add Flutter to PATH:**
   ```bash
   # Add to ~/.zshrc (since you're using zsh)
   echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Verify Installation:**
   ```bash
   flutter doctor
   ```

4. **Enable Web Support:**
   ```bash
   flutter config --enable-web
   ```

5. **Run the App:**
   ```bash
   cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"
   flutter pub get
   flutter run -d chrome
   ```

### Option 2: Use Flutter from Specific Path

If Flutter is installed but not in PATH:

1. **Find Flutter installation:**
   ```bash
   # Common locations:
   # ~/flutter/bin/flutter
   # /usr/local/flutter/bin/flutter
   # /Applications/flutter/bin/flutter
   ```

2. **Run with full path:**
   ```bash
   cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"
   ~/flutter/bin/flutter pub get
   ~/flutter/bin/flutter run -d chrome
   ```

### Option 3: Use VS Code / Android Studio

1. **Open in VS Code:**
   - Open the project folder in VS Code
   - Install Flutter extension
   - Press F5 or click "Run" button
   - Select Chrome as device

2. **Open in Android Studio:**
   - Open the project in Android Studio
   - Install Flutter plugin
   - Click the Run button
   - Select Chrome device

### Option 4: Use Flutter App (GUI)

If you have Flutter App installed:
- Open Flutter App
- Open this project folder
- Select Chrome as target
- Click Run

## Troubleshooting

### If Flutter command not found:

1. **Check if Flutter is installed:**
   ```bash
   which flutter
   ls -la ~/flutter/bin/flutter
   ```

2. **Add to PATH temporarily:**
   ```bash
   export PATH="$PATH:$HOME/flutter/bin"
   flutter --version
   ```

3. **Install Flutter:**
   ```bash
   # macOS
   brew install --cask flutter
   
   # Or download from:
   # https://flutter.dev/docs/get-started/install/macos
   ```

### If dependencies are missing:

```bash
cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"
flutter pub get
```

### If web support is not enabled:

```bash
flutter config --enable-web
flutter doctor
```

## Expected Output

When the app runs successfully, you should see:

```
Launching lib/main.dart on Chrome in debug mode...
Building web application...
```

Then Chrome will open automatically with the app at `http://localhost:xxxxx`

## What to Do Next

1. **Register/Login** - Create an account or login
2. **View Home Page** - See the beautiful UI with horoscopes
3. **Use Role Switcher** - Scroll down to find the yellow-bordered Role Switcher
4. **Switch Roles** - Click different role buttons to see different dashboards:
   - Super Admin
   - Admin
   - Astrologer
   - Content Creator
   - End User

## Quick Commands Reference

```bash
# Navigate to project
cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"

# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run on specific port
flutter run -d chrome --web-port 8080

# Hot reload (press 'r' in terminal)
# Hot restart (press 'R' in terminal)
# Quit (press 'q' in terminal)
```

---

**Note:** If you need help installing Flutter, visit: https://flutter.dev/docs/get-started/install

