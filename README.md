# Hello World Docker App

A simple Node.js web application that runs in Docker.

## Getting Started

### Local Development

Install dependencies:
```bash
npm install
```

Run the application:
```bash
npm start
```

The app will be available at http://localhost:3000

### Docker

Build the Docker image:
```bash
docker build -t hello-world-app .
```

Run the container:
```bash
docker run -p 3000:3000 hello-world-app
```

## CI/CD

This project uses GitHub Actions to automatically build and push Docker images to Docker Hub.

## License

MIT
