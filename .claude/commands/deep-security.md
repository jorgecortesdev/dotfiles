---
description: Full OWASP top 10 security audit with code-level analysis and remediation roadmap
model: opus
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(npm audit:*)
  - Bash(composer audit:*)
  - Bash(pip audit:*)
  - Bash(cargo audit:*)
  - Bash(bundle audit:*)
  - Bash(ls:*)
  - Bash(cat:*)
  - Bash(git log:*)
  - Bash(git ls-files:*)
  - Bash(wc:*)
  - Bash(git diff:*)
  - Write
  - Task
  - WebSearch
disable-model-invocation: true
---

<role>
You are a senior application security engineer conducting a thorough security audit of this codebase. Your goal is to systematically check for OWASP Top 10 vulnerabilities at the code level, identify security anti-patterns, and produce a prioritized remediation roadmap. This is the deep audit — be thorough, examine actual code, and provide specific file:line references.
</role>

<context>
Working directory: !`pwd`
Top-level files: !`ls -la`
</context>

<data_gathering>
Before analysis, gather security-relevant data using your tools:
1. Use Bash: `git ls-files` to get all tracked files
2. Read the main manifest file (`package.json`, `composer.json`, etc.) to detect the framework
3. Use Grep to find auth-related files: patterns like `auth`, `login`, `session`, `token`, `jwt`, `oauth`, `middleware`
4. Use Grep to find API-related files: patterns like `route`, `controller`, `endpoint`, `handler`, `resolver`
5. Use Glob to find config files: `*.config.*`, `.env*`, `**/config/**`
</data_gathering>

<previous_report>
Before beginning analysis, check for a previous run of this command:
1. Use Glob to find: `.claude/reports/*-deep-security.md`
2. If found, read the most recent one (last alphabetically = most recent).
3. Extract the timestamp from the filename (format: YYYY-MM-DD-HHmmss).
4. Identify what source files changed since then:
   - Run: `git log --after="YYYY-MM-DDTHH:MM:SS" --name-only --pretty=format:`
   - Run: `git diff --name-only`
   These two together catch both committed and uncommitted changes.
5. For sections where NO relevant files changed: carry forward findings from the previous report verbatim, with annotation: "*Carried forward from [previous timestamp] — no relevant source changes detected.*"
6. For sections where relevant files DID change: perform full re-analysis.
7. Always re-run dependency audit commands regardless of source changes (new CVEs can appear at any time).
8. If no previous report is found, proceed with full analysis as a fresh run.
</previous_report>

<instructions>
Systematically audit the codebase against each OWASP Top 10 (2021) category. For each category, search for and read relevant code, then report findings.

1. **A01: Broken Access Control**
   - Search for authorization checks in route handlers/controllers
   - Look for direct object reference patterns (user ID in URLs/params without ownership check)
   - Check for missing function-level access control
   - Verify CORS configuration
   - Check for path traversal vulnerabilities in file operations

2. **A02: Cryptographic Failures**
   - Search for hardcoded secrets, keys, passwords
   - Check encryption usage (are weak algorithms used? MD5, SHA1 for passwords?)
   - Verify TLS/HTTPS enforcement
   - Check for sensitive data in logs
   - Look for sensitive data in URL parameters

3. **A03: Injection**
   - Search for SQL queries — are they parameterized?
   - Check for NoSQL injection patterns
   - Look for command injection (`exec`, `spawn`, `system`, `eval`, `os.system`)
   - Check for template injection (server-side template engines)
   - Verify XSS protection in output rendering

4. **A04: Insecure Design**
   - Check for rate limiting on auth endpoints
   - Look for business logic flaws (e.g., price manipulation, race conditions)
   - Check for proper input validation at system boundaries
   - Verify error handling doesn't leak internal details

5. **A05: Security Misconfiguration**
   - Check security headers (CSP, HSTS, X-Frame-Options, etc.)
   - Look for debug mode enabled in production configs
   - Check default credentials or configurations
   - Verify error pages don't leak stack traces
   - Check for unnecessary features/endpoints exposed

6. **A06: Vulnerable and Outdated Components**
   - Run dependency audit commands
   - Check for known-vulnerable package versions
   - Look for unmaintained dependencies

7. **A07: Identification and Authentication Failures**
   - Check password policy enforcement
   - Look for session management issues
   - Check for credential stuffing protection (rate limiting, captcha)
   - Verify JWT implementation (algorithm, expiry, secret strength)
   - Check for insecure "remember me" or password reset flows

8. **A08: Software and Data Integrity Failures**
   - Check for unsafe deserialization
   - Look for missing integrity checks on CI/CD pipelines
   - Check for auto-update mechanisms without verification
   - Verify lockfile integrity

9. **A09: Security Logging and Monitoring Failures**
   - Check what events are logged (login, failed login, access denied, etc.)
   - Look for sensitive data in logs
   - Verify log injection prevention
   - Check for monitoring/alerting setup

10. **A10: Server-Side Request Forgery (SSRF)**
    - Search for outbound HTTP requests using user-supplied URLs
    - Check for URL validation/allowlisting
    - Look for internal service URLs exposed to user input

After the OWASP analysis, also check:
11. **Secrets in git history**: `git log --all -p -S 'password' --diff-filter=A -- '*.ts' '*.js' '*.py' '*.php' '*.rb' '*.java' '*.go' | head -50`
12. **File upload security**: If file uploads exist, check for type validation, size limits, storage location.
13. **API security**: Check for rate limiting, authentication on all endpoints, input validation.

Generate the report and save to `.claude/reports/YYYY-MM-DD-HHmmss-deep-security.md`.
</instructions>

<output_format>
```markdown
# Deep Security Audit — [Project Name]
Generated: [timestamp]

## Previous Report
- **Last run**: [timestamp of previous report, or "None — first run"]
- **Source changes since last run**: [count of changed files, or "N/A — first run"]

## Executive Summary
[2-3 sentences: overall security posture, most critical findings, recommended priority]

## Risk Score
| Category | Risk Level | Findings |
|----------|-----------|----------|
| Overall | 🔴/🟠/🟡/🟢 | X critical, Y high, Z medium |

## OWASP Top 10 Analysis

### A01: Broken Access Control — [🔴/🟠/🟡/🟢]
**Status**: [Vulnerable / Partially Protected / Well Protected / N/A]

**Findings**:
1. [Finding with file:line reference]
2. ...

**Evidence**:
```[language]
// file.ts:42
[relevant code snippet]
```

**Remediation**: [Specific fix]

[Repeat for each OWASP category]

## Additional Findings

### Secrets in Git History
[Findings or "Clean"]

### File Upload Security
[Findings or "N/A"]

### API Security
[Findings]

## Remediation Roadmap

### Phase 1: Immediate (This Week)
[Critical items that need fixing now]

### Phase 2: Short-term (This Sprint)
[High items to address soon]

### Phase 3: Medium-term (This Quarter)
[Medium items for planned improvement]

## Changes Since Last Run
- **Changed source files analyzed**: [list]
- **Sections carried forward**: [list of section names]
- **New findings**: [list]
- **Resolved findings**: [list]
- **Changed findings**: [list]
[If first run: "First run — full analysis performed."]

## Action Items

| # | Severity | Title | Description | Effort |
|---|----------|-------|-------------|--------|
| ... | ... | ... | ... | ... |

### Action Item Details
[Detailed breakdown of each item with file references and fix instructions]
```
</output_format>

<rules>
- Do NOT modify any code or configuration files.
- Do NOT attempt to exploit vulnerabilities — identify and report only.
- ALWAYS provide file:line references for findings — vague findings are useless.
- REDACT actual secret values — show pattern and location only.
- Do NOT report theoretical issues without evidence in the code.
- For each finding, provide a concrete remediation with code example where applicable.
- Use Task tool to parallelize analysis across OWASP categories if the codebase is large.
- If a category is not applicable (e.g., no database = no SQL injection), mark as N/A with brief explanation.
- When carrying forward sections, copy content verbatim and add the "carried forward" annotation. Do NOT paraphrase carried-forward content.
- Always re-run dependency audit commands regardless of source file changes.
- If git history commands fail (shallow clone), fall back to full analysis and note the limitation.
- When in doubt about whether a change affects a section, re-analyze rather than carry forward stale data.
</rules>
