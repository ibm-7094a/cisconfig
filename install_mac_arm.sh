#!/bin/bash
# cisconfig installer for macOS (Apple Silicon)
# Installs cisconfig into /opt/local/bin (Homebrew default path for ARM Macs)

set -e

INSTALL_PATH="/opt/local/bin"

echo "🍎 Installing cisconfig for macOS (Apple Silicon)..."

# Ensure directory exists
sudo mkdir -p "$INSTALL_PATH"

# Download latest version of the script
curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/cisconfig.sh -o cisconfig

# Move and set permissions
sudo mv cisconfig "$INSTALL_PATH"/cisconfig
sudo chmod +x "$INSTALL_PATH"/cisconfig

echo "✅ cisconfig installed successfully to $INSTALL_PATH"
echo "➡️  Run it with: sudo cisconfig"
