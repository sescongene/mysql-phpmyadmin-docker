FROM phpmyadmin/phpmyadmin

ENV PMA_HOST=${PMA_HOST}
ENV PMA_PORT=${PMA_PORT}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# create the admin user with a password from the .env file
RUN echo "CREATE USER 'admin'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%'; FLUSH PRIVILEGES;" > /docker-entrypoint-initdb.d/create_admin_user.sql

# set some additional parameters
RUN echo "\$cfg['MaxRows'] = 5000;" >> /usr/share/phpmyadmin/config.inc.php
RUN echo "\$cfg['MemoryLimit'] = '256M';" >> /usr/share/phpmyadmin/config.inc.php
RUN echo "\$cfg['ExecTimeLimit'] = 0;" >> /usr/share/phpmyadmin/config.inc.php