SSHD_CONFIG="/etc/ssh/sshd_config"

sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' $SSHD_CONFIG
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' $SSHD_CONFIG
sed -i 's/#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/g' $SSHD_CONFIG
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' $SSHD_CONFIG
sed -i 's/#PermitRootLogin no/PermitRootLogin no/g' $SSHD_CONFIG
