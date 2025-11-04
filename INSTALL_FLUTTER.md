# Install Flutter to Run the App

## Quick Installation (Recommended)

### Method 1: Download Flutter SDK Directly

1. **Download Flutter for macOS:**
   ```bash
   cd ~
   git clone https://github.com/flutter/flutter.git -b stable
   ```

2. **Add to PATH:**
   ```bash
   # Add this line to ~/.zshrc
   echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Verify:**
   ```bash
   flutter doctor
   ```

4. **Run the app:**
   ```bash
   cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"
   flutter pub get
   flutter run -d chrome
   ```

### Method 2: Use the Run Script

After installing Flutter, you can use the provided script:

```bash
cd "/Volumes/T7/Contents/Skill Sprint/Flutter/Astrology App"
./run_app.sh
```

## Alternative: Use VS Code

1. **Install VS Code** from https://code.visualstudio.com/
2. **Install Flutter Extension** in VS Code
3. **Open the project folder** in VS Code
4. **Press F5** or click "Run and Debug"
5. **Select Chrome** as the target device

## What You'll See

After running the app:
- Chrome browser will open automatically
- App will load at `http://localhost:8080` (or similar)
- You'll see the Login page with beautiful gradient design
- After login, you can use the Role Switcher to view different dashboards

## Need Help?

Visit: https://flutter.dev/docs/get-started/install/macos

