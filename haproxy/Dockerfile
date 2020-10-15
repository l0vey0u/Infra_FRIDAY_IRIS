FROM haproxy
# https://stackoverflow.com/questions/38356219/mysql-in-docker-frozen-at-root-password-config
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /var/lib/haproxy
RUN apt-get update && apt install gnupg wget curl lsb-release -y
RUN curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.14-1_all.deb
RUN dpkg -i mysql-apt-config_0.8.14-1_all.deb
RUN apt-get update
RUN apt install -y mysql-apt-config
RUN apt install -y mysql-server
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg