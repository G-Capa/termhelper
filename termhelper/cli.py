#!/usr/bin/env python3
import sys
import subprocess
from .ai.assistant import suggest_command

def check_model_installed(model_name="tinyllama"):
    try:
        result = subprocess.run(
            ["ollama", "list"],
            capture_output=True,
            text=True,
            timeout=10
        )
        return model_name in result.stdout
    except:
        return False

def pull_model(model_name="tinyllama"):
    try:
        print(f"Pulling {model_name} model...")
        subprocess.run(
            ["ollama", "pull", model_name],
            check=True,
            timeout=300
        )
        print(f"{model_name} model installed successfully")
        return True
    except Exception as e:
        print(f"Error pulling model: {e}")
        return False

def start_ollama():
    try:
        subprocess.run(
            ["pgrep", "-f", "ollama serve"],
            check=True,
            capture_output=True
        )
        print("Ollama is already running")
    except subprocess.CalledProcessError:
        try:
            print("Starting Ollama...")
            subprocess.Popen(
                ["ollama", "serve"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True
            )
            print("Ollama started successfully")
            import time
            time.sleep(2)
        except FileNotFoundError:
            print("Error: Ollama is not installed. Please install Ollama from https://ollama.ai")
            return False
    
    if not check_model_installed("tinyllama"):
        pull_model("tinyllama")
    
    return True

def stop_ollama():
    try:
        subprocess.run(["killall", "ollama"], capture_output=True)
        print("Ollama stopped")
        return True
    except Exception as e:
        print(f"Error stopping Ollama: {e}")
        return False

def main():
    if len(sys.argv) < 2:
        print("Usage: termhelp \"your question here\"")
        print("       termhelp activate   (start Ollama)")
        print("       termhelp deactivate (stop Ollama)")
        sys.exit(1)

    command = sys.argv[1]

    if command == "activate":
        start_ollama()
        sys.exit(0)
    elif command == "deactivate":
        stop_ollama()
        sys.exit(0)
    else:
        query = " ".join(sys.argv[1:])
        suggestion = suggest_command(query)
        print("TermHelper: " + suggestion)

if __name__ == "__main__":
    main()
