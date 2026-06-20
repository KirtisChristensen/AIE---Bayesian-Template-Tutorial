# Workshop Setup Guide

This project is prepared for workshop use across many machines.

## Requirements At A Glance

- Recommended: Conda or Mamba installed (uses environment.yml).
- Fallback: Any Python 3.11+ environment with pip (uses requirements.txt).
- Runtime: One OpenAI API key (OPENAI_API_KEY), or run Ollama locally with no API key.

## Included Files

- environment.yml: Primary reproducible environment for workshop participants.
- requirements.txt: Pip fallback when conda or mamba is unavailable.
- .env.example: Template for provider and API key environment variables.

## Facilitator Prep (Recommended)

1. Ask participants to install Miniconda or Mambaforge before the workshop.
2. Share this folder as a zip or repository.
3. Ask participants to complete setup before the session starts.

## Participant Setup

### Option A (Primary): Conda environment

```powershell
conda env create -f environment.yml
conda activate aie-workshop
python -m ipykernel install --user --name aie-workshop --display-name "Python (aie-workshop)"
```

Then open the notebook and select the kernel "Python (aie-workshop)".

### Option B (Fallback): Existing Python + pip

```powershell
python -m pip install -r requirements.txt
```

### Option C (Optional Local Model): Ollama

Install Ollama from https://ollama.com, then start it locally and pull a model:

```powershell
ollama pull llama3.1
```

The notebook can then use the local OpenAI-compatible endpoint at `http://localhost:11434/v1`.

## Runtime Configuration

Set one runtime option before running the notebook.

## API Key Setup Options

Choose one option for workshop operations:

1. Recommended: personal OpenAI key per participant.
2. Optional: temporary workshop OpenAI key distributed by facilitator.
3. Optional: Ollama local model with no API key.

## Get Your Own OpenAI API Key (Participant)

1. Create or sign in to your OpenAI account at https://platform.openai.com.
2. Go to API keys and create a new secret key.
3. Copy the key once and store it safely.
4. Set it in your current terminal session before running the notebook.

Important: never paste keys into shared slides, chats, or committed files.

### Windows PowerShell (current session)

```powershell
$env:LLM_PROVIDER = "openai"
$env:LLM_MODEL = "gpt-4o-mini"
$env:OPENAI_API_KEY = "<your-key>"
```

Check whether a key is set (without printing the full key):

```powershell
if ($env:OPENAI_API_KEY) { "OPENAI_API_KEY is set" } else { "OPENAI_API_KEY is NOT set" }
```

If you need to inspect where it may be stored:

```powershell
[Environment]::GetEnvironmentVariable("OPENAI_API_KEY", "Process")
[Environment]::GetEnvironmentVariable("OPENAI_API_KEY", "User")
[Environment]::GetEnvironmentVariable("OPENAI_API_KEY", "Machine")
```

For Ollama:

```powershell
$env:LLM_PROVIDER = "ollama"
$env:LLM_MODEL = "llama3.1"
$env:OLLAMA_BASE_URL = "http://localhost:11434/v1"
```

For a temporary workshop key (facilitator-managed):

```powershell
$env:LLM_PROVIDER = "openai"
$env:LLM_MODEL = "gpt-4o-mini"
$env:WORKSHOP_OPENAI_API_KEY = "<temporary-key>"
$env:OPENAI_API_KEY = $env:WORKSHOP_OPENAI_API_KEY
```

Facilitator note: set strict budget/rate limits on temporary keys and rotate or revoke immediately after the workshop.

## In-Notebook Run Order

1. Run Cell 1 (Quick Start instructions).
2. Run Cell 2 (auto-install dependencies if missing).
3. Run Cell 3 (validation checks).
4. Run Cell 4 (API key setup choice).
5. Run Cell 5 and the rest of the notebook.

## Troubleshooting

- If imports fail after install, restart the kernel and run Cell 3 again.
- If API errors occur, verify the provider and matching runtime option.
- If network restrictions block installs, use a pre-provisioned environment image.
- If Cell 2 fails with "No module named pip", bootstrap pip in that environment:

```powershell
python -m ensurepip --upgrade
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```
