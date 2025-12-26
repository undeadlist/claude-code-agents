# New Feature Workflow

Develop new features with test-first approach.

## Agents Used
1. `test-writer` - Write tests first (TDD)
2. `code-fixer` - Implement the feature
3. `test-runner` - Verify tests pass
4. `browser-qa-agent` - Visual verification

## Trigger
- Manual: When starting a new feature

## Execution

```
claude "Run new-feature workflow for [FEATURE]:

1. test-writer: Create tests for expected behavior
2. code-fixer: Implement feature to pass tests
3. test-runner: Verify all tests pass
4. browser-qa-agent: Test in browser (if UI feature)

Feature specification:
[Describe the feature requirements]"
```

## Agent Chain

```
┌─────────────────────────────────────────────────┐
│  1. test-writer                                 │
│     - Analyze feature requirements              │
│     - Write failing tests first                 │
│     - Cover happy path + edge cases             │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  2. code-fixer                                  │
│     - Implement feature                         │
│     - Follow existing patterns                  │
│     - Make tests pass                           │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  3. test-runner                                 │
│     - Run all tests                             │
│     - Verify new tests pass                     │
│     - Check no regressions                      │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  4. browser-qa-agent (if UI)                    │
│     - Navigate to feature                       │
│     - Test interactions                         │
│     - Check for console errors                  │
└─────────────────────────────────────────────────┘
```

## Example Usage

### API Feature

```
claude "Run new-feature workflow:

Feature: User profile update endpoint
- PUT /api/users/:id
- Allow updating: name, email, avatar
- Require authentication
- Validate email format
- Return updated user

Use test-first approach."
```

### UI Feature

```
claude "Run new-feature workflow:

Feature: Dark mode toggle
- Add toggle to settings page
- Persist preference to localStorage
- Apply theme immediately
- Support system preference

Start with component tests, then implement."
```

## Expected Output

### Phase 1: test-writer
```
Created tests:
- src/api/users/[id].test.ts
  - should return 401 without auth
  - should return 404 for non-existent user
  - should update name successfully
  - should validate email format
  - should return updated user
```

### Phase 2: code-fixer
```
Implemented:
- src/api/users/[id]/route.ts (new)
- src/lib/validation.ts (updated)
```

### Phase 3: test-runner
```
Tests: 5 passed, 0 failed
Coverage: 95%
```

### Phase 4: browser-qa-agent
```
Browser tests:
- [x] Profile page loads
- [x] Edit form displays
- [x] Save updates correctly
- [x] No console errors
```

## Best Practices

1. **Clear requirements** - Be specific about expected behavior
2. **Test first** - Let test-writer define the contract
3. **Small increments** - One feature at a time
4. **Verify visually** - Always check in browser for UI
5. **Check coverage** - Ensure new code is tested

## Skip browser-qa for

- Pure API features (no UI)
- Library/utility code
- Database migrations
- Background jobs
