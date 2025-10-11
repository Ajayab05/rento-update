# Builder stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json ./
COPY .env .env
RUN npm install -g pnpm && pnpm install --frozen-lockfile || pnpm install
COPY . .
RUN pnpm build

# Runner stage
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app .
RUN npm install -g pnpm
EXPOSE 3000
CMD ["pnpm", "start"]
