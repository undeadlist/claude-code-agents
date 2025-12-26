#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const AGENTS = [
    // Audit agents (11)
    'code-auditor.md',
    'bug-auditor.md',
    'security-auditor.md',
    'doc-auditor.md',
    'infra-auditor.md',
    'ui-auditor.md',
    'db-auditor.md',
    'perf-auditor.md',
    'dep-auditor.md',
    'seo-auditor.md',
    'api-tester.md',
    // Fix/Implement agents (4)
    'fix-planner.md',
    'code-fixer.md',
    'test-runner.md',
    'test-writer.md',
    // Browser QA agents (4)
    'browser-qa-agent.md',
    'fullstack-qa-orchestrator.md',
    'console-monitor.md',
    'visual-diff.md',
    // Deploy agents (2)
    'deploy-checker.md',
    'env-validator.md',
    // Utility agents (2)
    'pr-writer.md',
    'seed-generator.md',
    // Supervisors (1)
    'architect-reviewer.md'
];

const WORKFLOWS = [
    'pre-commit.md',
    'pre-deploy.md',
    'full-audit.md',
    'new-feature.md',
    'bug-fix.md',
    'release-prep.md'
];

function install() {
    const cwd = process.cwd();
    const agentTargetDir = path.join(cwd, '.claude', 'agents');
    const workflowTargetDir = path.join(cwd, 'workflows');
    const auditsDir = path.join(cwd, '.claude', 'audits');

    // Find package directories
    const packageAgentDir = path.join(__dirname, '..', '.claude', 'agents');
    const packageWorkflowDir = path.join(__dirname, '..', 'workflows');

    if (!fs.existsSync(packageAgentDir)) {
        console.error('Error: Could not find agent files in package');
        process.exit(1);
    }

    // Create target directories
    fs.mkdirSync(agentTargetDir, { recursive: true });
    fs.mkdirSync(workflowTargetDir, { recursive: true });
    fs.mkdirSync(auditsDir, { recursive: true });

    console.log('\n  Claude Code Agents v2.0\n');
    console.log('  Installing 24 agents + 6 workflows\n');

    let agentsInstalled = 0;
    let agentsSkipped = 0;

    console.log('  Agents:');
    for (const agent of AGENTS) {
        const src = path.join(packageAgentDir, agent);
        const dest = path.join(agentTargetDir, agent);

        if (!fs.existsSync(src)) {
            console.log(`    [skip] ${agent} (not found in package)`);
            agentsSkipped++;
            continue;
        }

        if (fs.existsSync(dest)) {
            console.log(`    [skip] ${agent} (already exists)`);
            agentsSkipped++;
            continue;
        }

        fs.copyFileSync(src, dest);
        console.log(`    [done] ${agent}`);
        agentsInstalled++;
    }

    let workflowsInstalled = 0;
    let workflowsSkipped = 0;

    console.log('\n  Workflows:');
    for (const workflow of WORKFLOWS) {
        const src = path.join(packageWorkflowDir, workflow);
        const dest = path.join(workflowTargetDir, workflow);

        if (!fs.existsSync(src)) {
            console.log(`    [skip] ${workflow} (not found in package)`);
            workflowsSkipped++;
            continue;
        }

        if (fs.existsSync(dest)) {
            console.log(`    [skip] ${workflow} (already exists)`);
            workflowsSkipped++;
            continue;
        }

        fs.copyFileSync(src, dest);
        console.log(`    [done] ${workflow}`);
        workflowsInstalled++;
    }

    // Create .gitignore for audits
    const gitignorePath = path.join(cwd, '.claude', '.gitignore');
    if (!fs.existsSync(gitignorePath)) {
        fs.writeFileSync(gitignorePath, 'audits/\n');
    }

    console.log('\n  ----------------------------------------');
    console.log(`  Agents:    ${agentsInstalled} installed, ${agentsSkipped} skipped`);
    console.log(`  Workflows: ${workflowsInstalled} installed, ${workflowsSkipped} skipped`);
    console.log('  ----------------------------------------\n');

    if (agentsInstalled > 0 || workflowsInstalled > 0) {
        console.log('  Quick Start:');
        console.log('    claude "Run full-audit workflow on src/"');
        console.log('    claude "Run pre-commit workflow"');
        console.log('    claude "Run pre-deploy workflow"');
        console.log('');
        console.log('  Docs: https://github.com/undeadlist/claude-code-agents');
        console.log('');
    }
}

install();
