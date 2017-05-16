#!/bin/sh
USER_SSH_DIRECTORY=/opt/app/.ssh
GITHUB_USERNAME=$1

rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && ssh-keygen -A

RANDOM_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

echo default:$RANDOM_PASSWORD | chpasswd
echo root:$RANDOM_PASSWORD | chpasswd


if [ -z "$GITHUB_USERNAME" ]; then
    echo "GitHub username must be specified as the first argument"
    exit 1
fi

if ! [ -z "SSHD_LOG_LEVEL"]; then
  sed -i 's/#LogLevel INFO/LogLevel $SSHD_LOG_LEVEL/g' /etc/ssh/sshd_config
fi

mkdir -p $USER_SSH_DIRECTORY &&
echo "Retriving public keys from https://github.com/$GITHUB_USERNAME.keys..." &&
curl https://github.com/$GITHUB_USERNAME.keys -o $USER_SSH_DIRECTORY/authorized_keys --fail -q &&
chmod 700 $USER_SSH_DIRECTORY &&
chmod 600 $USER_SSH_DIRECTORY/authorized_keys &&
chown -R default $USER_SSH_DIRECTORY &&

exec /usr/sbin/sshd -e -D
