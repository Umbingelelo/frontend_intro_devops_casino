# Etapa 1: build Angular
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Etapa 2: servir con Nginx
FROM nginx:alpine AS runtime
# TODO: COPY --from=builder /app/dist/casino-frontend/browser /usr/share/nginx/html
# TODO: COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80