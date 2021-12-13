FROM ubuntu:20.04

#
# Skip/Set timezone, otherwise the Ubuntu installer will halt and cannot be resumed
#
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install -y software-properties-common language-pack-en-base

#
# Install php and relevant extensions
#
RUN apt install -y unzip
RUN apt install -y php php-mbstring php-bcmath php-memcached php-ldap php-gd php-xml php-zip php-curl php-pdo php-pgsql php-sqlite3 php-redis

#
# install composer and add it to the path
#
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

#
# Move all source files from this host file system to the container file system
#
COPY . /srv/development
WORKDIR /srv/development

#
# The port 8080 will be exposed to the host maschine
#
EXPOSE 8080

#
# Start container with normal bash shell
#
CMD ["/bin/bash"]
