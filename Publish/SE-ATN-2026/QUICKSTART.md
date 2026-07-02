# Quick Start — 2026 SE&ATN Symposium Tutorial
## AI-Driven Bayesian Templates for Hubbard's AIE in Engineering Decisions Under Uncertainty
**Presenter: Kirtis Christensen, Raytheon / RTX**

---

## Choose Your Setup Path

---

### Path 1 — Google Colab (Easiest, Recommended)

No installation needed. Just a browser and a Google account.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/KirtisChristensen/AIE---Bayesian-Template-Tutorial/blob/main/Publish/SE-ATN-2026/llm_bayesian_reliability_tool_SE-ATN-2026.ipynb)

1. **Click the badge above** (or get the link from the facilitator) to open directly in Colab — or go to [colab.research.google.com](https://colab.research.google.com) and upload `llm_bayesian_reliability_tool_SE-ATN-2026.ipynb` via *File → Upload notebook*
2. **Add your API key as a Colab Secret:**
   - Click the 🔑 **key icon** in the left sidebar → *Secrets* tab → *Add new secret*
   - Name: `OPENAI_API_KEY` | Value: your key (starts with `sk-`)
   - Toggle **Notebook access** ON
3. **Runtime → Run all** — packages install automatically in ~2–3 min, then follow along

> No key yet? See Step 3 below for how to get one (2 min, costs under $0.01 for this tutorial).  
> Facilitator may also provide a temporary workshop key — add it the same way.

---

### Path 2 — Local Install (Do This BEFORE the Tutorial, 15–20 min)

### Step 1 — Install Python (if you don't have it)

**Recommended: Miniconda** (lightweight, works on Windows/Mac/Linux)  
Download from: https://docs.conda.io/en/latest/miniconda.html

> Already have Anaconda or Python 3.11+? Skip to Step 2.

---

### Step 2 — Install Dependencies

**Option A — Conda (recommended, most reliable):**
```
conda env create -f environment.yml
conda activate aie-workshop
python -m ipykernel install --user --name aie-workshop --display-name "Python (aie-workshop)"
```

**Option B — pip (if you already have Python 3.11+):**
```
pip install -r requirements.txt
```

**Option C — Windows one-click script:**  
Double-click `install_before_tutorial.bat`  
*(or right-click → Run with PowerShell on `install_before_tutorial.ps1`)*

---

### Step 3 — Get an OpenAI API Key (takes 2 min)

1. Go to: https://platform.openai.com/api-keys  
2. Sign in or create a free account  
3. Click **+ Create new secret key**, copy it somewhere safe  
4. Cost for this tutorial with `gpt-4o-mini`: **under $0.01 total**

> **No API key?** The facilitator may provide a temporary workshop key, or you can run in Offline Mode (pre-loaded example runs without a key).

---

### Step 4 — Launch the Notebook

```
conda activate aie-workshop        # (if using conda)
jupyter lab
```

Then open `llm_bayesian_reliability_tool_SE-ATN-2026.ipynb`.

Select kernel: **Python (aie-workshop)** *(or your Python 3.11+ environment)*

---

### Step 5 — Set Your API Key Before Running Cells

In the notebook, find the **LLM Configuration** cell and either:
- Set it in your terminal before launching Jupyter:
  ```
  set OPENAI_API_KEY=sk-your-key-here        (Windows CMD)
  $env:OPENAI_API_KEY = "sk-your-key-here"  (PowerShell)
  export OPENAI_API_KEY="sk-your-key-here"  (Mac/Linux)
  ```
- Or paste your key directly into the `API_KEY = "..."` line in the configuration cell

---

## Tutorial Outline (60–90 min)

| Time | What Happens |
|------|-------------|
| 10–20 min | Overview of Hubbard's AIE and Bayesian concepts |
| 20–40 min | Live demo: AI parses problem → structured JSON → Bayesian model |
| 20–40 min | Your turn: use your own R&M scenario |
| 10–20 min | Discussion: VoI, scaling, pitfalls, extensions |

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `ModuleNotFoundError` | Re-run Cell 1 (auto-installs); or run `pip install -r requirements.txt` |
| `API key invalid` | Check key has no extra spaces; ensure it starts with `sk-` |
| `pymc` install fails on Windows | Use the conda path (Option A) — avoids C compiler issues |
| Jupyter kernel not found | Run: `python -m ipykernel install --user --name aie-workshop` |
| No API key available | Uncomment `# bayesian_model_json = OFFLINE_JSON` in the parser cell |

---

## Files in This Package

| File | Purpose |
|------|---------|
| `llm_bayesian_reliability_tool_SE-ATN-2026.ipynb` | Main tutorial notebook |
| `environment.yml` | Conda environment (recommended) |
| `requirements.txt` | pip fallback |
| `.env.example` | Template for your API key (rename to `.env`) |
| `install_before_tutorial.ps1` | Windows PowerShell pre-install script |
| `install_before_tutorial.sh` | Mac/Linux pre-install script |
| `QUICKSTART.md` | This file |
| `WORKSHOP_SETUP.md` | Full setup and facilitator guide |

---

*Questions before the tutorial? Contact the presenter.*  
*Session track: RTX Tech Roadmap – Artificial Intelligence*
