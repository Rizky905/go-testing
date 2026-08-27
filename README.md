install nginx

1. make folder nginx for nginx.conf

2. make network => podman network create app-network

4. nginx.conf 
    events {}

    http {
        server {
            listen 80;
            
            location / {
                return 200 "Nginx App Gateway is running\n";
                add_header Content-Type text/plain;
            }

            location /go-testing/ {
                proxy_pass http://go-testing:4000;

                proxy_http_version 1.1;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
            }
        }
    }

4. 
podman run -d \
  --name nginx-rizkye-app \
  --network rizkye-app-network \
  -p 8010:80 \
  -v /home/rizky_e/nginx-rizkye-app/nginx.conf:/etc/nginx/nginx.conf:ro,Z \
  docker.io/library/nginx:alpine

4. restart after add new url => podman restart nginx-rizkye-app