server {
    listen 80;
    server_name godofredo.com www.godofredo.com;

    root /var/www/html/godofredo.com;  # Directorio raíz

    location / {
        index index.html index.php;  # Archivo index
    }

    location /upload {
        client_max_body_size 10M;  # Ajusta según el tamaño máximo permitido para las cargas
        try_files $uri =404;  # Devuelve 404 si no se encuentra el archivo
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;  # Configuración para PHP
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;  # Asegúrate de que la versión sea correcta
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    error_page 500 /50x.html;  # Manejo de errores
    location = /50x.html {
        root /usr/share/nginx/html;  # Ajusta según tu estructura de directorios
    }
}
