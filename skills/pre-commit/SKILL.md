---
name: pre-commit
description: Run code quality checks and tests before committing
---

# Pre-Commit Workflow

Run before every commit to catch issues early.

## Execution (Sequential)

### Step 1: Code Audit
Spawn `code-auditor` on staged/changed files:
- Check for `any` types, empty catch blocks, console.logs, obvious bugs
- Focus only on files being committed

### Step 2: Test Run
Spawn `test-runner`:
- Run the full test suite
- Report any failures

### Step 3: Decision
- **All pass** -> "Ready to commit"
- **Any fail** -> "Fix before committing" with specific issues listed

## Expected Output

```markdown
# Pre-Commit Check

## Status: PASS / FAIL

### Code Quality
- [x] No new `any` types
- [x] No empty catch blocks
- [x] No console.logs in production code

### Tests
- [x] All tests pass
- [x] No regressions

## Verdict
Ready to commit / Fix issues first
```
