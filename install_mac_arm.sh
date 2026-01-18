#!/usr/bin/env bash
# cisconfig installer for macOS (Apple Silicon)
# Installs cisconfig into /opt/local/bin and /usr/local/bin

set -euo pipefail

BINARY_NAME="cisconfig"
DOWNLOAD_URL="https://github.com/ibm-7094a/cisconfig/releases/download/release/cisconfig"
INSTALL_PATHS=(
    "/opt/local/bin"
    "/usr/local/bin"
)

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

# --- Download binary once ---
TMP_FILE="$(mktemp)"
echo "⬇️  Downloading cisconfig binary..."

if ! curl -fSL "$DOWNLOAD_URL" -o "$TMP_FILE"; then
    echo "❌ ERROR: Failed to download cisconfig from $DOWNLOAD_URL" >&2
    rm -f "$TMP_FILE"
    exit 1
fi

chmod +x "$TMP_FILE"

INSTALLED=false

# --- Install to each target path ---
for INSTALL_PATH in "${INSTALL_PATHS[@]}"; do
    echo "📦 Installing to $INSTALL_PATH..."
    sudo mkdir -p "$INSTALL_PATH"
    sudo cp "$TMP_FILE" "$INSTALL_PATH/$BINARY_NAME"
    sudo chmod +x "$INSTALL_PATH/$BINARY_NAME"
    INSTALLED=true
done

rm -f "$TMP_FILE"

if [[ "$INSTALLED" != true ]]; then
    echo "❌ ERROR: Installation failed — no valid install paths found." >&2
    exit 1
fi

echo "✅ cisconfig installed successfully!"
echo "➡️  You can run it with: sudo cisconfig"
