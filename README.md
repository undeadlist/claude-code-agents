# Claude Code Agents

![Claude Code Ready](./badges/claude-code-ready.svg)

**Not a framework. Just prompts that work.**

Drop-in subagent definitions for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that turn your CLI into a parallel code audit powerhouse.

![Parallel Audit Demo](./assets/terminal-demo.svg)

---

## Quick Start (30 seconds)

```bash
# Clone the agents
git clone https://github.com/undeadlist/claude-code-agents.git

# Copy to your project
cp -r claude-code-agents/.claude/agents/ your-project/.claude/agents/

# Run Claude Code
cd your-project
claude "Run full parallel audit on src/"
```

That's it. No config. No framework. No dependencies.

---

## What This Is

**11 specialized subagents** that Claude Code spawns via `Task()` to audit your codebase in parallel:

| Agent | What It Does |
|-------|-------------|
| `code-auditor` | Code quality, DRY violations, complexity |
| `bug-auditor` | Security vulns, auth gaps, runtime risks |
| `security-auditor` | Deep OWASP analysis, injection, secrets |
| `doc-auditor` | Missing docs, outdated comments, API coverage |
| `infra-auditor` | Env vars, headers, deployment config |
| `ui-auditor` | Accessibility, consistency, UX patterns |
| `fix-planner` | Prioritized remediation plan from findings |
| `code-fixer` | Implements fixes following project patterns |
| `test-runner` | Runs tests, validates fixes worked |
| `architect-reviewer` | Supervises and iterates until production-ready |

---

## Why Parallel?

Most people use Claude Code linearly. One request, one response, repeat.

These agents spawn **5+ Task() calls simultaneously**:

```
Sequential: 45+ seconds
Parallel:   ~12 seconds (3.5x faster)
```

Each agent hits a different part of your codebase at the same time. The fix-planner then synthesizes everything into `FIXES.md`.

---

## Agent Definitions

```
.claude/agents/
├── code-auditor.md       # Code quality specialist
├── bug-auditor.md        # Bug & vulnerability scanner
├── security-auditor.md   # OWASP-focused deep scan
├── doc-auditor.md        # Documentation checker
├── infra-auditor.md      # Infrastructure & config
├── ui-auditor.md         # UI/UX & accessibility
├── fix-planner.md        # Remediation architect
├── code-fixer.md         # Implements the fixes
├── test-runner.md        # Test validation
└── architect-reviewer.md # Supervisor that validates work
```

---

## Usage Examples

**Full Codebase Audit:**
```
claude "Run parallel audit: code-auditor on src/components/,
        bug-auditor on src/lib/, security-auditor on src/api/,
        doc-auditor on src/pages/. Then fix-planner to create FIXES.md"
```

**Security-Focused Scan:**
```
claude "Use security-auditor and bug-auditor to scan for auth vulnerabilities in src/"
```

**Pre-PR Review:**
```
claude "Use code-auditor on the files in my last 3 commits"
```

**Supervised Fix Cycle:**
```
claude "Use architect-reviewer to coordinate: audit src/, create fixes,
        implement them, then review until production-ready"
```

---

## Customization

### Add MCP Servers

Pair agents with MCP servers for enhanced capabilities:

```bash
# In your Claude Code settings
mcp add github     # For PR reviews
mcp add filesystem # For deep file access
mcp add postgres   # For database schema analysis
```

### Project-Specific Agents

Create agents tailored to your stack:

```markdown
---
name: nextjs-auditor
description: Next.js specific patterns and App Router best practices
---

Check for:
- Client/Server component boundaries
- use client misuse
- Metadata export patterns
- Route handler security
```

---

## Outputs

Everything goes to `.claude/audits/`:

- `AUDIT_CODE.md` - code quality issues
- `AUDIT_SECURITY.md` - vulnerabilities found
- `AUDIT_SECURITY_DEEP.md` - OWASP analysis
- `AUDIT_DOCS.md` - documentation gaps
- `AUDIT_INFRA.md` - config problems
- `AUDIT_UI_UX.md` - accessibility/UX issues
- `FIXES.md` - prioritized fix plan
- `TEST_REPORT.md` - test results

Gitignored by default. These are working files, not artifacts.

---

## One-Liner Install

```bash
curl -s https://undeadlist.com/agents/install.sh | bash
```

Drops agents into your current project's `.claude/agents/` directory.

---

## When to Use This vs Just Chatting

**Use agents for:**
- Pre-launch audits (parallel = fast)
- Structured fix cycles
- Large codebases (fresh context per agent)

**Just chat for:**
- Quick fixes
- Active development
- Anything exploratory

Agents lose conversation context. That's the tradeoff for parallelism and structure.

---

## How It Actually Works

Claude Code has a `Task()` tool that spawns subprocess agents:

```
Task(
  subagent_type="bug-auditor",
  prompt="...",           // your instructions
  description="Security"  // label
)
```

Multiple `Task()` calls in one response = parallel execution.
Sequential = wait for result, then next `Task()`.

Agents can't talk to each other. They communicate via files in `.claude/audits/`.

---

## License

MIT. Use it, fork it, sell it, whatever.

---

Made by [UndeadList](https://undeadlist.com) — the marketplace for indie software.

<p align="center">
  <a href="https://undeadlist.com">
    <img src="./badges/claude-code-ready.svg" alt="Claude Code Ready">
  </a>
</p>
