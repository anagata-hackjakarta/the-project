FROM docker.io/library/node:22-alpine
WORKDIR /app
COPY . .

RUN corepack enable; \
  pnpm install --frozen-lockfile;

EXPOSE 3000
CMD ["pnpm", "start"]
