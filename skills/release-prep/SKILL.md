---
name: release-prep
description: Full audit + fixes + deploy validation for production release
---

# Release Prep Workflow

Prepare for a production release. Runs full audit, fixes critical issues, validates deployment readiness, and generates the release PR.

## Execution (Sequential Phases)

### Phase 1: Full Audit (Parallel)
Spawn all 11 audit agents in parallel (same as `/full-audit`):
- All auditors save reports to `.claude/audits/AUDIT_*.md`

### Phase 2: Fix Planning
Spawn `fix-planner`:
- Read all audit reports
- Create `.claude/audits/FIXES.md` with prioritized action items

### Phase 3: Critical Fixes
Spawn `code-fixer`:
- Implement **P1 (critical) fixes only**
- P2/P3 can wait for next release

### Phase 4: Verification
Spawn `test-runner`:
- All tests pass (including after fixes)
- No regressions introduced

### Phase 5: Deploy Validation
Spawn `deploy-checker`:
- Build succeeds
- Environment valid
- Dependencies clean

### Phase 6: PR Generation
Spawn `pr-writer`:
- Generate release PR with summary of all changes
- Include audit findings and fixes applied

## Release Criteria

### Must Pass (Blockers)
- Zero P1 issues remaining
- All tests pass
- Build succeeds
- Deploy checker passes

### Should Pass (Document if not)
- P2 issues addressed or documented
- Performance within acceptable range
- Documentation updated

## Usage

```
/release-prep

Version: 2.1.0
Release date: 2024-03-15
```
