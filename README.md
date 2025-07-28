# GitHub Actions Checkout Vulnerability Demo

This repository demonstrates the security vulnerability in GitHub Actions `actions/checkout` where credentials are persisted by default, potentially exposing sensitive tokens to malicious actors.

## The Vulnerability

GitHub Actions `actions/checkout` by default sets `persist-credentials: true`, which stores the GitHub token in `.git/config`. This makes the token accessible to any subsequent step in the workflow, creating a potential attack vector for supply chain attacks.

**Reference**: [GitHub Issue #485](https://github.com/actions/checkout/issues/485)

## Demo Components

This repository includes:

1. **Vulnerable NPM Package**: A simple "Hello World" NPM package that gets published
2. **Vulnerable Docker Image**: A basic Docker image that gets pushed to Docker Hub
3. **Insecure GitHub Actions Workflow**: Demonstrates how credentials can be leaked
4. **Attack Simulation**: Shows how a malicious actor could exploit exposed credentials

## Files Structure

```
├── .github/workflows/
│   ├── vulnerable-workflow.yml    # Demonstrates the vulnerability
│   └── secure-workflow.yml        # Shows the proper secure configuration
├── package.json                   # NPM package configuration
├── Dockerfile                     # Docker image definition
├── src/
│   └── index.js                   # Simple Hello World application
├── scripts/
│   └── exploit-demo.sh            # Demonstrates potential exploitation
└── README.md                      # This file
```

## How the Attack Works

1. **Token Persistence**: `actions/checkout` persists GitHub token in `.git/config`
2. **Token Access**: Any subsequent workflow step can read the token from the file system
3. **Credential Exfiltration**: Malicious code can extract and misuse these credentials
4. **Supply Chain Attack**: Attackers can publish compromised packages/images with legitimate credentials

## Reproduction Steps

1. Fork this repository
2. Set up Docker Hub credentials in repository secrets (`DOCKER_USERNAME`, `DOCKER_PASSWORD`)
3. Set up NPM credentials in repository secrets (`NPM_TOKEN`)
4. Push to main branch to trigger the vulnerable workflow
5. Observe how credentials are exposed in the workflow logs

## Mitigation

Always use `persist-credentials: false` in your checkout action:

```yaml
- uses: actions/checkout@v4
  with:
    persist-credentials: false
```

## Warning

⚠️ **This is for educational purposes only. Do not use this in production environments.**
