## SSL Configuration

1. Obtain an SSL certificate using Certbot (replace `$HOSTNAME` with your actual hostname):

```
sudo certbot --nginx --domain $HOSTNAME --register-unsafely-without-email --no-redirect --agree-tos
```

## Nginx Configuration

1. Open the Nginx configuration file:

```
sudo nano /etc/nginx/sites-available/viper
```

2. Copy and paste the following content into the file (replace `$HOSTNAME` with your actual hostname):

```nginx
server {
    add_header Access-Control-Allow-Origin "*";
    listen 80 ;
    listen [::]:80 ;
    listen 8081 ssl;
    listen [::]:8081 ssl;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name $HOSTNAME;

    location / {
        try_files $uri $uri/ =404;
    }

    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/$HOSTNAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$HOSTNAME/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    access_log /var/log/nginx/reverse-access.log;
    error_log /var/log/nginx/reverse-error.log;

    location ~* ^/v1/client/(dispatch|relay|sim|trigger) {
        proxy_pass http://127.0.0.1:8082;
        add_header Access-Control-Allow-Methods "POST, OPTIONS";
        allow all;
    }

    location = /v1 {
        add_header Access-Control-Allow-Methods "GET";
        proxy_pass http://127.0.0.1:8082;
        allow all;
    }

    location = /v1/query/height {
        add_header Access-Control-Allow-Methods "GET";
        proxy_pass http://127.0.0.1:8082;
        allow all;
    }
}
```

3. Save the file and exit the editor (press `Ctrl+O`, `Enter`, `Ctrl+X`).
4. Stop the Nginx service:

```
sudo systemctl stop nginx
```

5. Remove the default Nginx configuration:

```
sudo rm /etc/nginx/sites-enabled/default
```

6. Create a symbolic link to the new Vipernet configuration:

```
sudo ln -s /etc/nginx/sites-available/viper /etc/nginx/sites-enabled/viper
```

7. Start the Nginx service:

```
sudo systemctl start nginx
```
