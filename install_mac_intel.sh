#!/bin/bash
# cisconfig installer for macOS (Intel)
# Installs cisconfig into /usr/local/bin

set -e

INSTALL_PATH="/usr/local/bin"

echo "🧱 Installing cisconfig for macOS (Intel)..."

# Ensure directory exists
sudo mkdir -p "$INSTALL_PATH"

# Download latest version of the script
curl -L https://raw.githubusercontent.com/ibm-7094a/cisconfig/main/cisconfig.sh -o cisconfig

# Move and set permissions
sudo mv cisconfig "$INSTALL_PATH"/cisconfig
sudo chmod +x "$INSTALL_PATH"/cisconfig

echo "✅ cisconfig installed successfully to $INSTALL_PATH"
echo "➡️  Run it with: sudo cisconfig"
