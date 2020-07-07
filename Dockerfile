FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx

# Does nothing in general during development
# But elastic beanstalk maps to this port automatically
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html