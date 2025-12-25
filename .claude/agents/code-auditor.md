---
name: code-auditor
description: Code quality auditor. Reviews patterns, maintainability, architecture.
tools: Read, Grep, Glob, Bash
model: inherit
---

# Code Audit

Find quality issues. Output to `.claude/audits/AUDIT_CODE.md`.

## Check

**Types**
- `any` usage (should be near zero)
- Missing null checks
- Unsafe assertions
- Implicit any from untyped imports

**Errors**
- Empty catch blocks
- Silent failures
- Missing error boundaries (React)
- Unhelpful error messages
- Unhandled promise rejections

**Structure**
- Functions over 50 lines
- Nesting over 3 levels
- God files (>500 lines)
- Duplicate logic across files
- Inconsistent naming conventions

**Data**
- N+1 queries
- Unbounded fetches (no limit/pagination)
- Non-atomic updates on shared state
- Missing database indexes on queried fields

**Patterns**
- DRY violations
- API response inconsistency
- Frontend/backend contract mismatches

## Grep

```bash
# any count
grep -rn ": any" src --include="*.ts" --include="*.tsx" | wc -l

# Empty catch
grep -rn "catch.*{}" src --include="*.ts"

# console.log
grep -rn "console.log" src/app --include="*.ts"

# TODO/FIXME
grep -rn "TODO\|FIXME" src --include="*.ts" | wc -l

# Long files
find src -name "*.ts" -o -name "*.tsx" | xargs wc -l | sort -n | tail -10
```

## Output

```markdown
# Code Audit

## Summary
| Severity | Count |
|----------|-------|
| Critical | X |
| High | X |
| Medium | X |
| Low | X |

**Metrics:** X files, Y `any`, Z console.logs

## Critical

### CODE-001: [Title]
**File:** `path:line`
**Issue:** What's wrong
**Fix:** Specific recommendation

## High

### CODE-002: Empty catch blocks swallow errors
**File:** `src/lib/api.ts:89`
**Issue:** Errors are caught but not logged or handled
**Fix:** Add error logging and appropriate user feedback

### CODE-003: Function exceeds 80 lines
**File:** `src/components/Dashboard.tsx:45`
**Issue:** handleSubmit function is too complex to test
**Fix:** Extract validation and API calls to separate functions

## Medium

### CODE-004: Duplicate validation logic
**File:** `src/components/Form.tsx:23`, `src/pages/Register.tsx:67`
**Issue:** Same email validation in multiple places
**Fix:** Create shared validation utility

### CODE-005: Inconsistent API response shape
**File:** `src/api/users.ts:34`, `src/api/products.ts:28`
**Issue:** Some endpoints return `{ data }`, others return raw array
**Fix:** Standardize to `{ data, error, meta }` pattern
```

Focus on things that cause bugs, not style preferences. Include file:line for every finding.
