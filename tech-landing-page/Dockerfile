# Dockerfile for a Next.js application

# 1. Builder Stage: Build the Next.js app
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and lock files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Next.js application
# The output will be in the .next directory
RUN npm run build

# 2. Runner Stage: Create the final, smaller image
FROM node:20-alpine AS runner

WORKDIR /app

# Set environment to production
ENV NODE_ENV=production
# Uncomment the following line in case you want to disable telemetry during runtime.
# ENV NEXT_TELEMETRY_DISABLED 1

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# The `posts` directory needs to be copied to the standalone server
COPY --from=builder /app/posts ./posts

# The Next.js server will run on port 3000 by default.
EXPOSE 3000

# Command to run the Next.js server
CMD ["node", "server.js"]
