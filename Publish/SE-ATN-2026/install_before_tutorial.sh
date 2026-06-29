#!/usr/bin/env bash
# ============================================================
# install_before_tutorial.sh
# 2026 SE&ATN Symposium - AI-Driven Bayesian Templates Tutorial
# Run BEFORE the tutorial to install all dependencies.
#
# Usage:  chmod +x install_before_tutorial.sh && ./install_before_tutorial.sh
# ============================================================

set -e

echo ""
echo "============================================================"
echo " 2026 SE&ATN Tutorial - Pre-Install Script (Mac/Linux)"
echo "============================================================"
echo ""

# ── Detect conda ──────────────────────────────────────────────────────────────
CONDA_EXE=""
for candidate in \
    "$(command -v conda 2>/dev/null)" \
    "$HOME/miniconda3/bin/conda" \
    "$HOME/anaconda3/bin/conda" \
    "/opt/homebrew/Caskroom/miniconda/base/bin/conda"; do
    if [ -n "$candidate" ] && [ -f "$candidate" ]; then
        CONDA_EXE="$candidate"
        break
    fi
done

if [ -n "$CONDA_EXE" ]; then
    echo "Conda found: $CONDA_EXE"
    echo ""
    echo "Creating conda environment 'aie-workshop' from environment.yml ..."
    echo "(This takes 5-10 minutes on first run)"
    echo ""
    "$CONDA_EXE" env create -f environment.yml --force
    echo ""
    echo "Registering Jupyter kernel ..."
    "$CONDA_EXE" run -n aie-workshop python -m ipykernel install --user \
        --name aie-workshop --display-name "Python (aie-workshop)"
    echo ""
    echo "SUCCESS! Run the tutorial with:"
    echo "  conda activate aie-workshop"
    echo "  jupyter lab"
else
    echo "Conda not found. Using pip with current Python..."
    PYTHON_EXE="$(command -v python3 2>/dev/null || command -v python 2>/dev/null)"
    if [ -z "$PYTHON_EXE" ]; then
        echo ""
        echo "ERROR: Python not found."
        echo "Please install Miniconda from: https://docs.conda.io/en/latest/miniconda.html"
        exit 1
    fi
    echo "Python found: $PYTHON_EXE"
    echo "Installing packages from requirements.txt ..."
    "$PYTHON_EXE" -m pip install -r requirements.txt
    echo ""
    echo "SUCCESS! Run the tutorial with:"
    echo "  jupyter lab"
fi

echo ""
echo "============================================================"
echo " Setup complete. See QUICKSTART.md for next steps."
echo "============================================================"
echo ""
