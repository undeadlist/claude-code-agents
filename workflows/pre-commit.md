# Pre-Commit Workflow

Run before every commit to catch issues early.

## Agents Used
1. `code-auditor` - Check for quality issues
2. `test-runner` - Verify tests pass

## Trigger
- Manual: Before committing
- Automated: Git pre-commit hook

## Execution

```
claude "Run pre-commit workflow:
1. Run code-auditor on staged files
2. Run test-runner
3. Report any blockers

Only proceed with commit if both pass."
```

## Agent Chain

```
┌─────────────────────────────────────────────────┐
│  1. code-auditor                                │
│     - Check staged files only                   │
│     - Focus on: any types, empty catches,       │
│       console.logs, obvious bugs                │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  2. test-runner                                 │
│     - Run full test suite                       │
│     - Report failures                           │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  3. Decision                                    │
│     - All pass → "Ready to commit"              │
│     - Any fail → "Fix before committing"        │
└─────────────────────────────────────────────────┘
```

## Expected Output

```markdown
# Pre-Commit Check

## Status: PASS / FAIL

### Code Quality
- [x] No new `any` types
- [x] No empty catch blocks
- [x] No console.logs in production code
- [ ] Issue found: [description]

### Tests
- [x] All tests pass (45/45)
- [x] No test failures
- [ ] Failed: [test name]

## Verdict
Ready to commit / Fix issues first
```

## Git Hook Integration

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
echo "Running pre-commit checks..."
claude "Run pre-commit workflow on staged files" --no-interactive

if [ $? -ne 0 ]; then
    echo "Pre-commit checks failed. Fix issues before committing."
    exit 1
fi
```

## Quick Checks (No Agent)

For faster commits, run manually:

```bash
# TypeScript check
npx tsc --noEmit

# Lint staged files
npx lint-staged

# Run tests
npm test
```
