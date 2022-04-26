FROM alpine:latest

RUN apk update && apk add R R-dev g++ libsodium libsodium-dev unixodbc unixodbc-dev psqlodbc

RUN Rscript -e "install.packages(c('plumber', 'odbc'), repos='https://cloud.r-project.org')" 

RUN echo "[PostgreSQL Driver]" >> /etc/odbcinst.ini
RUN echo "Driver          = /usr/lib/psqlodbcw.so" >> /etc/odbcinst.ini

ADD plumber.R start_plumber.R /home/

EXPOSE 8080

ENTRYPOINT ["Rscript"]
CMD ["/home/start_plumber.R"]
#CMD ["/bin/sh"]