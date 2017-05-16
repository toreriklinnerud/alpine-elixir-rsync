FROM bitwalker/alpine-elixir

RUN apk add --update --no-cache openssh rsync curl sudo

COPY prepare_sshd.sh run_sshd.sh /root/
RUN /root/prepare_sshd.sh

WORKDIR /opt/app

EXPOSE 22

ENTRYPOINT ["/root/run_sshd.sh"]
