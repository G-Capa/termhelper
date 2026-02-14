## TERM HELPER

An AI language helper for the terminal powered by Ollama. Get shell command suggestions using natural language queries.

This is a study project meant to teach me about the basics of incorporating AI with python and using local models. This isnt very efficient as there are a number of other models that do exactly what I have done here in a more professional way.
Then again, it is meant for **practice** 

## Prerequisites

- Python 3.8+
- Ollama (install from https://ollama.ai)

## Installation

One command to install everything (pulls tinyllama model if needed):

```bash
curl -sSL https://raw.githubusercontent.com/G-Capa/termhelper/main/install.sh | bash
```

Or manually:
```bash
pip install git+https://github.com/G-Capa/termhelper.git
```
(If tinyllama isn't installed, run: `ollama pull tinyllama`)

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

### If installed with pipx
```bash
pipx uninstall termhelper
```

### If installed manually with pip
```bash
pip uninstall termhelper
```

### Clean up Ollama (optional)
To remove installed models:
```bash
ollama rm tinyllama
```

To completely uninstall Ollama, follow instructions at https://ollama.ai


