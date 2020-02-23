# THIS is production docker file
# temporary container to build production build
FROM node:alpine as builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Production ngnx container 
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
# where  /usr/share/nginx/html  is from docker gub nginx documentation, serve static files
# nginx image runs it automactically

# after that use command:
# docker run -p 3000:80  <IMAGE_ID>
# where is 80 is default nginx exposed port, and 3000 its yours chosen port