# Pre-Deploy Workflow

Run before any deployment to production.

## Agents Used
1. `deploy-checker` - Validate build and config
2. `env-validator` - Check environment variables
3. `dep-auditor` - Check for vulnerabilities

## Trigger
- Manual: Before deploying
- CI/CD: Part of deployment pipeline

## Execution

```
claude "Run pre-deploy workflow:
1. Run deploy-checker for build validation
2. Run env-validator for config check
3. Run dep-auditor for security scan

All three must pass before deployment."
```

## Agent Chain

```
┌─────────────────────────────────────────────────┐
│  RUN IN PARALLEL                                │
├─────────────────────────────────────────────────┤
│  deploy-checker    env-validator    dep-auditor │
│  - Build works     - Env vars set   - No vulns  │
│  - No errors       - No secrets     - Updated   │
│  - Bundle OK       - Config valid   - Licensed  │
└─────────────────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────┐
│  GATE CHECK                                     │
│  - All pass → "Ready to deploy"                 │
│  - Any fail → "BLOCKED - Fix first"             │
└─────────────────────────────────────────────────┘
```

## Expected Output

```markdown
# Pre-Deploy Checklist

## Status: READY / BLOCKED

### Build Validation (deploy-checker)
- [x] TypeScript compiles
- [x] Production build succeeds
- [x] Bundle size acceptable
- [ ] BLOCKED: [issue]

### Environment (env-validator)
- [x] All required vars set
- [x] No secrets in code
- [x] Production config valid
- [ ] BLOCKED: [missing var]

### Dependencies (dep-auditor)
- [x] No critical vulnerabilities
- [x] No high vulnerabilities
- [ ] 2 medium vulnerabilities (acceptable)
- [ ] BLOCKED: [CVE details]

## Deployment Decision

✅ READY TO DEPLOY
or
🛑 BLOCKED - Fix issues:
1. [Issue 1]
2. [Issue 2]
```

## CI/CD Integration

### GitHub Actions

```yaml
deploy:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4

    - name: Pre-deploy checks
      run: |
        # Run all checks
        npm run build
        npm audit --production
        # Add more checks

    - name: Deploy
      if: success()
      run: npm run deploy
```

## Manual Checklist

If not using agents, verify manually:

```bash
# Build check
npm run build

# TypeScript check
npx tsc --noEmit

# Security audit
npm audit --production

# Env check
diff <(grep "^[A-Z]" .env.example) <(grep "^[A-Z]" .env)

# All pass? Deploy.
npm run deploy
```

## Rollback Plan

If deployment fails:

1. **Vercel/Netlify:** Instant rollback in dashboard
2. **Manual:** `git revert HEAD && git push`
3. **Database:** Have migration rollback ready
