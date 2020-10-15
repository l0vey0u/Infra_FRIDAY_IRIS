FROM mysql:8.0

COPY init.sql /docker-entrypoint-initdb.d/init.sql
COPY mysql.cnf /etc/mysql/conf.d/mysql.cnf

CMD ["mysqld"]