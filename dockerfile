FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production


FROM nginxinc/nginx-unprivileged:alpine AS runtime


COPY --from=builder /app/dist/casino-frontend/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

USER nginx
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]