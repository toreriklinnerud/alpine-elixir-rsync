sed \
  -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' \
  -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' \
  -e 's/#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/g' \
  -e 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' \
  -e 's/#PermitRootLogin no/PermitRootLogin no/g' \
  -i /etc/ssh/sshd_config
