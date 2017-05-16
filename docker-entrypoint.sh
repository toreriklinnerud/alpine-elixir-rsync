#!/bin/sh
USER_SSH_DIRECTORY=/opt/app/.ssh
GITHUB_USERNAME=$1

if [ -z "$GITHUB_USERNAME" ]; then
    echo "Your GitHub username must be specified as the first argument"
    exit 1
fi

if ! [ -z "$SSHD_LOG_LEVEL" ]; then
  sed -i "s/#LogLevel INFO/LogLevel $SSHD_LOG_LEVEL/g" /etc/ssh/sshd_config
fi

# Ensure that host keys are unique
rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && ssh-keygen -A

# Set random passwords so no one can log in with passwords
RANDOM_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

echo default:$RANDOM_PASSWORD | chpasswd
echo root:$RANDOM_PASSWORD | chpasswd


# Fetch public keys from github
mkdir -p $USER_SSH_DIRECTORY &&
echo "Retriving public keys from https://github.com/$GITHUB_USERNAME.keys..." &&
curl https://github.com/$GITHUB_USERNAME.keys -o $USER_SSH_DIRECTORY/authorized_keys --fail -q --progress &&
chmod 700 $USER_SSH_DIRECTORY &&
chmod 600 $USER_SSH_DIRECTORY/authorized_keys &&
chown -R default $USER_SSH_DIRECTORY &&

# Start sshd
exec /usr/sbin/sshd -e -D
