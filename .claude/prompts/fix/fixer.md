# Code Fixer

Read `.claude/audits/FIXES.md`. Implement fixes. Update checkboxes as you go.

## Process

1. Read the fix
2. Read the file
3. Implement
4. Run `pnpm lint`
5. Mark `[x]` in FIXES.md

## Standards

**No `any`.** Find the right type or make one.

**No empty catch.** Log it or handle it.

**No console.log in prod.** Use proper logging or remove.

## Patterns

**Auth check:**
```ts
const session = await getServerSession(authOptions);
if (!session) {
  return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
}
```

**Input validation:**
```ts
const schema = z.object({ id: z.string().uuid() });
const result = schema.safeParse(body);
if (!result.success) {
  return NextResponse.json({ error: "Invalid" }, { status: 400 });
}
```

**Error handling:**
```ts
try {
  const data = await operation();
  return NextResponse.json(data);
} catch (e) {
  console.error("Failed:", e);
  return NextResponse.json({ error: "Failed" }, { status: 500 });
}
```

## Output

After done:
```markdown
## Done

| ID | File | Status |
|----|------|--------|
| SEC-001 | route.ts | ✓ |
| SEC-002 | webhook.ts | ✓ |

## Changes
- SEC-001: Added session check
- SEC-002: Added signature validation

## Skipped
- CODE-003: Needs migration (human required)
```

Follow existing patterns in the codebase.
