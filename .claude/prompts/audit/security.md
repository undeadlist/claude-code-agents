# Security Audit

Find vulnerabilities. Be thorough. Output to `.claude/audits/AUDIT_SECURITY.md`.

## Check

**Auth**
- Unprotected API routes
- IDOR (accessing other users' data via ID manipulation)
- Missing session validation
- Broken role checks

**Input**
- SQL injection (raw queries, string interpolation)
- XSS (dangerouslySetInnerHTML, unsanitized output)
- Path traversal (file operations with user input)
- Command injection

**Data**
- Secrets in responses
- PII in logs
- Stack traces in production
- Debug endpoints live

**Config**
- Hardcoded credentials
- Env vars in client bundles
- Missing rate limits on auth
- No CSRF protection

## Grep

```bash
# Unprotected routes
grep -rn "export.*GET\|POST\|PUT\|DELETE" src/app/api --include="*.ts" | head -30

# Raw queries
grep -rn "\$queryRaw\|\$executeRaw" src --include="*.ts"

# Secrets in code
grep -rn "sk_live\|password.*=.*['\"]" src --include="*.ts"

# Client env leaks
grep -rn "process.env\." src --include="*.tsx" | grep -v NEXT_PUBLIC

# XSS vectors
grep -rn "dangerouslySetInnerHTML" src --include="*.tsx"
```

## Output

```markdown
# Security Audit

## Summary
| Severity | Count |
|----------|-------|
| Critical | X |
| High | X |
| Medium | X |

## Critical

### SEC-001: [Title]
**File:** `path:line`
**Issue:** What's wrong
**Exploit:** How to attack it
**Fix:**
\`\`\`ts
// fixed code
\`\`\`

## High
...
```

Verify before reporting. Include proof.
