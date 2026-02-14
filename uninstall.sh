#!/bin/bash
set -e

echo "Uninstalling TermHelper..."

# Uninstall termhelper
if command -v pipx &> /dev/null; then
    if pipx list | grep -q termhelper; then
        pipx uninstall termhelper
        echo "✓ TermHelper uninstalled"
    else
        echo "TermHelper is not installed via pipx"
    fi
else
    echo "pipx not found, skipping termhelper uninstall"
fi

# Ask if user wants to uninstall Ollama
read -p "Do you want to uninstall Ollama as well? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstalling Ollama..."
    
    # Stop Ollama if running
    if pgrep -f "ollama serve" > /dev/null; then
        echo "Stopping Ollama..."
        pkill -f "ollama serve" 2>/dev/null || sudo pkill -f "ollama serve"
    fi
    
    # Remove Ollama files
    sudo systemctl stop ollama 2>/dev/null || true
    sudo systemctl disable ollama 2>/dev/null || true
    sudo rm -f /usr/local/bin/ollama
    sudo rm -rf /usr/share/ollama
    sudo rm -f /etc/systemd/system/ollama.service
    sudo userdel ollama 2>/dev/null || true
    rm -rf ~/.ollama
    
    echo "✓ Ollama uninstalled"
else
    echo "Keeping Ollama installed"
fi

echo "✓ Uninstallation complete"
