install nginx

1. make folder nginx for nginx.conf

2. make network => podman network create app-network

3. 
podman run -d \
  --name nginx-rizkye-app \
  --network rizkye-app-network \
  -p 8010:80 \
  -v /home/rizky_e/nginx-rizkye-app/nginx.conf:/etc/nginx/nginx.conf:ro,Z \
  docker.io/library/nginx:alpine

4. restart after add new url => podman restart nginx-rizkye-app