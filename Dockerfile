FROM mysql
COPY teamData.csv /var/lib/mysql-files/
COPY init_db.sql /docker-entrypoint-initdb.d/