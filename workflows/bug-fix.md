# Bug Fix Workflow

Fix bugs with regression prevention.

## Agents Used
1. `test-writer` - Write failing test for bug
2. `code-fixer` - Implement the fix
3. `test-runner` - Verify fix works
4. `browser-qa-agent` - Confirm in browser (if UI bug)

## Trigger
- Manual: When bug is reported

## Execution

```
claude "Run bug-fix workflow:

Bug: [DESCRIPTION]
Steps to reproduce:
1. [Step 1]
2. [Step 2]
Expected: [What should happen]
Actual: [What happens]

1. test-writer: Create test that reproduces the bug
2. code-fixer: Fix the bug
3. test-runner: Verify test passes (and no regressions)
4. browser-qa-agent: Confirm fix in browser"
```

## Agent Chain

```
┌─────────────────────────────────────────────────┐
│  1. test-writer                                 │
│     - Create test that fails (reproduces bug)   │
│     - Test should pass after fix                │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  2. code-fixer                                  │
│     - Find root cause                           │
│     - Implement minimal fix                     │
│     - Don't refactor unrelated code             │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  3. test-runner                                 │
│     - New test passes                           │
│     - All existing tests pass                   │
│     - No regressions introduced                 │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  4. browser-qa-agent (if applicable)            │
│     - Reproduce original steps                  │
│     - Confirm bug is fixed                      │
│     - Check related features still work         │
└─────────────────────────────────────────────────┘
```

## Example Usage

### API Bug

```
claude "Run bug-fix workflow:

Bug: Login fails with valid credentials
Steps to reproduce:
1. Go to /login
2. Enter valid email/password
3. Click submit

Expected: Redirect to dashboard
Actual: 500 error, 'Cannot read property email of undefined'

Location: Likely in src/api/auth/login.ts"
```

### UI Bug

```
claude "Run bug-fix workflow:

Bug: Modal doesn't close on backdrop click
Steps to reproduce:
1. Open any modal
2. Click outside modal (on backdrop)

Expected: Modal closes
Actual: Modal stays open

Location: src/components/Modal.tsx"
```

## Expected Output

### Phase 1: test-writer
```
Created test: src/api/auth/login.test.ts

it('should login with valid credentials', async () => {
  const { req, res } = createMocks({
    method: 'POST',
    body: { email: 'test@example.com', password: 'password123' },
  });

  await handler(req, res);

  expect(res._getStatusCode()).toBe(200);
});

Test status: FAILING (as expected - reproduces bug)
```

### Phase 2: code-fixer
```
Root cause: user object destructured before null check

Fixed in: src/api/auth/login.ts:23

- const { email } = user;  // Fails if user is null
+ const email = user?.email;
+ if (!user) return res.status(401).json({ error: 'Invalid credentials' });
```

### Phase 3: test-runner
```
Tests: 48 passed, 0 failed
New test: PASSING
No regressions detected
```

### Phase 4: browser-qa-agent
```
Verification:
1. Navigated to /login
2. Entered valid credentials
3. Clicked submit
4. ✅ Redirected to dashboard
5. ✅ No console errors
```

## Best Practices

1. **Reproduce first** - Confirm you can trigger the bug
2. **Test captures bug** - Test fails before fix, passes after
3. **Minimal fix** - Don't refactor, just fix
4. **No regressions** - All existing tests must pass
5. **Verify in context** - Test in real browser/environment

## Skip browser-qa for

- Non-UI bugs (API, background jobs)
- Build/compilation issues
- Test infrastructure bugs
