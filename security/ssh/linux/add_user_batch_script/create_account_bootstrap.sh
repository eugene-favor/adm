#!/bin/bash

USERNAME=$1

useradd --shell=/bin/bash --user-group --groups=sudo --create-home ${USERNAME}
mkdir /home/${USERNAME}/.ssh
chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
chmod 700 /home/${USERNAME}/.ssh
mv ${USERNAME}.pub /home/${USERNAME}/.ssh/authorized_keys
chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh/authorized_keys
chmod 600 /home/${USERNAME}/.ssh/authorized_keys
passwd ${USERNAME}