# nginx/nginx.conf
upstream web {
    ip_hash;
    server web:8000;
}
server {
    location / {
        proxy_pass http://web/;
        proxy_redirect     off;
        proxy_set_header   Host $host;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;          
    }
    location /static {
        alias /staticfiles/;
    }
    listen 80;
    server_name localhost;
}