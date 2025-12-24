# CLAUDE.md

You're the orchestrator. Spawn subagents via `Task()` for focused work.

## Agents

| Type | Prompt | Does |
|------|--------|------|
| `bug-auditor` | `.claude/prompts/audit/security.md` | Security scan |
| `code-auditor` | `.claude/prompts/audit/code.md` | Code quality |
| `migration-auditor` | `.claude/prompts/audit/infra.md` | Config/infra |
| `general-purpose` | `.claude/prompts/audit/ui-ux.md` | UI/UX |
| `fix-planner` | `.claude/prompts/fix/planner.md` | Prioritize fixes |
| `code-fixer` | `.claude/prompts/fix/fixer.md` | Implement fixes |
| `test-runner` | `.claude/prompts/test/runner.md` | Run tests |
| `architect-reviewer` | `.claude/prompts/review/architect.md` | Final approval |

## Spawning

**Single:**
```
Task(subagent_type="bug-auditor", prompt="...", description="Security")
```

**Parallel (same response):**
```
Task(subagent_type="bug-auditor", prompt="...", description="Security")
Task(subagent_type="code-auditor", prompt="...", description="Code")
Task(subagent_type="migration-auditor", prompt="...", description="Infra")
```

**Sequential:** Wait for result, then next Task.

## Workflows

**Full audit:** Spawn all 3 auditors parallel → fix-planner

**Fix cycle:** fix-planner → code-fixer → test-runner → architect-reviewer

**Quick check:** Just bug-auditor

## Outputs

All go to `.claude/audits/`:
- `AUDIT_SECURITY.md`
- `AUDIT_CODE.md`
- `AUDIT_INFRA.md`
- `FIXES.md`
- `TEST_REPORT.md`

---

## Project

<!-- Edit this -->

**Stack:** 
**Critical paths:** 
**Don't touch:** `.env`
