# Requirements and Design Document

## Project
Reusable LLM-Driven Bayesian AIE Notebook Suite for Workshop Delivery

## Version
- Version: 0.2
- Date: 2026-06-19
- Status: Draft for stakeholder review

## 1. Purpose
Define requirements and technical design for a reusable set of Jupyter notebooks that help participants move from natural-language problem descriptions to Bayesian decision analysis using the Applied Information Economics (AIE) workflow.

This program is tutorial-first: setup and operation simplicity are primary design constraints.

## 2. Product Vision
Create one core notebook framework plus scenario-specific notebook variants (reliability, maintenance, risk, and adjacent domains) that share a common architecture:
- AIE step-by-step flow
- LLM problem parsing into structured Bayesian JSON
- Prior and likelihood mapping
- Bayesian updating and decision outputs
- Value of Information and Monte Carlo analysis

## 3. Scope
### In Scope
- Reusable notebook template structure and conventions.
- Clear participant onboarding and environment setup paths.
- Prompt-to-JSON model extraction with schema validation.
- Dynamic model mapping path (from JSON to runnable Bayesian model).
- Offline fallback path for workshop continuity.
- Tutorial-grade outputs: DAG, posterior summaries, cost/risk comparisons, recommendations.

### Out of Scope (Current Program)
- Production SaaS application with user accounts and backend services.
- Enterprise data connectors (CMMS, ERP, historians) as first-class integrations.
- Regulatory submission workflows.
- Real-time streaming model updates.

## 4. Stakeholders and User Roles
- Product Owner / Workshop Lead: Kirtis Christensen
- Technical Co-Design: Bayesian method mentor role
- Primary Users: workshop participants, reliability engineers, analysts
- Secondary Users: collaborators, reviewers, conference audience

## 5. Problem Statement
Current Bayesian adoption barriers in workshop settings:
1. Modeling barrier: users struggle to map natural-language uncertainty into priors and likelihoods.
2. Setup barrier: environments, dependencies, and API credentials fail during live sessions.
3. Reuse barrier: one-off notebooks are hard to adapt across scenarios.

The notebook suite must reduce all three barriers while preserving methodological rigor.

## 6. Success Criteria
### Workshop Success
- New participant can execute the guided path end-to-end in under 20 minutes of setup.
- Notebook run order and credential setup are explicit and self-correcting.
- At least one no-key/no-cloud execution path exists (offline JSON and/or local model option).

### Technical Success
- JSON model contract is validated before downstream inference.
- Dynamic mapping from model JSON to executable Bayesian model is demonstrated for approved model classes.
- Statistical outputs are reproducible with fixed seeds and documented tolerances.

### Reuse Success
- Same template supports at least 3 scenario variants with minimal code edits.
- New scenario onboarding requires only: decision frame updates, prompt tuning, and test cases.

## 7. Functional Requirements
### FR-1 Guided Workshop Flow
System shall provide clearly labeled step-by-step cells from setup to recommendation.

Acceptance:
- User can follow cell order without external instructions.
- Step headers and run order are consistent across notebook variants.

### FR-2 Environment and Dependency Setup
System shall support simple local setup, plus fallback options when package tooling differs.

Acceptance:
- Fresh environment setup succeeds using documented commands.
- Missing package diagnostics are actionable.

### FR-3 Credential Setup Options
System shall provide explicit runtime options:
- Personal API key path
- Temporary workshop key path
- Local no-key path when supported

Acceptance:
- Notebook can detect whether required credentials are present.
- Clear warnings appear before model calls when credentials are missing.

### FR-4 Natural-Language to Bayesian JSON
System shall convert problem description text into structured model JSON.

Acceptance:
- JSON parse succeeds.
- Required fields exist and are typed.

### FR-5 Schema Validation and Guardrails
System shall validate model JSON before inference or DAG rendering.

Acceptance:
- Invalid JSON yields readable diagnostics and blocks unsafe downstream execution.

### FR-6 Dynamic Model Builder (Core Program Requirement)
System shall map validated model JSON into executable Bayesian models for approved families.

Phase-1 approved family set:
- Gamma-Poisson
- Normal linear regression
- Binomial-Beta

Acceptance:
- For each approved family, generated model runs and produces posterior summary.
- Unit test prompts map to correct family and parameter names.

### FR-7 Offline and Continuity Mode
System shall include a full fallback path that does not require external LLM APIs.

Acceptance:
- Workshop can continue if external API is unavailable.

### FR-8 VoI and Decision Analysis
System shall compute EVPI-style metrics and run Monte Carlo strategy comparison.

Acceptance:
- Outputs include mean/quantile summaries and recommendation confidence.

### FR-9 Explainability and Traceability
System shall provide visible reasoning artifacts:
- node definitions
- dependencies
- update chain
- assumptions

Acceptance:
- DAG and summary text are generated from model structure.
- All key assumptions are inspectable in notebook outputs.

### FR-10 Reusable Template Packaging
System shall define a standard template and naming conventions for new notebook variants.

Acceptance:
- New variant can be created from template with a checklist and pass baseline tests.

## 8. Non-Functional Requirements
### NFR-1 Simplicity
- Minimal participant setup steps.
- Explicit error recovery for common workshop failures.

### NFR-2 Reproducibility
- Fixed seeds, pinned dependencies, and deterministic parser settings where possible.

### NFR-3 Portability
- Works on local Jupyter and Colab with documented differences.

### NFR-4 Reliability
- Graceful handling for missing keys, unavailable models, and network failures.

### NFR-5 Maintainability
- Shared helper utilities and common cell patterns across notebooks.

## 9. Architecture and Design
### 9.1 Layered Notebook Architecture
1. Input Layer
- Decision frame and scenario metadata.

2. Runtime Setup Layer
- Dependency checks, environment checks, credential checks.

3. Parsing Layer
- Prompt templates and LLM calls.
- JSON parsing and schema validation.

4. Model Layer
- Distribution mapping registry.
- Dynamic model builder for approved model families.

5. Analysis Layer
- Posterior diagnostics, VoI, Monte Carlo decision simulation.

6. Presentation Layer
- DAG, tables, plots, recommendation narrative.

### 9.2 Data Contract (Canonical JSON)
Top-level keys:
- problem_summary
- decision
- measurement_nodes
- bayesian_update_chain
- voi_candidates
- model_notes

Each node includes:
- name
- description
- role
- distribution_family
- distribution_parameters
- justification
- data_source
- depends_on

### 9.3 Dynamic Mapping Strategy
- Use a distribution registry to map JSON distribution families to PyMC primitives.
- Use dependency resolution (topological ordering) to construct node graph safely.
- Allow formula expressions only through validated symbol tables.
- Fail closed on unknown distributions or unresolved dependencies.

## 10. Risks and Mitigations
1. LLM output variance
- Mitigation: schema validation, low-temperature prompting, constrained response format, fallback JSON.

2. Live workshop setup failures
- Mitigation: preflight checklist, local fallback path, tested environment files.

3. Overconfidence from sparse data
- Mitigation: uncertainty intervals, sensitivity analysis, assumptions section.

4. Dynamic model builder complexity
- Mitigation: phased support by model family and strict test suites per family.

5. Scope creep
- Mitigation: phase gates with explicit sign-off before each next increment.

## 11. Development Phases and Gates
## Phase 0 - Program Baseline (Current)
Deliverables:
- Updated requirements and design document.
- Current notebook inventory and baseline assessment.

Gate:
- Stakeholder approval of scope, priorities, and phase order.

## Phase 1 - Workshop Hardening
Deliverables:
- Unified setup instructions and runtime credential guidance.
- Reliable local/Colab runbook.
- Preflight checks (dependencies, keys, fallback readiness).

Gate:
- Non-author dry run succeeds from clean environment.

## Phase 2 - JSON Contract and Validation
Deliverables:
- Canonical schema and validator utilities.
- Validation report cell and failure diagnostics.

Gate:
- Approved prompt set achieves 100% schema-valid output.

## Phase 3 - Dynamic Model Builder MVP
Deliverables:
- JSON to PyMC model builder for three approved families.
- Symbol-safe formula evaluation.
- Cross-checks against hardcoded reference models.

Gate:
- MVP families pass numerical and execution tests.

## Phase 4 - Reusable Template and Variant Pack
Deliverables:
- Base notebook template.
- At least three scenario variants using same template.
- Variant creation checklist.

Gate:
- New variant created and validated within one development session.

## Phase 5 - Tutorial Quality and Packaging
Deliverables:
- Workshop facilitator guide.
- Participant quick-start and troubleshooting guide.
- Final tutorial datasets and examples.

Gate:
- Full rehearsal with timing and issue log complete.

## Phase 6 - Research and Conference Consolidation
Deliverables:
- Reproducible figures/tables package.
- Case-study narratives and technical appendices.

Gate:
- Stakeholder approval for external distribution.

## 12. Immediate Path Forward (Next 2 Increments)
### Increment A (Now)
- Freeze the canonical JSON schema.
- Add a schema validation cell to the working notebook.
- Add a preflight cell that checks runtime mode (OpenAI, workshop key, Ollama, offline).

### Increment B (After A Approval)
- Implement Dynamic Model Builder MVP for Gamma-Poisson first.
- Compare dynamic output versus existing hardcoded PyMC cell.
- Add pass/fail assertions for posterior mean and interval sanity.

## 13. Acceptance Evidence per Phase
Each phase requires:
- Reproducible run output (notebook or logs).
- Validation summary (pass, fail, known issues).
- Decision: approve next phase or rework current phase.

## 14. Review and Sign-Off
- Reviewer: ____________________
- Date: ____________________
- Decision: Approve / Approve with Changes / Rework
- Notes: ____________________
