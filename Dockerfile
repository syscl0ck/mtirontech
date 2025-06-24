FROM node:18-alpine
# This
WORKDIR /app
# Dockerfile
COPY ./tech-landing-page .
# Doesn't 
WORKDIR /app/tech-landing-page
# Work
COPY package*.json ./

RUN npm install

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]