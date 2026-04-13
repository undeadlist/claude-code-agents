---
name: full-audit
description: Run all 11 audit agents in parallel, then consolidate findings with fix-planner
---

# Full Audit Workflow

Run a comprehensive audit of the entire codebase. Use before major releases or as a weekly health check.

## Phase 1: Parallel Audit

Spawn ALL of the following agents **in parallel** (single response with multiple Task calls):

| Agent | Output File | Focus |
|-------|-------------|-------|
| `code-auditor` | `.claude/audits/AUDIT_CODE.md` | Code quality |
| `bug-auditor` | `.claude/audits/AUDIT_BUGS.md` | Runtime bugs |
| `security-auditor` | `.claude/audits/AUDIT_SECURITY.md` | OWASP deep scan |
| `doc-auditor` | `.claude/audits/AUDIT_DOCS.md` | Documentation gaps |
| `infra-auditor` | `.claude/audits/AUDIT_INFRA.md` | Infrastructure config |
| `ui-auditor` | `.claude/audits/AUDIT_UI_UX.md` | UI/UX and accessibility |
| `db-auditor` | `.claude/audits/AUDIT_DB.md` | Database performance |
| `perf-auditor` | `.claude/audits/AUDIT_PERF.md` | Performance issues |
| `dep-auditor` | `.claude/audits/AUDIT_DEPS.md` | Dependency health |
| `seo-auditor` | `.claude/audits/AUDIT_SEO.md` | SEO optimization |
| `api-tester` | `.claude/audits/API_TEST_REPORT.md` | API validation |

Each agent targets the project's source code. Provide each with a prompt like:
```
Audit [target directory]. Save report to [output file].
```

## Phase 2: Consolidation

After **all** auditors complete, spawn:
- `fix-planner` - Read all `.claude/audits/AUDIT_*.md` files and create `.claude/audits/FIXES.md` with prioritized action items

## Post-Audit Actions

1. Review `FIXES.md` - Prioritize based on your timeline
2. Run `code-fixer` - Implement P1 (critical) fixes
3. Run `test-runner` - Verify fixes work
4. Re-audit affected areas if needed
