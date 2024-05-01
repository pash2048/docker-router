FROM ubuntu:22.04


RUN apt-get -y update 
RUN apt-get install -y curl sudo iptables
COPY setup.sh /setup.sh

RUN chmod +x /setup.sh
CMD /setup.sh
# RUN echo $DST_SERVER_IP