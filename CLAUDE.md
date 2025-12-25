# CLAUDE.md

You're the orchestrator. Spawn subagents via `Task()` for focused work.

## Agents

| Type | Prompt | Does |
|------|--------|------|
| `bug-auditor` | `.claude/agents/bug-auditor.md` | Security & bugs |
| `code-auditor` | `.claude/agents/code-auditor.md` | Code quality |
| `security-auditor` | `.claude/agents/security-auditor.md` | OWASP deep scan |
| `doc-auditor` | `.claude/agents/doc-auditor.md` | Documentation |
| `infra-auditor` | `.claude/agents/infra-auditor.md` | Config/infra |
| `ui-auditor` | `.claude/agents/ui-auditor.md` | UI/UX & a11y |
| `fix-planner` | `.claude/agents/fix-planner.md` | Prioritize fixes |
| `code-fixer` | `.claude/agents/code-fixer.md` | Implement fixes |
| `test-runner` | `.claude/agents/test-runner.md` | Run tests |
| `architect-reviewer` | `.claude/agents/architect-reviewer.md` | Final approval |
| `browser-qa-agent` | `.claude/agents/browser-qa-agent.md` | Chrome UI testing |
| `fullstack-qa-orchestrator` | `.claude/agents/fullstack-qa-orchestrator.md` | Find-fix-verify loop |
| `console-monitor` | `.claude/agents/console-monitor.md` | Real-time console watching |
| `visual-diff` | `.claude/agents/visual-diff.md` | Screenshot comparison |

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
Task(subagent_type="doc-auditor", prompt="...", description="Docs")
```

**Sequential:** Wait for result, then next Task.

## Workflows

**Full audit:** Spawn all auditors parallel → fix-planner

**Fix cycle:** fix-planner → code-fixer → test-runner → architect-reviewer

**Quick check:** Just bug-auditor

**Supervised:** architect-reviewer coordinates everything

**Browser QA:** browser-qa-agent → fix-planner → code-fixer → browser-qa-agent (verify)

## Outputs

All go to `.claude/audits/`:
- `AUDIT_SECURITY.md`
- `AUDIT_CODE.md`
- `AUDIT_SECURITY_DEEP.md`
- `AUDIT_DOCS.md`
- `AUDIT_INFRA.md`
- `AUDIT_UI_UX.md`
- `FIXES.md`
- `TEST_REPORT.md`
- `AUDIT_BROWSER_QA.md`
- `QA_SESSION_LOG.md`
- `QA_COMPLETE.md`

---

## Project

<!-- Edit this -->

**Stack:**
**Critical paths:**
**Don't touch:** `.env`
