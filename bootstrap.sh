#!/bin/bash
set -e

# Install Xcode command line tools
xcode-select --install || true

# Install Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install mise
if ! command -v mise &>/dev/null; then
  brew install mise
fi

mise run setup
