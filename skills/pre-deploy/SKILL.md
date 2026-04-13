---
name: pre-deploy
description: Validate build, environment, and dependencies before deployment
---

# Pre-Deploy Workflow

Run before any deployment to production. All checks must pass.

## Execution (Parallel)

Spawn all three agents **in parallel**:

| Agent | Focus |
|-------|-------|
| `deploy-checker` | Build validation, bundle size, production config |
| `env-validator` | Environment variables, secrets detection, config completeness |
| `dep-auditor` | Vulnerability scan, outdated packages, license compliance |

## Gate Check

After all agents complete:
- **All pass** -> "Ready to deploy"
- **Any fail** -> "BLOCKED - Fix first" with specific blockers listed

## Expected Output

```markdown
# Pre-Deploy Checklist

## Status: READY / BLOCKED

### Build Validation (deploy-checker)
- [x] Production build succeeds
- [x] Bundle size acceptable
- [x] No build warnings

### Environment (env-validator)
- [x] All required vars set
- [x] No secrets in code
- [x] Production config valid

### Dependencies (dep-auditor)
- [x] No critical vulnerabilities
- [x] No high vulnerabilities

## Deployment Decision
READY TO DEPLOY / BLOCKED - Fix issues
```
