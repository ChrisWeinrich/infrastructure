#!/usr/bin/env bash
set -euo pipefail

# Ensure Homebrew is present for install/remove.
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install from https://brew.sh and retry." >&2
  exit 1
fi

# Stop any running Tailscale services before removal.
echo "Stopping Tailscale (if running)..."
tailscale down >/dev/null 2>&1 || true
brew services stop tailscale >/dev/null 2>&1 || true

# Remove the existing installation.
echo "Uninstalling Tailscale via Homebrew..."
brew uninstall --zap tailscale || true
brew cleanup

# Reinstall and start the service.
echo "Reinstalling Tailscale..."
brew install tailscale
brew services start tailscale

# Re-authenticate the node.
echo "Logging in..."
tailscale login

# Bring the device up after login.
echo "Bringing Tailscale up..."
tailscale up

# Show connection status for verification.
echo "Status:"
tailscale status
