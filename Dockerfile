FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	git \
	make \
	qt4-qmake \
	qt4-default \
	build-essential \
	g++

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd

RUN a2enmod php5
RUN a2enmod rewrite

CMD mkdir /var/www
WORKDIR /var/www

RUN git clone --depth 1 https://github.com/jcoquerygithub/OpenJabNab.git
WORKDIR OpenJabNab/server

RUN qmake -r
RUN make

RUN cp ./openjabnab.ini-dist ./bin/openjabnab.ini
RUN sed -i -e"s/^StandAloneAuthBypass=false/StandAloneAuthBypass=true/" ./bin/openjabnab.ini \
 && sed -i -e"s/^AllowUserManageBunny=false/AllowUserManageBunny=true/" ./bin/openjabnab.ini \
 && sed -i -e"s/^AllowUserManageZtamp=false/AllowUserManageZtamp=true/" ./bin/openjabnab.ini \
 && sed -i -e"s/^AllowAnonymousRegistration/AllowAnonymousRegistration=true/" ./bin/openjabnab.ini

ENV APP_ROOTURL localhost
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 8080 8080
EXPOSE 5222 5222
EXPOSE 80 80

ADD plugin_auth.ini ./bin/plugin_auth.ini
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
RUN chmod -R 777 ../http-wrapper
 
COPY start.sh /usr/local/bin/
CMD ["start.sh"]
