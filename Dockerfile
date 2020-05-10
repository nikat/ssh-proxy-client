FROM alpine

RUN apk add --no-cache openssh

ADD ssh_config /etc/ssh/ssh_config
ADD id_rsa /etc/ssh/id_rsa

EXPOSE 10050
CMD ["/usr/bin/ssh", "-N", "proxyserver"]
