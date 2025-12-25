# Awesome Claude Code Submission

## Pull Request Title
Add claude-code-agents - 12 parallel audit agents

## Entry to Add

Under **Prompts** section (or create "Agent Collections" if it doesn't exist):

```markdown
- [Claude Code Agents](https://github.com/undeadlist/claude-code-agents) - 12 parallel audit agents for Claude Code. Run code, security, UI, and infrastructure audits simultaneously with browser QA integration.
```

## Description for PR

This collection includes:
- **6 Audit Agents**: code-auditor, bug-auditor, security-auditor, doc-auditor, infra-auditor, ui-auditor
- **3 Fix Agents**: fix-planner, code-fixer, test-runner
- **1 Supervisor**: architect-reviewer
- **2 Browser QA**: browser-qa-agent, fullstack-qa-orchestrator

Key features:
- Parallel execution for faster audits
- YAML frontmatter for Claude Code subagent integration
- Chrome browser integration for UI testing
- Complete find-fix-verify workflow

Install via: `npx claude-code-agents`

---

## Target Repos

1. **awesome-claude-code** (by anthropics)
   - URL: https://github.com/anthropics/awesome-claude-code
   - Submit PR adding entry to appropriate section

2. **awesome-claude** (by sjinzh)
   - URL: https://github.com/sjinzh/awesome-claude
   - May have a Claude Code or tools section

---

## How to Submit

1. Fork the awesome-claude-code repo
2. Edit README.md to add the entry (alphabetically)
3. Create PR with title: "Add claude-code-agents - parallel audit agents"
4. Reference this package: https://github.com/undeadlist/claude-code-agents
