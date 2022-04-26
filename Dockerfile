FROM alpine:latest

RUN apk update && apk add R R-dev g++ libsodium libsodium-dev

RUN Rscript -e "install.packages('plumber', repos='https://cloud.r-project.org')" 

ADD plumber.R start_plumber.R /home/

EXPOSE 8080

ENTRYPOINT ["Rscript"]
CMD ["/home/start_plumber.R"]
#CMD ["/bin/sh"]