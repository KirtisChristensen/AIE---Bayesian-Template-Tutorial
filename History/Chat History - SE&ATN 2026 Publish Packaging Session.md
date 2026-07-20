# Chat History — SE&ATN 2026 Publish Packaging Session

**Date:** 2026-06-29  
**Project:** Reusable LLM-Driven Bayesian AIE Notebook Suite  
**Session Goal:** Package the current tutorial notebook for deployment at the 2026 SE&ATN Symposium ahead of the RAMS conference.

---

## Context

The tutorial notebook (`llm_bayesian_reliability_tool.ipynb`) had been developed and hardened through Increments A, B, and C (see Requirements and Design document v0.2). The abstract was accepted to the 2026 SE&ATN Symposium under the title:

> **"AI-Driven Bayesian Templates for Hubbard's AIE in engineering decisions under uncertainty"**  
> Presenter: Kirtis Christensen, Raytheon / RTX  
> Track: RTX Tech Roadmap – Artificial Intelligence  
> Session Type: Tutorial (International Friendly, no ITAR/EAR content)

The SE&ATN session serves as a live rehearsal for the larger RAMS conference deployment. Priority was ease of participant setup: download, install, run.

---

## Problem Found During Packaging

The root `requirements.txt` and `environment.yml` were **incomplete** — they only listed `litellm`, `pydantic`, and `openai`. The notebook's auto-install cell (Cell 3) installs a broader set:

```
numpy, scipy, pandas, matplotlib, seaborn, networkx,
openai, pymc, arviz, ipywidgets
```

These were missing from both dependency files, meaning a fresh conda or pip install from the project root would fail to run the notebook. This was corrected in this session.

---

## Work Completed This Session

### 1. Created `Publish/SE-ATN-2026/` Package Folder

Location: `Publish/SE-ATN-2026/`  
Distributable ZIP: `Publish/SE-ATN-2026-tutorial.zip` (~0.2 MB)

#### Files in the package:

| File | Purpose |
|------|---------|
| `llm_bayesian_reliability_tool_SE-ATN-2026.ipynb` | Main tutorial notebook, title/footer updated for SE&ATN 2026 |
| `environment.yml` | Complete conda environment (all deps including pymc, arviz) |
| `requirements.txt` | Complete pip fallback list |
| `.env.example` | API key credential template |
| `install_before_tutorial.ps1` | Windows PowerShell auto-installer (conda-first, pip fallback) |
| `install_before_tutorial.bat` | Double-click Windows wrapper for the PS1 script |
| `install_before_tutorial.sh` | Mac/Linux bash installer |
| `QUICKSTART.md` | 1-page participant guide: 5-step install → API key → launch |
| `WORKSHOP_SETUP.md` | Full facilitator guide: options, troubleshooting, run order |

### 2. Notebook Updates (SE-ATN copy only)

- Title updated: `LLM-Driven Bayesian Modeling Tool for Reliability & Predictive Maintenance / RAMS 2027 Tutorial` → `AI-Driven Bayesian Templates for Hubbard's AIE in Engineering Decisions Under Uncertainty / 2026 SE&ATN Symposium Tutorial`
- Footer updated: `RAMS 2027 Tutorial Submission` → `2026 SE&ATN Symposium Tutorial`
- Original root notebook is unchanged.

### 3. Root Dependency Files Fixed

Both root `requirements.txt` and `environment.yml` updated to include the complete dependency set:

**Added to both files:**
- `numpy>=1.26`
- `scipy>=1.13`
- `pandas>=2.2`
- `matplotlib>=3.9`
- `seaborn>=0.13`
- `networkx>=3.3`
- `pymc>=5.16`
- `arviz>=0.19`
- `ipywidgets>=8.1`

**Retained from before:**
- `openai>=1.93.0`
- `litellm==1.74.9`
- `pydantic>=2.11.7`

### 4. Pre-Install Scripts

**`install_before_tutorial.ps1`** (Windows):
- Detects conda in multiple standard locations (Miniconda, Anaconda, ProgramData)
- If found: creates `aie-workshop` conda env from `environment.yml`, registers Jupyter kernel
- If not found: falls back to `pip install -r requirements.txt` with the current Python
- Clear error message if Python is not found at all, with download link

**`install_before_tutorial.sh`** (Mac/Linux):
- Same logic in bash, searches common Homebrew/home directory conda paths

**`install_before_tutorial.bat`** (Windows double-click):
- Simple wrapper that calls the PS1 with `ExecutionPolicy Bypass`

### 5. QUICKSTART.md

Written for participants with no prior setup knowledge:
- Step 1: Install Python/Miniconda (with download link)
- Step 2: Three install options (conda / pip / one-click script)
- Step 3: Get an OpenAI API key (with cost note: <$0.01 per full run)
- Step 4: Launch Jupyter Lab
- Step 5: Set the API key
- Tutorial agenda table
- Troubleshooting table (6 common failure modes)
- Package file manifest

### 6. WORKSHOP_SETUP.md (SE-ATN version)

Full facilitator guide including:
- Pre-workshop facilitator checklist
- All four setup options (conda, pip, one-click, Ollama no-key)
- API key setup for Windows PowerShell, Mac/Linux, and inline notebook
- Offline/no-key fallback instructions
- Notebook run order (cell-by-cell)
- Troubleshooting table (7 failure modes including PyMC Windows compiler issue)
- Environment preflight check command
- Distribution instructions (zip, upload, share link)

---

## Key Decisions Made

| Decision | Rationale |
|----------|-----------|
| Conda-first for install scripts | PyMC requires compiled C extensions; conda provides pre-built binaries; avoids Windows compiler failures |
| pip fallback included | Not all participants will have conda; requirements.txt covers this |
| `gpt-4o-mini` as default model | <$0.01 per full notebook run; fast; sufficient for tutorial |
| Offline fallback documented prominently | Workshop continuity if API is unavailable; `OFFLINE_JSON` already in notebook |
| SE-ATN notebook is a copy, not the original | Preserves root notebook untouched for continued RAMS development |
| Root dep files also fixed | Ensures the root project works for fresh clones, not just the Publish package |

---

## Deployment Checklist (Before SE&ATN)

- [ ] Upload `SE-ATN-2026-tutorial.zip` to a public/shared download link
- [ ] Test download and install on a clean machine (no prior Python/conda)
- [ ] Dry-run the full notebook on the clean machine using the aie-workshop kernel
- [ ] Verify offline mode works (uncomment `bayesian_model_json = OFFLINE_JSON`)
- [ ] Confirm API key flow with `gpt-4o-mini` costs <$0.01
- [ ] Prepare temporary workshop OpenAI key with a $5 budget cap
- [ ] Share download link in session announcement 2+ days before tutorial

---

## Next Steps / Build-On Items

1. **After SE&ATN dry-run**: Update this document with results — what broke, what to fix before RAMS
2. **Phase 3 (Dynamic Model Builder)**: Generalize builder beyond Gamma-Poisson per the backlog (see Requirements v0.2 §12.1)
3. **RAMS packaging**: Use this SE-ATN package as the template; update title/footer to `RAMS 2027`
4. **Backlog Item C (Prompt-Side Hardening)**: Only needed if the "Repairs applied" panel is visibly distracting in live workshop — assess during SE&ATN
5. **Scenario variants**: Consider including 2–3 pre-loaded `SCENARIO_LIBRARY` entries in the participant package so they have ready exercises without needing to write their own problem descriptions

---

## Files Modified This Session

| File | Change |
|------|--------|
| `requirements.txt` (root) | Added 9 missing packages |
| `environment.yml` (root) | Added 9 missing packages |
| `Publish/SE-ATN-2026/` (new folder) | Full participant package created |
| `Publish/SE-ATN-2026-tutorial.zip` (new) | Distributable archive |
