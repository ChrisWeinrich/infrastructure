#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install from https://brew.sh and retry." >&2
  exit 1
fi

echo "Stopping Tailscale (if running)..."
tailscale down >/dev/null 2>&1 || true
brew services stop tailscale >/dev/null 2>&1 || true

echo "Uninstalling Tailscale via Homebrew..."
brew uninstall --zap tailscale || true
brew cleanup

echo "Reinstalling Tailscale..."
brew install tailscale
brew services start tailscale

echo "Logging in..."
tailscale login

echo "Bringing Tailscale up..."
tailscale up

echo "Status:"
tailscale status
