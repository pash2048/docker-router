FROM debian:sid

RUN set -ex\
    && apt install curl

COPY setup.sh /setup.sh

RUN chmod +x /setup
CMD /setup.sh