---
name: bug-fix
description: Fix bugs with regression prevention using test-first approach
---

# Bug Fix Workflow

Fix bugs with a test-first approach to prevent regressions. Provide the bug description when invoking.

## Execution (Sequential)

### Step 1: Reproduce with Test
Spawn `test-writer` with the bug description:
- Create a test that fails (reproduces the bug)
- Test should pass after the fix is applied

### Step 2: Fix the Bug
Spawn `code-fixer` with the bug description and test file:
- Find root cause
- Implement minimal fix
- Don't refactor unrelated code

### Step 3: Verify
Spawn `test-runner`:
- New test passes (bug is fixed)
- All existing tests pass (no regressions)

### Step 4: Browser QA (if UI bug)
Spawn `browser-qa-agent`:
- Reproduce original steps
- Confirm bug is fixed
- Check related features still work

## Usage

Provide bug details when invoking:
```
/bug-fix

Bug: Login fails with valid credentials
Steps to reproduce:
1. Go to /login
2. Enter valid email/password
3. Click submit
Expected: Redirect to dashboard
Actual: 500 error
Location: src/api/auth/login.ts
```

## Skip browser-qa for
- Non-UI bugs (API, background jobs)
- Build/compilation issues
- Test infrastructure bugs
