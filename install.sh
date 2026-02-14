#!/bin/bash
set -e

echo "Installing TermHelper..."

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "Error: Ollama is not installed."
    echo "Please install Ollama from https://ollama.ai"
    exit 1
fi

# Check if tinyllama model is installed
if ! ollama list | grep -q tinyllama; then
    echo "Pulling tinyllama model (this may take a few minutes)..."
    ollama pull tinyllama
fi

# Check if pipx is installed
if ! command -v pipx &> /dev/null; then
    echo "pipx not found. Installing pipx..."
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y pipx
        pipx ensurepath
    elif command -v brew &> /dev/null; then
        brew install pipx
        pipx ensurepath
    else
        python3 -m pip install --user pipx
        python3 -m pipx ensurepath
    fi
    echo "Please restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
    echo "Then run this install script again."
    exit 0
fi

# Install the package using pipx
pipx install git+https://github.com/G-Capa/termhelper.git

echo "✓ TermHelper installed successfully!"
echo "Ready to use: termhelp \"your question here\""
