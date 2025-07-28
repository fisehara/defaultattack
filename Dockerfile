FROM debian:bookworm-slim

WORKDIR /app

COPY . .

EXPOSE 3000

CMD ["echo", "hello OpenSSF"]
