## TERM HELPER

An AI language helper for the terminal powered by Ollama. Get shell command suggestions using natural language queries.

This is a study project meant to teach me about the basics of incorporating AI with python and using local models. This isnt very efficient as there are a number of other models that do exactly what I have done here in a more professional way.
Then again, it is meant for **practice**. Namely Python packages, CLI tool dev, process management and AI.

## Prerequisites

- Python 3.8+
- Ollama (install from https://ollama.ai)
- pipx (recommended for installation)

## Installation

### Automatic Installation (Recommended)

One command to install everything (Ollama, pipx, termhelper, and tinyllama model):

```bash
curl -sSL https://raw.githubusercontent.com/G-Capa/termhelper/main/install.sh | bash
```

This will automatically:
- Install Ollama if not present
- Install pipx if needed
- Install termhelper
- Pull the tinyllama model

### Manual Installation

First, ensure pipx is installed:
```bash
# On Ubuntu/Debian
sudo apt install pipx
pipx ensurepath

# On macOS
brew install pipx
pipx ensurepath

# Or using pip
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

Then install termhelper:
```bash
pipx install git+https://github.com/G-Capa/termhelper.git
```

If tinyllama isn't installed, run: `ollama pull tinyllama`

## Quick Start

1. Activate Ollama (automatically downloads tinyllama model on first run):
   ```bash
   termhelp activate
   ```

2. Ask a question:
   ```bash
   termhelp "how do I see my current directory?"
   ```

3. Stop Ollama when done:
   ```bash
   termhelp deactivate
   ```

## Usage

### Start Ollama
```bash
termhelp activate
```
This will:
- Start the Ollama server in the background
- Automatically download tinyllama model if not already installed
- Be ready to answer questions

### Ask Questions
```bash
termhelp "your question here"
termhelp "how do I move files to Documents?"
termhelp "list all directories"
termhelp "show me the contents of a file"
```

### Stop Ollama
```bash
termhelp deactivate
```

## Configuration

Edit `.env` file to customize:

```
OLLAMA_API_URL=http://localhost:11434/api/generate
OLLAMA_MODEL=tinyllama
```

### Available Models

- `tinyllama` (recommended) - Lightweight, ~1.1GB, works on low-memory systems
- `mistral` - More capable, requires ~4.5GB RAM
- `neural-chat` - Optimized for chat, requires ~4.1GB RAM
- `llama2` - Full capabilities, requires more resources

Switch models by changing `OLLAMA_MODEL` in `.env`, then run:
```bash
ollama pull <model-name>
```

## Troubleshooting

### "externally-managed-environment" Error
If you see this error during installation:
```
error: externally-managed-environment
```

This is a Python safety feature on newer systems. Solutions:
1. **Use pipx (recommended)**: `sudo apt install pipx && pipx install git+https://github.com/G-Capa/termhelper.git`
2. **Re-run the install script**: It will automatically install pipx for you
3. After installing pipx, restart your shell or run: `source ~/.zshrc` (or `~/.bashrc`)

### "Cannot connect to Ollama"
- Make sure Ollama is running: `termhelp activate`
- Check if Ollama is installed: `ollama --version`

### "Model requires more system memory"
- Your system doesn't have enough RAM for the current model
- Switch to a lighter model like tinyllama
- Edit `.env` and change `OLLAMA_MODEL=tinyllama`

To check if you have enough RAM:
```bash
free -h
```

Or test with Ollama directly:
```bash
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model": "tinyllama", "prompt": "hello", "stream": false}'
```

### Ollama won't start
- Install Ollama from https://ollama.ai
- Or manually start: `ollama serve` in another terminal

## Uninstallation

### Automatic Uninstallation (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/G-Capa/termhelper/main/uninstall.sh | bash
```

This will:
- Uninstall termhelper
- Optionally uninstall Ollama (you'll be prompted)

### Manual Uninstallation

If installed with pipx:
```bash
pipx uninstall termhelper
```

If installed manually with pip:
```bash
pip uninstall termhelper
```

To manually uninstall Ollama:
```bash
sudo systemctl stop ollama
sudo systemctl disable ollama
sudo rm /usr/local/bin/ollama
sudo rm -rf /usr/share/ollama ~/.ollama
sudo rm /etc/systemd/system/ollama.service
```


