# Code Audit

Find quality issues. Output to `.claude/audits/AUDIT_CODE.md`.

## Check

**Types**
- `any` usage (should be near zero)
- Missing null checks
- Unsafe assertions

**Errors**
- Empty catch blocks
- Silent failures
- Missing error boundaries (React)
- Unhelpful messages

**Structure**
- Functions over 50 lines
- Nesting over 3 levels
- God files
- Duplicate logic

**Data**
- N+1 queries
- Unbounded fetches (no limit/pagination)
- Non-atomic updates on shared state

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
| Type | Count |
|------|-------|
| Critical | X |
| Warning | X |
| Note | X |

**Metrics:** X files, Y `any`, Z console.logs

## Critical

### CODE-001: [Title]
**File:** `path:line`
**Issue:** What's wrong
**Fix:** What to do

## Warnings
...
```

Focus on things that cause bugs, not style preferences.
