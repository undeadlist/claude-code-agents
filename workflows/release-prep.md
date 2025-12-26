# Release Prep Workflow

Prepare for a production release. Full audit + fixes + deploy validation.

## Agents Used
1. Full audit (11 auditors) → AUDIT_*.md files
2. `fix-planner` → FIXES.md
3. `code-fixer` → Implement critical fixes
4. `test-runner` → Verify fixes
5. `deploy-checker` → Final validation
6. `pr-writer` → Generate release PR

## Trigger
- Manual: Before production release
- Scheduled: Release day prep

## Execution

```
claude "Run release-prep workflow:

Version: [X.Y.Z]
Release date: [DATE]

1. Run full audit (all auditors in parallel)
2. Create FIXES.md with fix-planner
3. Implement P1 (critical) fixes with code-fixer
4. Run test-runner to verify
5. Run deploy-checker for final validation
6. Generate release PR with pr-writer

Block release if any P1 issues remain unfixed."
```

## Agent Chain

```
┌─────────────────────────────────────────────────┐
│  PHASE 1: FULL AUDIT (Parallel)                 │
│  11 auditors → .claude/audits/AUDIT_*.md        │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  PHASE 2: FIX PLANNING                          │
│  fix-planner → FIXES.md                         │
│  Prioritize: P1 must be fixed for release       │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  PHASE 3: FIX IMPLEMENTATION                    │
│  code-fixer → Implement P1 fixes only           │
│  (P2/P3 can wait for next release)              │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  PHASE 4: VERIFICATION                          │
│  test-runner → All tests pass                   │
│  Re-run affected auditors if needed             │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  PHASE 5: DEPLOY VALIDATION                     │
│  deploy-checker → Build, env, deps all valid    │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  PHASE 6: PR GENERATION                         │
│  pr-writer → Create release PR                  │
└─────────────────────────────────────────────────┘
```

## Expected Output

### Phase 1-2: Audit + Planning
```
Audit complete. Summary:
- P1 (Critical): 2 issues
- P2 (High): 5 issues
- P3 (Medium): 12 issues

FIXES.md created with prioritized action items.
```

### Phase 3-4: Fix + Verify
```
P1 fixes implemented:
1. SQL injection in search → Fixed
2. Missing auth on /api/admin → Fixed

Test results: 156/156 passing
```

### Phase 5: Deploy Check
```
Deploy Checklist: READY

✅ Build passes
✅ All env vars set
✅ No critical vulnerabilities
✅ Database migrations ready
```

### Phase 6: PR Created
```
PR #45: Release v2.1.0

Summary:
- Fixed 2 critical security issues
- Performance improvements
- Bug fixes

https://github.com/your-repo/pull/45
```

## Release Criteria

### Must Pass (Release Blockers)
- [ ] Zero P1 issues
- [ ] All tests pass
- [ ] Build succeeds
- [ ] Deploy checker passes
- [ ] No critical security vulnerabilities

### Should Pass (Can Document)
- [ ] P2 issues addressed or documented
- [ ] Performance within acceptable range
- [ ] Documentation updated

### Nice to Have
- [ ] P3/P4 issues addressed
- [ ] Tech debt reduced
- [ ] Test coverage improved

## Release Checklist

```markdown
# Release v[X.Y.Z] Checklist

## Pre-Release
- [ ] Full audit completed
- [ ] P1 issues fixed (or none found)
- [ ] All tests pass
- [ ] Build succeeds
- [ ] Deploy checker passes

## Release
- [ ] PR approved and merged
- [ ] Deployed to staging
- [ ] Smoke tested on staging
- [ ] Deployed to production
- [ ] Smoke tested on production

## Post-Release
- [ ] Monitor error rates
- [ ] Check performance metrics
- [ ] Announce release (if public)
- [ ] Document known issues
```

## Rollback Plan

If release fails:

```bash
# Revert merge commit
git revert -m 1 HEAD
git push

# Or redeploy previous version
vercel rollback  # or platform-specific command
```
