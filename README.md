# Claude Code Agents

Prompt templates for Claude Code's subagent system. Run parallel code audits, automate fix cycles, get stuff reviewed.

Built for the [Claude Code](https://claude.ai) Task tool. Not a framework. Just prompts that work.

## What This Does

Claude Code can spawn subagents via `Task()`. These are the prompts those agents receive.

```
You: "Audit this codebase for security issues"

Claude Code spawns:
Task(subagent_type="bug-auditor", prompt="[security.md]")

Agent runs in parallel, outputs to .claude/audits/AUDIT_SECURITY.md
```

Three auditors at once? They run in parallel. Fix cycle? Sequential with handoffs via files.

## Setup

```bash
# Copy to your project
cp -r claude-code-agents/.claude .
cp claude-code-agents/CLAUDE.md .

# Or clone
git clone https://github.com/undeadlist/claude-code-agents.git
cp -r claude-code-agents/.claude .
cp claude-code-agents/CLAUDE.md .
```

That's it. No dependencies. No config. Just markdown files.

## Usage

Tell Claude what you want. It reads `CLAUDE.md`, spawns the right agents.

**Full audit:**
```
"Run security, code quality, and infra audits"
```

**Fix what's broken:**
```
"Create a fix plan from the audits and implement P1 blockers"
```

**Validate:**
```
"Run tests and do an architect review"
```

## What's Inside

```
.claude/
├── prompts/
│   ├── audit/
│   │   ├── security.md      bug-auditor
│   │   ├── code.md          code-auditor
│   │   ├── infra.md         migration-auditor
│   │   └── ui-ux.md         general-purpose
│   ├── fix/
│   │   ├── planner.md       fix-planner
│   │   └── fixer.md         code-fixer
│   ├── test/
│   │   └── runner.md        test-runner
│   └── review/
│       └── architect.md     architect-reviewer
└── audits/                  outputs land here
```

## Agents

| Agent | What it does |
|-------|--------------|
| `bug-auditor` | Security vulns, auth gaps, injection risks |
| `code-auditor` | Type issues, error handling, code smells |
| `migration-auditor` | Env vars, headers, deployment config |
| `fix-planner` | Reads audits, prioritizes fixes |
| `code-fixer` | Implements fixes, runs lint |
| `test-runner` | Runs tests, validates fixes worked |
| `architect-reviewer` | Final gate. APPROVED / REVISE / BLOCKED |

## Outputs

Everything goes to `.claude/audits/`:

- `AUDIT_SECURITY.md` - vulnerabilities found
- `AUDIT_CODE.md` - code quality issues
- `AUDIT_INFRA.md` - config problems
- `FIXES.md` - prioritized fix plan
- `TEST_REPORT.md` - test results

Gitignored by default. These are working files, not artifacts.

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

## Customizing

Edit the prompts. They're just markdown.

Add project-specific patterns:
```markdown
## Project-Specific

### Payment Security
- Check Stripe webhook validation in `src/api/stripe/`
- Verify escrow release auth
```

Change output formats. Add new agents. Whatever.

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

## License

MIT. Use it, fork it, sell it, whatever.

---

Made by [UndeadList](https://undeadlist.com) — the marketplace for indie software.
