#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const AGENTS = [
    'code-auditor.md',
    'bug-auditor.md',
    'security-auditor.md',
    'doc-auditor.md',
    'infra-auditor.md',
    'ui-auditor.md',
    'fix-planner.md',
    'code-fixer.md',
    'test-runner.md',
    'architect-reviewer.md',
    'browser-qa-agent.md',
    'fullstack-qa-orchestrator.md',
    'console-monitor.md',
    'visual-diff.md'
];

function install() {
    const cwd = process.cwd();
    const targetDir = path.join(cwd, '.claude', 'agents');

    // Find package agents directory
    const packageDir = path.join(__dirname, '..', '.claude', 'agents');

    if (!fs.existsSync(packageDir)) {
        console.error('Error: Could not find agent files in package');
        process.exit(1);
    }

    // Create target directory
    fs.mkdirSync(targetDir, { recursive: true });

    console.log('\n  Claude Code Agents\n');
    console.log('  Installing 14 agents to .claude/agents/\n');

    let installed = 0;
    let skipped = 0;

    for (const agent of AGENTS) {
        const src = path.join(packageDir, agent);
        const dest = path.join(targetDir, agent);

        if (!fs.existsSync(src)) {
            console.log(`  [skip] ${agent} (not found in package)`);
            skipped++;
            continue;
        }

        if (fs.existsSync(dest)) {
            console.log(`  [skip] ${agent} (already exists)`);
            skipped++;
            continue;
        }

        fs.copyFileSync(src, dest);
        console.log(`  [done] ${agent}`);
        installed++;
    }

    console.log('\n  ----------------------------------------');
    console.log(`  Installed: ${installed}  Skipped: ${skipped}`);
    console.log('  ----------------------------------------\n');

    if (installed > 0) {
        console.log('  Usage:');
        console.log('    claude "Run parallel audit on src/"');
        console.log('    claude "Use architect-reviewer to coordinate full QA"');
        console.log('');
        console.log('  Docs: https://github.com/undeadlist/claude-code-agents');
        console.log('');
    }
}

install();
