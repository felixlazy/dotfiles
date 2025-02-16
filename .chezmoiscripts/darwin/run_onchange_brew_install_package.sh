#!/bin/zsh

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed, installing..."
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# Install packages using Brewfile
brew bundle --file="~/OneDrive/package/darwin/Brewfile"

