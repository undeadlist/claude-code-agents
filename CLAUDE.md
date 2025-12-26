# CLAUDE.md

You're the orchestrator. Spawn subagents via `Task()` for focused work.

## Agents (24 Total)

### Audit Agents (11)
| Type | Prompt | Does |
|------|--------|------|
| `bug-auditor` | `.claude/agents/bug-auditor.md` | Security & bugs |
| `code-auditor` | `.claude/agents/code-auditor.md` | Code quality |
| `security-auditor` | `.claude/agents/security-auditor.md` | OWASP deep scan |
| `doc-auditor` | `.claude/agents/doc-auditor.md` | Documentation |
| `infra-auditor` | `.claude/agents/infra-auditor.md` | Config/infra |
| `ui-auditor` | `.claude/agents/ui-auditor.md` | UI/UX & a11y |
| `db-auditor` | `.claude/agents/db-auditor.md` | Database & queries |
| `perf-auditor` | `.claude/agents/perf-auditor.md` | Performance |
| `dep-auditor` | `.claude/agents/dep-auditor.md` | Dependencies |
| `seo-auditor` | `.claude/agents/seo-auditor.md` | SEO & meta tags |
| `api-tester` | `.claude/agents/api-tester.md` | API validation |

### Fix/Implement Agents (4)
| Type | Prompt | Does |
|------|--------|------|
| `fix-planner` | `.claude/agents/fix-planner.md` | Prioritize fixes |
| `code-fixer` | `.claude/agents/code-fixer.md` | Implement fixes |
| `test-runner` | `.claude/agents/test-runner.md` | Run tests |
| `test-writer` | `.claude/agents/test-writer.md` | Generate tests |

### Browser QA Agents (4)
| Type | Prompt | Does |
|------|--------|------|
| `browser-qa-agent` | `.claude/agents/browser-qa-agent.md` | Chrome UI testing |
| `fullstack-qa-orchestrator` | `.claude/agents/fullstack-qa-orchestrator.md` | Find-fix-verify loop |
| `console-monitor` | `.claude/agents/console-monitor.md` | Real-time console |
| `visual-diff` | `.claude/agents/visual-diff.md` | Screenshot comparison |

### Deploy Agents (2)
| Type | Prompt | Does |
|------|--------|------|
| `deploy-checker` | `.claude/agents/deploy-checker.md` | Pre-deploy validation |
| `env-validator` | `.claude/agents/env-validator.md` | Environment config |

### Utility Agents (2)
| Type | Prompt | Does |
|------|--------|------|
| `pr-writer` | `.claude/agents/pr-writer.md` | PR descriptions |
| `seed-generator` | `.claude/agents/seed-generator.md` | Test data |

### Supervisors (1)
| Type | Prompt | Does |
|------|--------|------|
| `architect-reviewer` | `.claude/agents/architect-reviewer.md` | Final approval |

## Spawning

**Single:**
```
Task(subagent_type="bug-auditor", prompt="...", description="Security")
```

**Parallel (same response):**
```
Task(subagent_type="bug-auditor", prompt="...", description="Security")
Task(subagent_type="code-auditor", prompt="...", description="Code")
Task(subagent_type="security-auditor", prompt="...", description="OWASP")
Task(subagent_type="db-auditor", prompt="...", description="Database")
```

**Sequential:** Wait for result, then next Task.

## Workflows

See `workflows/` directory for detailed workflow definitions.

| Workflow | Purpose | Agents |
|----------|---------|--------|
| `pre-commit` | Before committing | code-auditor, test-runner |
| `pre-deploy` | Before deployment | deploy-checker, env-validator, dep-auditor |
| `full-audit` | Complete audit | All 11 auditors → fix-planner |
| `new-feature` | Build feature | test-writer, code-fixer, test-runner, browser-qa |
| `bug-fix` | Fix bugs | test-writer, code-fixer, test-runner |
| `release-prep` | Release prep | full-audit, fixes, deploy-checker, pr-writer |

**Quick commands:**
- **Full audit:** Spawn all auditors parallel → fix-planner
- **Fix cycle:** fix-planner → code-fixer → test-runner → architect-reviewer
- **Quick check:** Just bug-auditor
- **Browser QA:** browser-qa-agent → fix-planner → code-fixer → verify

## Outputs

All go to `.claude/audits/`:

| File | Source |
|------|--------|
| `AUDIT_SECURITY.md` | bug-auditor |
| `AUDIT_CODE.md` | code-auditor |
| `AUDIT_SECURITY_DEEP.md` | security-auditor |
| `AUDIT_DOCS.md` | doc-auditor |
| `AUDIT_INFRA.md` | infra-auditor |
| `AUDIT_UI_UX.md` | ui-auditor |
| `AUDIT_DB.md` | db-auditor |
| `AUDIT_PERF.md` | perf-auditor |
| `AUDIT_DEPS.md` | dep-auditor |
| `AUDIT_SEO.md` | seo-auditor |
| `API_TEST_REPORT.md` | api-tester |
| `DEPLOY_CHECK.md` | deploy-checker |
| `ENV_REPORT.md` | env-validator |
| `FIXES.md` | fix-planner |
| `TEST_REPORT.md` | test-runner |
| `AUDIT_BROWSER_QA.md` | browser-qa-agent |
| `QA_SESSION_LOG.md` | fullstack-qa-orchestrator |
| `QA_COMPLETE.md` | fullstack-qa-orchestrator |

---

## Project

<!-- Edit this -->

**Stack:**
**Critical paths:**
**Don't touch:** `.env`
