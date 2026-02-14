import requests
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

OLLAMA_API_URL = os.getenv("OLLAMA_API_URL", "http://localhost:11434/api/generate")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "tinyllama")

def suggest_command(query: str) -> str:
    prompt = f"Suggest a shell command for the following query: {query}\nRespond with only the command, no explanation."

    try:
        response = requests.post(
            OLLAMA_API_URL,
            json={
                "model": OLLAMA_MODEL,
                "prompt": prompt,
                "stream": False
            },
            timeout=30
        )
        response.raise_for_status()
        
        result = response.json()
        suggestion = result.get("response", "").strip()
        return suggestion if suggestion else "Could not generate suggestion"
    
    except requests.exceptions.ConnectionError:
        return "Error: Cannot connect to Ollama. Make sure Ollama is running on localhost:11434"
    except Exception as e:
        return f"Error contacting Ollama: {e}"
