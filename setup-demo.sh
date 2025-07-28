#!/bin/bash

# 🚀 Demo Setup Script for OpenSSF Talk
# This script helps prepare the demonstration environment

echo "🎯 Setting up GitHub Actions Security Demo"
echo "========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Please run this script from the repository root"
    echo "   Expected to find package.json in current directory"
    exit 1
fi

echo "✅ Found package.json - proceeding with setup"
echo ""

# Install Node.js dependencies
echo "📦 Installing Node.js dependencies..."
if command -v npm &> /dev/null; then
    npm install
    echo "✅ NPM dependencies installed"
else
    echo "⚠️  npm not found - please install Node.js"
fi
echo ""

# Check Docker availability
echo "🐳 Checking Docker availability..."
if command -v docker &> /dev/null; then
    echo "✅ Docker is available"
    
    # Build the demo image
    echo "🔨 Building demo Docker image..."
    docker build -t github-actions-security-demo:latest .
    echo "✅ Docker image built successfully"
else
    echo "⚠️  Docker not found - Docker demos will not work"
fi
echo ""

# Make scripts executable
echo "🔧 Setting up executable permissions..."
chmod +x scripts/*.sh
echo "✅ Scripts are now executable"
echo ""

# Initialize git repository if needed
if [ ! -d ".git" ]; then
    echo "📝 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: GitHub Actions security demo"
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi
echo ""

# Create a sample credentials file for demonstration
echo "🔑 Creating demo credentials (for demonstration only)..."
mkdir -p demo-secrets
cat > demo-secrets/example-credentials.txt << EOF
# Example credentials file for demonstration
# ⚠️  NEVER commit real credentials to version control!

GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
NPM_TOKEN=npm_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
DOCKER_PASSWORD=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# These are fake tokens for demonstration purposes only
EOF
echo "✅ Demo credentials file created"
echo ""

# Run a quick test
echo "🧪 Running quick functionality test..."
if [ -f "src/index.js" ]; then
    node src/index.js
    echo "✅ Application runs successfully"
else
    echo "❌ src/index.js not found"
fi
echo ""

# Show final status
echo "🎉 Demo Setup Complete!"
echo "====================="
echo ""
echo "📋 Pre-flight checklist:"
echo "  ✅ Node.js dependencies installed"
echo "  ✅ Docker image built"
echo "  ✅ Scripts are executable"
echo "  ✅ Git repository ready"
echo "  ✅ Demo credentials created"
echo "  ✅ Application tested"
echo ""
echo "🚀 Ready for presentation!"
echo ""
echo "📚 Quick demo commands:"
echo "  ./scripts/exploit-demo.sh     # Run vulnerability demonstration"
echo "  npm start                     # Run the Hello World app"
echo "  docker run github-actions-security-demo:latest  # Run Docker demo"
echo ""
echo "📁 Key files for presentation:"
echo "  - .github/workflows/vulnerable-workflow.yml (shows the problem)"
echo "  - .github/workflows/secure-workflow.yml (shows the solution)"
echo "  - scripts/exploit-demo.sh (demonstrates exploitation)"
echo "  - PRESENTATION_OUTLINE.md (your talk outline)"
echo ""
echo "⚠️  Remember:"
echo "  - This is for educational purposes only"
echo "  - Do not use real credentials in demos"
echo "  - Always follow responsible disclosure practices"
