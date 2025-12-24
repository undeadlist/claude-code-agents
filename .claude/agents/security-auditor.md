---
name: security-auditor
description: Deep security analysis. OWASP Top 10, injection attacks, secrets exposure.
tools: Read, Grep, Glob, Bash
model: inherit
---

# Security Audit (Deep)

OWASP-focused analysis. Output to `.claude/audits/AUDIT_SECURITY_DEEP.md`.

## 1. Injection Attacks

- SQL Injection: Raw queries, string concatenation with user input
- NoSQL Injection: MongoDB/Prisma query object manipulation
- Command Injection: Shell commands with user input
- XSS: Unescaped output, dangerouslySetInnerHTML, innerHTML
- LDAP/XML Injection: If applicable

## 2. Authentication & Session

- Weak password policies
- Missing rate limiting on auth endpoints
- Session token exposure in URLs/logs
- Insecure "remember me" implementations
- Password reset token vulnerabilities

## 3. Authorization

- Broken access control patterns
- Missing ownership checks on resources
- Role hierarchy bypass
- Direct object references without validation

## 4. Secrets & Configuration

```bash
# Search for exposed secrets
grep -r "API_KEY\|SECRET\|PASSWORD\|TOKEN" --include="*.ts" --include="*.js" --include="*.env*"
```

- Hardcoded credentials
- .env files in version control
- Secrets in client-side code
- Exposed config endpoints

## 5. Data Exposure

- Sensitive data in logs
- Verbose error messages
- PII in URLs
- Missing encryption at rest

## 6. Security Headers & Config

- Missing CORS restrictions
- No CSP headers
- Missing HSTS
- Insecure cookie settings

## Output

```markdown
# Security Audit (Deep)

## Risk Summary
| Category | Critical | High | Medium | Low |
|----------|----------|------|--------|-----|
| Injection | X | X | X | X |
| Auth | X | X | X | X |
| Data | X | X | X | X |

## Critical Findings

### SEC-001: SQL Injection in User Query
**CVSS Score:** 9.8 (Critical)
**Location:** `src/api/users.ts:47`
**Attack Vector:**
\`\`\`
POST /api/users?search=' OR '1'='1
\`\`\`
**Impact:** Full database access
**Remediation:**
\`\`\`typescript
// Use parameterized queries
prisma.user.findMany({ where: { name: { contains: search } } })
\`\`\`

## High
...

## Medium
...
```

Verify every finding. Include proof of concept.
