#!/bin/bash
set -e

echo "Installing TermHelper..."

# Check if Ollama is installed, install if not
if ! command -v ollama &> /dev/null; then
    echo "Ollama not found. Installing Ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh
    echo "✓ Ollama installed successfully"
fi

# Start Ollama if not running
if ! pgrep -f "ollama serve" > /dev/null; then
    echo "Starting Ollama..."
    ollama serve > /dev/null 2>&1 &
    sleep 3
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
