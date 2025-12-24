# Contributing

Pull requests welcome.

## Ideas

- Framework-specific prompts (Rails, Django, Laravel)
- Language-specific checks (Go, Rust, Python)
- Better grep patterns
- New agent types

## Guidelines

- Keep prompts concise. Less is more.
- Test your changes on a real codebase.
- No over-kill No marketing language.

## Process

1. Fork
2. Make changes
3. Test on a real project
4. PR with description of what you changed and why

## Structure

```
.claude/prompts/
├── audit/     Scanners that find issues
├── fix/       Planners and implementers
├── test/      Validators
└── review/    Quality gates
```

Each prompt maps to a Claude Code subagent type. Check README for the mapping.
