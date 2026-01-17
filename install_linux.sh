#!/usr/bin/env bash
# cisconfig installer for Linux
# Installs cisconfig into /usr/local/bin

set -euo pipefail

INSTALL_PATH="/usr/local/bin"
BINARY_NAME="cisconfig"
DOWNLOAD_URL="https://github.com/ibm-7094a/cisconfig/releases/download/release/cisconfig"

echo "🐧 Installing cisconfig for Linux..."

# --- Dependency installation ---
install_deps() {
    echo "🔍 Checking and installing dependencies..."

    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y curl coreutils
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y curl coreutils
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y curl coreutils
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm curl coreutils
    elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y curl coreutils
    else
        echo "⚠️  Could not detect package manager. Please install curl and coreutils manually." >&2
    fi
}

install_deps

# --- Ensure install directory exists ---
sudo mkdir -p "$INSTALL_PATH"

# --- Download binary safely ---
TMP_FILE="$(mktemp)"
echo "⬇️  Downloading cisconfig binary..."

if ! curl -fSL "$DOWNLOAD_URL" -o "$TMP_FILE"; then
    echo "❌ ERROR: Failed to download cisconfig from $DOWNLOAD_URL" >&2
    rm -f "$TMP_FILE"
    exit 1
fi

# --- Install binary ---
sudo mv "$TMP_FILE" "$INSTALL_PATH/$BINARY_NAME"
sudo chmod +x "$INSTALL_PATH/$BINARY_NAME"

echo "✅ cisconfig installed successfully to $INSTALL_PATH"
echo "➡️  Run it with: sudo cisconfig"
