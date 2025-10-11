# ---------- Builder ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json pnpm-lock.yaml* ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy Prisma files
COPY prisma ./prisma

# Copy rest of the source code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build the app
RUN pnpm build


# ---------- Runner ----------
FROM node:20-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production

RUN npm install -g pnpm

# Copy built app
COPY --from=builder /app ./

EXPOSE 3000
CMD ["pnpm", "start"]

