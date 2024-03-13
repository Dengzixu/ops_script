#!/bin/bash

VER='20231125_fix_1'

MONITOR_USER_NAME='monitor'

PUBLIC_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvbqy1IEwIkcAiYWosYIMzuQ/bbfI5Jnwddw++/0U3M monitor'


id ${MONITOR_USER_NAME} >/dev/null 2>&1

if [ ! $? -eq 0 ]; then
  useradd -s /bin/bash ${MONITOR_USER_NAME}
else
  echo echo "Monitor user [${MONITOR_USER_NAME}] aleardy existed."
fi

if [ ! -d "/home/${MONITOR_USER_NAME}/" ]; then
  mkdir /home/${MONITOR_USER_NAME}

  touch /home/${MONITOR_USER_NAME}/.bashrc
  touch /home/${MONITOR_USER_NAME}/.bash_profile
  touch /home/${MONITOR_USER_NAME}/.profile
else
  echo "Home dir aleardy existed."
fi

if [ ! -d "/home/${MONITOR_USER_NAME}/.ssh/" ]; then
  mkdir /home/${MONITOR_USER_NAME}/.ssh/
  touch /home/${MONITOR_USER_NAME}/.ssh/authorized_keys
else
  echo "Publick key aleardy existed."
fi

echo "${PUBLIC_KEY}" | tee -a /home/${MONITOR_USER_NAME}/.ssh/authorized_keys

chown -R ${MONITOR_USER_NAME}:${MONITOR_USER_NAME} /home/monitor/

chmod 700 "/home/${MONITOR_USER_NAME}/.ssh"
chmod 600 "/home/${MONITOR_USER_NAME}/.ssh/authorized_keys"

echo "Create Success"