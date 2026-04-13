---
name: new-feature
description: Develop new features with test-first approach (TDD)
---

# New Feature Workflow

Build features using test-driven development. Provide the feature specification when invoking.

## Execution (Sequential)

### Step 1: Write Tests
Spawn `test-writer` with the feature requirements:
- Analyze feature specification
- Write failing tests first
- Cover happy path + edge cases

### Step 2: Implement Feature
Spawn `code-fixer` with the feature requirements and test files:
- Implement feature following existing patterns
- Make all new tests pass

### Step 3: Verify
Spawn `test-runner`:
- Run all tests (new + existing)
- Verify no regressions

### Step 4: Browser QA (if UI feature)
Spawn `browser-qa-agent`:
- Navigate to the new feature
- Test interactions
- Check for console errors

## Usage

Provide feature requirements when invoking:
```
/new-feature

Feature: User profile update endpoint
- PUT /api/users/:id
- Allow updating: name, email, avatar
- Require authentication
- Validate email format
- Return updated user
```

## Skip browser-qa for
- Pure API features (no UI)
- Library/utility code
- Database migrations
- Background jobs
