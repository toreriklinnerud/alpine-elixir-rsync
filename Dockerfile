FROM bitwalker/alpine-elixir

RUN chown default /opt/app/.mix
RUN apk add --update --no-cache openssh rsync curl sudo

COPY configure-sshd.sh docker-entrypoint.sh /usr/sbin/
RUN configure-sshd.sh && rm /usr/sbin/configure-sshd.sh

WORKDIR /opt/app

EXPOSE 2222

ENTRYPOINT ["/usr/sbin/docker-entrypoint.sh"]
