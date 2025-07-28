# 🛡️ GitHub Actions Security Checklist

## Immediate Actions (Do This Today!)

### ✅ Audit Your Workflows
- [ ] Review all `.github/workflows/*.yml` files
- [ ] Check for `actions/checkout` usage
- [ ] Verify `persist-credentials: false` is set
- [ ] Ensure minimal workflow permissions are defined

### ✅ Secure Checkout Configuration
Replace this vulnerable pattern:
```yaml
❌ VULNERABLE:
- uses: actions/checkout@v4
  # persist-credentials defaults to true!
```

With this secure pattern:
```yaml
✅ SECURE:
- uses: actions/checkout@v4
  with:
    persist-credentials: false
```

### ✅ Implement Minimal Permissions
Add this to the top of your workflow files:
```yaml
permissions:
  contents: read
  # Only add other permissions if absolutely necessary:
  # packages: write    # For publishing packages
  # id-token: write    # For OIDC authentication
```

## 🔍 Security Scanning Setup

### ✅ Enable GitHub Features
- [ ] Enable secret scanning in repository settings
- [ ] Enable dependency vulnerability alerts
- [ ] Enable security updates (Dependabot)
- [ ] Set up code scanning with CodeQL

### ✅ Add Security Tools
```yaml
# Add to your workflows
- name: Run security scan
  uses: securecodewarrior/github-action-add-sarif@v1
  with:
    sarif-file: security-scan-results.sarif

- name: Scan for secrets
  uses: trufflesecurity/trufflehog@main
  with:
    path: ./
```

## 🔐 Secret Management

### ✅ Review Secret Hygiene
- [ ] Audit all repository secrets
- [ ] Remove unused or old secrets
- [ ] Implement secret rotation policy
- [ ] Use short-lived tokens when possible

### ✅ Secure Secret Usage
```yaml
# Use secrets sparingly and explicitly
env:
  SPECIFIC_TOKEN: ${{ secrets.SPECIFIC_TOKEN }}
  # Don't expose: ${{ secrets.GITHUB_TOKEN }}
```

## 📦 Package Security

### ✅ NPM Package Security
```yaml
# Secure NPM publishing
- name: Publish to NPM
  run: npm publish
  env:
    NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
  # Only run on main branch and specific conditions
  if: github.ref == 'refs/heads/main' && github.event_name == 'push'
```

### ✅ Docker Image Security
```yaml
# Secure Docker publishing
- name: Build and push Docker image
  uses: docker/build-push-action@v5
  with:
    push: true
    tags: user/app:latest
    # Add security scanning
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

## 🔬 Monitoring and Detection

### ✅ Set Up Monitoring
- [ ] Monitor package publications
- [ ] Set up alerts for unusual repository activity
- [ ] Implement audit logging
- [ ] Track credential usage patterns

### ✅ Incident Response Plan
- [ ] Document credential rotation procedures
- [ ] Prepare package/image recall process
- [ ] Establish communication channels
- [ ] Test response procedures regularly

## 🏗️ Advanced Security Measures

### ✅ Supply Chain Security
```yaml
# Add provenance generation
- name: Generate provenance
  uses: actions/attest-build-provenance@v1
  with:
    subject-path: 'dist/*'

# Add SBOM generation
- name: Generate SBOM
  uses: anchore/sbom-action@v0
  with:
    path: ./
```

### ✅ Branch Protection
- [ ] Require pull request reviews
- [ ] Require status checks to pass
- [ ] Require branches to be up to date
- [ ] Restrict pushes to main branch
- [ ] Require signed commits

### ✅ Third-Party Action Security
```yaml
# Pin actions to specific commits
- uses: actions/checkout@8ade135a41bc03ea155e62e844d188df1ea18608  # v4.1.0
  with:
    persist-credentials: false

# Instead of:
# - uses: actions/checkout@v4  # Could be hijacked
```

## 📋 Regular Maintenance

### ✅ Weekly Tasks
- [ ] Review new workflow changes
- [ ] Check for security alerts
- [ ] Update dependencies
- [ ] Rotate long-lived secrets

### ✅ Monthly Tasks
- [ ] Audit workflow permissions
- [ ] Review third-party actions
- [ ] Update security tools
- [ ] Test incident response procedures

### ✅ Quarterly Tasks
- [ ] Comprehensive security review
- [ ] Update security policies
- [ ] Security training for team
- [ ] Penetration testing

## 🚨 Red Flags to Watch For

### ❌ Dangerous Patterns
```yaml
# These patterns indicate security issues:
- uses: actions/checkout@v4
  # Missing: persist-credentials: false

permissions: write-all  # Too permissive

env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Unnecessary exposure

- run: |
    echo ${{ secrets.GITHUB_TOKEN }}  # Logging secrets
```

### ❌ Suspicious Activity
- Unexpected package publications
- Unusual repository access patterns
- Modified workflow files
- New secrets or environment variables
- Third-party actions from unknown sources

## 📞 Getting Help

### 🔗 Resources
- [GitHub Security Documentation](https://docs.github.com/en/code-security)
- [OpenSSF Best Practices](https://bestpractices.coreinfrastructure.org/)
- [SLSA Framework](https://slsa.dev/)
- [Supply Chain Security Guide](https://github.com/ossf/oss-vulnerability-guide)

### 🆘 Incident Response
If you discover a security issue:
1. **Do not** commit fixes to public repositories immediately
2. Follow responsible disclosure practices
3. Contact security@github.com for GitHub-related issues
4. Document everything for post-incident analysis

---

**💡 Pro Tip**: Start with the immediate actions, then gradually implement the advanced measures. Security is a journey, not a destination!

**⚠️ Remember**: This checklist is based on the vulnerability demonstrated in the OpenSSF talk. Always stay updated with the latest security best practices and emerging threats.
