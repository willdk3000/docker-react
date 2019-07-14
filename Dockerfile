# Build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
# No need to add volumes or see changes because no changes in production
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
# Expose instruction does nothing EXCEPT on elastic beanstalk
# where it maps the port 80 for incoming traffic
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify a RUN command because the default starts Nginx