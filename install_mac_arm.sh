#!/usr/bin/env bash
# cisconfig installer for macOS (Apple Silicon)
# Installs cisconfig into /opt/local/bin (MacPorts default path for ARM Macs)

set -euo pipefail

INSTALL_PATH="/opt/local/bin"
BINARY_NAME="cisconfig"
DOWNLOAD_URL="https://github.com/ibm-7094a/cisconfig/releases/download/release/cisconfig"

echo "🍎 Installing cisconfig for macOS (Apple Silicon)..."

# --- Dependency installation ---
install_deps() {
    if command -v brew >/dev/null 2>&1; then
        echo "🍺 Homebrew detected — ensuring curl is installed..."
        brew install curl || true
    elif command -v port >/dev/null 2>&1; then
        echo "🔧 MacPorts detected — ensuring curl is installed..."
        sudo port install curl
    else
        echo "⚠️  No package manager detected. Ensure curl is installed manually." >&2
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
