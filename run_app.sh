#!/bin/bash

# Script to run Flutter app
# Usage: ./run_app.sh

echo "🚀 Starting Astrology App..."

# Check if Flutter is in PATH
if command -v flutter &> /dev/null; then
    echo "✅ Flutter found in PATH"
    FLUTTER_CMD="flutter"
elif [ -f "$HOME/flutter/bin/flutter" ]; then
    echo "✅ Flutter found at ~/flutter/bin/flutter"
    FLUTTER_CMD="$HOME/flutter/bin/flutter"
    export PATH="$PATH:$HOME/flutter/bin"
elif [ -f "/usr/local/bin/flutter" ]; then
    echo "✅ Flutter found at /usr/local/bin/flutter"
    FLUTTER_CMD="/usr/local/bin/flutter"
else
    echo "❌ Flutter not found!"
    echo "Please install Flutter from https://flutter.dev/docs/get-started/install"
    echo "Or add Flutter to your PATH"
    exit 1
fi

# Get dependencies
echo "📦 Getting dependencies..."
$FLUTTER_CMD pub get

# Enable web support
echo "🌐 Enabling web support..."
$FLUTTER_CMD config --enable-web

# Run the app
echo "🎬 Running app on Chrome..."
$FLUTTER_CMD run -d chrome --web-port 8080

