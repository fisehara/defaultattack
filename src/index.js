#!/usr/bin/env node

/**
 * Vulnerable Hello World NPM Package
 * 
 * This is a simple demonstration package that could be compromised
 * if GitHub Actions credentials are exposed through the checkout vulnerability.
 */

console.log('🔥 Hello World from a potentially vulnerable NPM package!');
console.log('📦 Package: vulnerable-hello-world-demo');
console.log('⚠️  This package demonstrates GitHub Actions security vulnerabilities');

// Simulate what a malicious actor might do if they had access to GitHub tokens
function demonstrateVulnerability() {
    console.log('\n🚨 SECURITY DEMONSTRATION:');
    console.log('If this were a real attack, a malicious actor could:');
    console.log('1. Access GitHub tokens from .git/config');
    console.log('2. Exfiltrate repository secrets');
    console.log('3. Modify source code in subsequent commits');
    console.log('4. Publish compromised packages with legitimate credentials');
    console.log('5. Access private repositories and secrets');
    
    // Check if we're in a GitHub Actions environment
    if (process.env.GITHUB_ACTIONS) {
        console.log('\n🔍 GitHub Actions Environment Detected:');
        console.log('- GITHUB_REPOSITORY:', process.env.GITHUB_REPOSITORY || 'Not set');
        console.log('- GITHUB_WORKFLOW:', process.env.GITHUB_WORKFLOW || 'Not set');
        console.log('- GITHUB_RUN_ID:', process.env.GITHUB_RUN_ID || 'Not set');
        console.log('- RUNNER_OS:', process.env.RUNNER_OS || 'Not set');
        
        // In a real attack, this is where credentials might be exfiltrated
        console.log('\n⚠️  In a real attack scenario, credentials could be extracted here!');
    }
}

demonstrateVulnerability();

// Export for use as a module
module.exports = {
    message: 'Hello World from vulnerable package!',
    vulnerabilityDemo: demonstrateVulnerability
};
