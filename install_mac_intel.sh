#!/usr/bin/env bash
# cisconfig installer for macOS (Intel)
# Installs cisconfig into /usr/local/bin

set -euo pipefail

INSTALL_PATH="/usr/local/bin"
BINARY_NAME="cisconfig"
DOWNLOAD_URL="https://github.com/ibm-7094a/cisconfig/releases/download/release/cisconfig"

echo "🧱 Installing cisconfig for macOS (Intel)..."

if ! command -v curl >/dev/null; then
  echo "Please install curl using Homebrew or MacPorts"
  exit 1
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
