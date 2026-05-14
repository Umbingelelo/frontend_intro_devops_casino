FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime
USER root
# Borramos el default.conf para que no interfiera
RUN rm -f /etc/nginx/conf.d/default.conf
USER nginx

# FORMA SEGURA: Copiamos TODO lo que esté dentro de dist y sus subcarpetas
# El punto al final de la ruta de origen es clave
COPY --from=builder --chown=nginx:nginx /app/dist/*/browser/ /usr/share/nginx/html/

# Si la ruta anterior falla, intenta esta que es más genérica:
# COPY --from=builder --chown=nginx:nginx /app/dist/ /usr/share/nginx/html/

COPY --chown=nginx:nginx nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 8080