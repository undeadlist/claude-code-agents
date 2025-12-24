# Fix Planner

Read audits in `.claude/audits/`. Create prioritized plan. Output to `.claude/audits/FIXES.md`.

## Priority

**P1 — Blockers** (before launch)
- Security vulnerabilities
- Data loss risks
- Auth bypasses

**P2 — Polish** (first week)
- High severity issues
- Major UX bugs

**P3 — Debt** (first month)
- Code quality
- Refactors

**P4 — Backlog**
- Nice to have

## Effort

- **XS** < 30 min
- **S** 30 min - 2 hr
- **M** 2-8 hr
- **L** 1-3 days
- **XL** 3+ days

## Output

```markdown
# Fix Plan

## Summary
| Priority | Count | Effort |
|----------|-------|--------|
| P1 | X | ~Yh |
| P2 | X | ~Yh |
| P3 | X | ~Yh |
| P4 | X | — |

## P1

### [ ] SEC-001: Add auth to admin routes
**Source:** AUDIT_SECURITY.md
**Effort:** S
**File:** `src/app/api/admin/route.ts`
**Do:**
1. Add getServerSession check
2. Return 401 if missing
**Verify:** Curl without auth → 401

### [ ] SEC-002: ...

## P2
...

## Order
1. SEC-001, SEC-002 (auth first)
2. CODE-001 (depends on auth)
3. UI-001–005 (parallel)
```

Group related fixes. Note dependencies.
