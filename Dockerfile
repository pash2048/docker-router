FROM ubuntu:22.04


COPY setup.sh /setup.sh

RUN chmod +x /setup.sh
CMD /setup.sh
RUN echo $DST_SERVER_IP