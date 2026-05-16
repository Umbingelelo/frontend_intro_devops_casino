# ---------- Etapa builder ----------
    FROM node:20-alpine AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    COPY . .
    RUN npm run build
    
    # ---------- Etapa runtime ----------
    FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime
    
    # Copiamos la configuración dándole propiedad al usuario nginx
    COPY --chown=nginx:nginx default.conf.template /etc/nginx/templates/default.conf.template
    
    # Copiamos los archivos compilados de Angular dándole propiedad al usuario nginx
    COPY --from=builder --chown=nginx:nginx /app/dist/casino-frontend/browser/. /usr/share/nginx/html/
    
    USER nginx
    EXPOSE 8080