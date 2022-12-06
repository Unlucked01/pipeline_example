# build environment
FROM node:alpine as build
WORKDIR /app
COPY package.json ./
RUN yarn install --silent
COPY . ./
RUN npm run build
# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html/SnapShot
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
