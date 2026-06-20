# RTSR VoI — Justification of Estimates & Measurement Approaches

Working document for the **Religious Training For Spiritual Resilience (RTSR) FY2027** AIE pilot.
Companion to [spiritual_resilience_aie_tutorial.ipynb](spiritual_resilience_aie_tutorial.ipynb)
Sections 5, 6, and 9.

This file holds the *narrative* behind each Value-of-Information input range used in the
Section 5 sensitivity scan. Update ranges here first, then mirror the changes into the
notebook's `ranges = {...}` block in the VoI cell.

---

## 1. VoI Inputs — Justification & Measurement Approach

| # | Uncertainty | Range | Justification of Estimate | Measurement Approach |
|---|---|---|---|---|
| 1 | RTSR-specific training uplift | **10–80%** | Anchored on the +50% point estimate from program advocates, but bounded wide because no peer-reviewed RCT exists for this specific Army religious-resilience curriculum. Lower bound (10%) reflects published meta-analyses of brief one-session resilience interventions, which typically show small-to-modest effects on help-seeking behavior. Upper bound (80%) reflects best-case results seen in chaplaincy-led peer programs with strong instructor presence and follow-up. | **Pre/post paired survey** of trained vs untrained cohorts on B1 (resolved beliefs) at 0, 3, and 12 months. Pair with a small **randomized waitlist control** (one battalion delayed by 6 months). Outcome metric: ΔP(B1) trained − ΔP(B1) waitlist. Calibrate the 90% CI from the resulting effect size and SE. |
| 2 | General "seek-help" uplift | **10–50%** | Broad literature on military mental-health awareness training (e.g., ACE, R2, Battlemind) shows 15–40% increases in self-reported help-seeking intent, with effect on actual help-seeking smaller and noisier. The 10–50% range brackets that literature plus the +30% point estimate provided. | **Behavioral telemetry**, not just self-report: track utilization rates of chaplain visits, MFLC appointments, and Military OneSource calls per 100 trained vs untrained soldiers over 12 months. Difference-in-differences across installations with staggered RTSR rollout gives the cleanest estimate. |
| 3 | High-risk tier suicide multiplier | **1.5×–8.0×** | Published Army suicide-risk studies show that soldiers with multiple risk factors (low social connectedness, low sense of purpose, recent stressor) have suicide rates 2–6× the all-Army baseline. The 1.5× lower bound is conservative; 8× upper bound matches the most-elevated subgroups (e.g., post-deployment + recent relationship loss + low spirituality). | **Retrospective case-control** using DoDSER (DoD Suicide Event Report) records: for each suicide/attempt in the prior 3 years, score the soldier on B1/B2/B3 from existing chaplain notes, GAT (Global Assessment Tool) data, or unit-level surveys, then compute relative risk by tier. Pre-register the analysis through DSPO. |
| 4 | Cost per suicide | **$3M–$15M** | Lower bound = lifetime productivity-loss methodology used by NIH/CDC for civilian suicides (~$1.3M) scaled up to soldier earnings + replacement training. Upper bound = DOT/DoD Value of Statistical Life (VSL) currently in the $11–13M range, with $15M as a stretch reflecting unit-cohesion and family secondary-injury costs. | **Use existing federal valuations** rather than re-estimating: cite the latest DOT VSL guidance for the central value, then add a calibrated additive term for direct DoD costs (CACO, casualty assistance, replacement recruitment + initial training). Have a reviewer (G-8 or RAND analyst) calibrate the additive component to a 90% CI. |
| 5 | Cost per attempt | **$10K–$150K** | Lower bound from TRICARE inpatient psychiatric admission averages (~$8–15K for a short stay). Upper bound covers extended ICU/inpatient care, follow-on outpatient treatment, lost duty days, and medical-board separation processing in severe cases. | **Pull a DHA/MHS GENESIS cohort**: identify all soldiers with an attempt-coded ICD encounter in the prior 24 months, sum direct medical cost + travel/per-diem + estimated lost duty days × daily comp. Report a distribution, not a single mean — the long right tail is what matters for the decision. |
| 6 | Cost per separation | **$30K–$200K** | Lower bound = published Army recruitment + initial-entry-training replacement cost for a junior enlisted soldier (~$30–55K). Upper bound covers mid-grade NCOs and skilled MOSs (e.g., 18-series, cyber, aviation) where recruitment + technical training easily exceeds $150K. | **Stratify by MOS and rank** using G-1 separation records and TRADOC training-cost figures. Weight each tier of the cohort by the MOS distribution of the 4,000 soldiers actually targeted by RTSR. Validate the upper-tail estimate against the most recent CBO or RAND replacement-cost study. |

---

## 2. How to Use This Table

- Columns 4–5 are the **AIE measurement plan** for the VoI scan — specifically what to
  fund first if the Section 5 chart says these inputs dominate the decision.
- Once a row is measured (e.g., DoDSER case-control completes), tighten its range and
  re-run notebook Sections 5 and 9; the ranking will update and the next-most-valuable
  measurement becomes the next target.
- Any row whose **decision swing × measurement cost⁻¹** ratio is small after one cycle
  should be dropped from the active measurement plan.

---

## 3. Open Questions / TODO

- [ ] Replace placeholders `X_SUICIDE_PER_100K` and `Y_IDEATION_PER_100K` in the
  notebook with current DSPO figures.
- [ ] Confirm DOT/DoD VSL value to use as the central anchor for row 4.
- [ ] Identify the FY27 RTSR cohort MOS distribution to weight row 6.
- [ ] Decide whether to add a 7th VoI row for **belief-correlation structure** (joint
  distribution of B1·B2·B3) — currently captured qualitatively in the *Measures to
  Develop* cell, item A1.
- [ ] Add data-source citations (DOI / DTIC accession) once each row's literature anchor
  is finalized.

---

## 4. Change Log

| Date | Change | Author |
|---|---|---|
| 2026-05-05 | Initial draft of VoI input justification table. | Kirtis Christensen / Copilot |
