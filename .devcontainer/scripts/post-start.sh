#!/usr/bin/bash

set -euo pipefail

WORKSPACE="$1"

git config --global --add safe.directory "$WORKSPACE"
echo "✅ Added $WORKSPACE to git safe directories"

# Containers do not run systemd; start XRDP and its session manager explicitly.
sudo service xrdp start

if [[ -z "${CODESPACES:-}" ]]; then
  SOCK_PATH=$(find /tmp -maxdepth 1 -name "vscode-ssh-auth-*.sock" -print -quit 2>/dev/null)
  if [[ -n "$SOCK_PATH" ]]; then
    echo "export SSH_AUTH_SOCK=$SOCK_PATH" >> ~/.zshrc
    echo "export SSH_AUTH_SOCK=$SOCK_PATH" >> ~/.bashrc
    export SSH_AUTH_SOCK=$SOCK_PATH
    echo "✅ Mapped SSH_AUTH_SOCK"
  else
    echo "⚠️  VS Code agent socket not found; leaving SSH_AUTH_SOCK unchanged"
  fi
else
  echo "⏩ Skipping SSH_AUTH_SOCK setup for Codespaces"
fi
