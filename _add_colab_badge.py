"""Insert 'Open in Google Colab' badge into the title cell of both tutorial notebooks."""
import json, pathlib

BASE = pathlib.Path(r"c:\Users\Admin\Documents\AIE - Bayesian Template Generated from Problem Description")

REPO = "KirtisChristensen/AIE---Bayesian-Template-Tutorial"
BRANCH = "main"

NOTEBOOKS = [
    (
        BASE / "llm_bayesian_reliability_tool_working_copy.ipynb",
        f"https://colab.research.google.com/github/{REPO}/blob/{BRANCH}/llm_bayesian_reliability_tool_working_copy.ipynb",
    ),
    (
        BASE / "Publish/SE-ATN-2026/llm_bayesian_reliability_tool_SE-ATN-2026.ipynb",
        f"https://colab.research.google.com/github/{REPO}/blob/{BRANCH}/Publish/SE-ATN-2026/llm_bayesian_reliability_tool_SE-ATN-2026.ipynb",
    ),
]

BADGE_IMG = "https://colab.research.google.com/assets/colab-badge.svg"

COLAB_LINES = [
    "## Open in Google Colab\n",
    "\n",
]

def make_badge_line(url):
    return f"[![Open In Colab]({BADGE_IMG})]({url})\n"

for nb_path, colab_url in NOTEBOOKS:
    p = pathlib.Path(nb_path)
    nb = json.loads(p.read_text(encoding="utf-8"))

    # Find the first markdown cell — that's the title cell
    title_cell = next(
        (c for c in nb["cells"] if c["cell_type"] == "markdown"),
        None
    )
    if title_cell is None:
        print(f"  WARNING: no markdown cell found in {p.name}")
        continue

    src = title_cell["source"]
    src_text = "".join(src)

    # Already patched?
    if "Open in Google Colab" in src_text:
        print(f"  SKIP {p.name} — badge already present")
        continue

    # Insert before the first '---' separator line
    new_src = []
    inserted = False
    for line in src:
        if not inserted and line.strip() == "---":
            new_src.extend(COLAB_LINES)
            new_src.append(make_badge_line(colab_url))
            new_src.append("\n")
            inserted = True
        new_src.append(line)

    if not inserted:
        # Fallback: append at the end of the cell
        new_src.extend(["\n"] + COLAB_LINES + [make_badge_line(colab_url)])
        print(f"  NOTE {p.name}: no '---' found; badge appended at end of title cell")

    title_cell["source"] = new_src
    p.write_text(json.dumps(nb, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  OK  {p.name}: Colab badge inserted (url={colab_url})")

print("Done.")
