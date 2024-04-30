FROM debian:sid

COPY setup.sh /setup.sh

RUN chmod +x /setup.sh
CMD /setup.sh