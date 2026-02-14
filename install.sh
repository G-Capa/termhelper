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

# Install the package
pip install git+https://github.com/G-Capa/termhelper.git

echo "✓ TermHelper installed successfully!"
echo "Ready to use: termhelp \"your question here\""
