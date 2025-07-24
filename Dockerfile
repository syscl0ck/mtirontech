# Build and run the Next.js app located in tech-landing-page

FROM node:20-alpine AS builder
WORKDIR /app

# Copy dependency definitions first for caching
COPY tech-landing-page/package*.json ./
RUN npm install

# Copy application source
COPY tech-landing-page ./

# Build the Next.js application
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public
COPY --from=builder /app/posts ./posts

EXPOSE 3000
CMD ["node", "server.js"]
