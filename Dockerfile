# Etapa 1: Build de Angular
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# Etapa 2: Servidor Nginx seguro
FROM nginxinc/nginx-unprivileged:alpine AS runtime

# Cambiamos esta línea para que busque cualquier carpeta dentro de dist
# Usamos un comodín para copiar el contenido de la carpeta generada
COPY --from=builder /app/dist/*/ /usr/share/nginx/html/

COPY default.conf.template /etc/nginx/templates/default.conf.template
EXPOSE 8080