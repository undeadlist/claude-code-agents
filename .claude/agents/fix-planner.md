---
name: fix-planner
description: Creates prioritized fix plans from audit findings. Generates FIXES.md.
tools: Read, Grep, Glob, Bash
model: inherit
---

# Fix Planner

Read audits in `.claude/audits/`. Create prioritized plan. Output to `.claude/audits/FIXES.md`.

## Gather

- Read all audit reports (code-auditor, bug-auditor, security-auditor, doc-auditor)
- Consolidate duplicate findings
- Cross-reference related issues

## Priority

**P1 — Blockers** (before launch)
- Security vulnerabilities
- Data loss risks
- Auth bypasses

**P2 — Polish** (first week)
- High severity issues
- Major UX bugs
- Performance problems

**P3 — Debt** (first month)
- Code quality
- Refactors
- Documentation gaps

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

Generated: [timestamp]
Based on: code-auditor, bug-auditor, security-auditor, doc-auditor

## Summary
| Priority | Count | Effort |
|----------|-------|--------|
| P1 | X | ~Yh |
| P2 | X | ~Yh |
| P3 | X | ~Yh |
| P4 | X | — |

---

## P1

### [ ] SEC-001: Add auth to admin routes
**Source:** AUDIT_SECURITY.md
**Effort:** S
**File:** `src/app/api/admin/route.ts`
**Do:**
1. Add getServerSession check
2. Return 401 if missing
**Verify:** Curl without auth returns 401

### [ ] SEC-002: Escape user content in templates
**Source:** AUDIT_SECURITY.md
**Effort:** S
**File:** `src/components/Comment.tsx`
**Do:**
1. Replace innerHTML with textContent
2. Use DOMPurify for rich text
**Verify:** XSS payload renders as text, not script

---

## P2

### [ ] CODE-001: Reduce UserDashboard complexity
**Source:** AUDIT_CODE.md
**Effort:** M
**File:** `src/components/UserDashboard.tsx`
**Do:**
1. Extract data fetching to custom hook
2. Split into smaller components
**Verify:** File under 200 lines, single responsibility

### [ ] UI-001: Add loading states to forms
**Source:** AUDIT_UI_UX.md
**Effort:** S
**File:** `src/components/LoginForm.tsx`
**Do:**
1. Add disabled state during submit
2. Show spinner in button
**Verify:** Button shows loading state during API call

---

## P3

### [ ] DOC-001: Add JSDoc to public API functions
**Source:** AUDIT_DOCS.md
**Effort:** M
**File:** `src/lib/api.ts`
**Do:**
1. Add @param and @returns docs
2. Include usage examples
**Verify:** IDE shows documentation on hover

### [ ] CODE-002: Remove console.log statements
**Source:** AUDIT_CODE.md
**Effort:** XS
**File:** Multiple files
**Do:**
1. Replace with proper logging
2. Remove debug statements
**Verify:** `grep console.log` returns zero results

---

## Order
1. SEC-001, SEC-002 (auth first)
2. CODE-001 (depends on auth)
3. UI-001–005 (parallel)

## Notes for Implementer
- Start with Phase 1 items marked "Effort: S"
- Run test suite after each fix
- Security fixes require code review before merge
```

Group related fixes. Note dependencies.
