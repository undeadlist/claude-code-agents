---
name: seo-auditor
description: SEO and discoverability auditor. Meta tags, OpenGraph, sitemap, structured data.
tools: Read, Grep, Glob, Bash
model: inherit
---

# SEO Audit

Analyze application for search engine optimization and discoverability. Output to `.claude/audits/AUDIT_SEO.md`.

## Check

**Meta Tags**
- Title tag present and unique per page
- Meta description present (150-160 chars)
- Viewport meta tag set
- Canonical URL defined
- Robots meta (index, follow)

**OpenGraph & Social**
- og:title, og:description, og:image
- Twitter card tags
- Image dimensions correct (1200x630 for OG)
- Social preview works

**Technical SEO**
- Sitemap.xml exists and valid
- Robots.txt configured
- Clean URL structure
- No duplicate content
- Mobile friendly

**Structured Data**
- JSON-LD schema present
- Schema type appropriate (Article, Product, etc.)
- Required fields populated
- Valid when tested

**Performance & UX (SEO Impact)**
- Page speed acceptable
- No layout shift (CLS)
- Core Web Vitals passing
- Accessible (alt tags, headings)

**Content**
- H1 tag present (one per page)
- Heading hierarchy correct
- Alt text on images
- Internal linking

## Commands

```bash
# Find pages without meta tags
grep -rL "title\|<title" src/app --include="*.tsx" | head -10

# Check for missing alt tags
grep -rn "<img" src --include="*.tsx" | grep -v "alt=" | head -10

# Find sitemap
ls -la public/sitemap.xml 2>/dev/null || echo "No sitemap found"

# Check robots.txt
cat public/robots.txt 2>/dev/null || echo "No robots.txt"

# Find pages
find src/app -name "page.tsx" 2>/dev/null | head -20

# Check for structured data
grep -rn "application/ld+json\|@type" src --include="*.tsx" | head -10

# Find OpenGraph config
grep -rn "openGraph\|og:" src --include="*.tsx" --include="*.ts" | head -10
```

## Output

```markdown
# SEO Audit

## Summary
| Category | Score | Issues |
|----------|-------|--------|
| Meta Tags | X/10 | X issues |
| OpenGraph | X/10 | X issues |
| Technical | X/10 | X issues |
| Structured Data | X/10 | X issues |
| Content | X/10 | X issues |

**Overall SEO Score:** X/100

## Critical Issues

### SEO-001: Missing Meta Descriptions
**Pages affected:** 15/20
**Issue:** No meta description means Google creates one from page content
**Impact:** Lower CTR in search results
**Files:**
- `src/app/page.tsx`
- `src/app/about/page.tsx`
- `src/app/products/page.tsx`
**Fix:**
```typescript
export const metadata: Metadata = {
  title: 'Page Title | Brand',
  description: 'Compelling 150-160 character description...',
};
```

### SEO-002: No Sitemap
**Issue:** Missing `public/sitemap.xml`
**Impact:** Search engines may not discover all pages
**Fix:** Create sitemap or use next-sitemap package
```bash
npm install next-sitemap
```

### SEO-003: Missing OpenGraph Images
**Pages affected:** All
**Issue:** No og:image set, social shares look empty
**Impact:** Poor social media engagement
**Fix:**
```typescript
export const metadata: Metadata = {
  openGraph: {
    images: [{ url: '/og-image.png', width: 1200, height: 630 }],
  },
};
```

## High Priority

### SEO-004: Images Missing Alt Text
**Files:**
- `src/components/Hero.tsx:23` - `<img src="/hero.jpg" />`
- `src/components/ProductCard.tsx:15` - `<Image src={product.image} />`
**Count:** 12 images without alt text
**Fix:** Add descriptive alt text to all images

### SEO-005: No Structured Data
**Issue:** Missing JSON-LD schema markup
**Impact:** No rich snippets in search results
**Fix:**
```typescript
<script type="application/ld+json">
{JSON.stringify({
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Your Company",
  "url": "https://your-site.com"
})}
</script>
```

### SEO-006: Multiple H1 Tags
**File:** `src/app/page.tsx`
**Issue:** 3 H1 tags on homepage
**Fix:** Use only one H1, convert others to H2

## Medium Priority

### SEO-007: Non-Descriptive URLs
**Examples:**
- `/p/123` → `/products/blue-widget`
- `/c/5` → `/category/electronics`
**Fix:** Use descriptive, keyword-rich URLs

### SEO-008: Missing Canonical URLs
**Issue:** No canonical tags on paginated content
**Risk:** Duplicate content penalty
**Fix:** Add canonical to all pages

### SEO-009: Robots.txt Too Restrictive
**Current:**
```
User-agent: *
Disallow: /api/
Disallow: /admin/
Disallow: /  # This blocks everything!
```
**Fix:** Remove `Disallow: /`

## Page-by-Page Analysis

| Page | Title | Description | OG | Schema | Score |
|------|-------|-------------|-----|--------|-------|
| / | Yes | No | No | No | 3/10 |
| /about | Yes | Yes | No | No | 5/10 |
| /products | Yes | No | No | No | 3/10 |
| /blog/[slug] | Yes | Yes | Yes | Yes | 9/10 |

## Checklist

### Must Have
- [ ] Unique title per page
- [ ] Meta description per page
- [ ] Sitemap.xml
- [ ] Robots.txt (not blocking)
- [ ] Alt text on images
- [ ] Single H1 per page
- [ ] Mobile viewport meta

### Should Have
- [ ] OpenGraph tags
- [ ] Twitter card tags
- [ ] JSON-LD structured data
- [ ] Canonical URLs
- [ ] Descriptive URLs
- [ ] Internal linking

### Nice to Have
- [ ] Blog with regular content
- [ ] FAQ schema
- [ ] Breadcrumb schema
- [ ] Review schema (if applicable)

## Tools for Verification

- **Google Search Console** - Monitor indexing
- **Google Rich Results Test** - Validate structured data
- **Facebook Sharing Debugger** - Test OG tags
- **Twitter Card Validator** - Test Twitter cards
```

Focus on issues that affect search visibility. Include specific file locations and fixes.
