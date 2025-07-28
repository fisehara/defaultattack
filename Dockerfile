# Vulnerable Docker Image Demo
# This Dockerfile creates a simple container that could be compromised
# if GitHub Actions credentials are exposed

FROM node:18-alpine

# Set working directory
WORKDIR /app

# Add metadata
LABEL maintainer="openssf-security-demo" \
      version="1.0.0" \
      description="Demo image showing GitHub Actions vulnerability potential" \
      vulnerability.demo="true"

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy application code
COPY src/ ./src/

# Create a non-root user for security best practices
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# In a real attack scenario, malicious code could be injected here
# that would exfiltrate credentials or modify the container

# Expose port
EXPOSE 3000

# Switch to non-root user
USER nodejs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "console.log('Container is healthy')" || exit 1

# Default command
CMD ["npm", "start"]

# Security note: This image demonstrates how credentials leakage 
# could lead to compromised container images being published
# with legitimate credentials, making them appear trustworthy
