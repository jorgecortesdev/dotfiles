---
name: seo-audit
description: Audit a website for SEO issues. Use when the user mentions "SEO audit", "why am I not ranking", "SEO issues", "technical SEO", "on-page SEO", or "SEO health check".
---

# SEO Audit

Run a structured SEO audit. Infer site type and priorities from context. Don't ask unnecessary questions — start auditing.

## Audit Order

### 1. Crawlability & Indexation
- **Robots.txt** — unintentional blocks, sitemap reference
- **XML Sitemap** — exists, accessible, contains only canonical indexable URLs
- **Architecture** — important pages within 3 clicks, no orphan pages
- **Index status** — `site:domain.com` check, indexed vs expected count
- **Canonicalization** — self-referencing canonicals, HTTP/HTTPS, www/non-www, trailing slashes
- **Redirect chains/loops** — detect and flag

### 2. Technical Foundations
- **Core Web Vitals** — LCP < 2.5s, INP < 200ms, CLS < 0.1
- **Speed** — TTFB, image optimization, JS/CSS delivery, caching, CDN
- **Mobile** — responsive, tap targets, viewport, no horizontal scroll
- **HTTPS** — valid cert, no mixed content, HTTP redirects, HSTS
- **URL structure** — readable, lowercase, hyphenated, no unnecessary params

### 3. On-Page Optimization
- **Title tags** — unique, primary keyword near start, 50-60 chars, compelling
- **Meta descriptions** — unique, 150-160 chars, includes keyword, has CTA
- **Headings** — one H1 per page with keyword, logical hierarchy, no skipped levels
- **Content** — keyword in first 100 words, sufficient depth, answers search intent
- **Images** — descriptive filenames, alt text, compressed, WebP, lazy loading
- **Internal linking** — important pages well-linked, descriptive anchors, no broken links

### 4. Content Quality (E-E-A-T)
- **Experience** — first-hand experience, original insights, real examples
- **Expertise** — author credentials visible, accurate detailed info
- **Authoritativeness** — recognized in space, cited by others
- **Trustworthiness** — accurate info, contact details, privacy policy, HTTPS

### 5. Keyword Targeting
- Each page has clear primary keyword
- Title, H1, URL aligned
- No keyword cannibalization between pages
- Logical topical clusters

## Output Format

**Executive Summary** — overall health, top 3-5 priority issues, quick wins

**Findings** (per issue):
- **Issue**: what's wrong
- **Impact**: High / Medium / Low
- **Evidence**: how you found it
- **Fix**: specific recommendation

**Action Plan**:
1. Critical fixes (blocking indexation/ranking)
2. High-impact improvements
3. Quick wins (easy, immediate benefit)
4. Long-term recommendations

## Site Type Specifics

**SaaS** — product pages lack depth, blog not linked to product, missing comparison/alternative pages, feature pages thin

**Blog/Content** — outdated content, keyword cannibalization, no topical clustering, poor internal linking, missing author pages

**E-commerce** — thin category pages, duplicate product descriptions, missing product schema, faceted navigation duplicates

**Local business** — inconsistent NAP, missing local schema, no Google Business Profile optimization

## References

- [AI Writing Detection](references/ai-writing-detection.md): Common AI writing patterns to avoid (em dashes, overused phrases, filler words)
- [AEO & GEO Patterns](references/aeo-geo-patterns.md): Content patterns optimized for answer engines and AI citation
