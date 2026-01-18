#!/usr/bin/env bash
# cisconfig installer for macOS (Intel)
# Installs cisconfig into /usr/local/bin

set -euo pipefail

INSTALL_PATH="/usr/local/bin"
BINARY_NAME="cisconfig"
DOWNLOAD_URL="https://github.com/ibm-7094a/cisconfig/releases/download/release/cisconfig"

echo "🧱 Installing cisconfig for macOS (Intel)..."

# Install dependencies
if command -v brew >/dev/null 2>&1; then
    brew install curl || true
elif command -v port >/dev/null 2>&1; then
    sudo port install curl
else
    echo "⚠️  No package manager detected. Ensure curl is installed." >&2
fi

# Ensure directory exists
sudo mkdir -p "$INSTALL_PATH"

# Download binary safely
TMP_FILE="$(mktemp)"
if ! curl -fSL "$DOWNLOAD_URL" -o "$TMP_FILE"; then
    echo "❌ ERROR: Failed to download cisconfig from $DOWNLOAD_URL" >&2
    rm -f "$TMP_FILE"
    exit 1
fi

# Move and set permissions
sudo mv "$TMP_FILE" "$INSTALL_PATH/$BINARY_NAME"
sudo chmod +x "$INSTALL_PATH/$BINARY_NAME"

echo "✅ cisconfig installed successfully to $INSTALL_PATH"
echo "➡️  Run it with: sudo cisconfig"
