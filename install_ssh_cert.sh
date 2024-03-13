#!/bin/bash

VER="2024.03.13.1"

read -r -d '' PUBLIC_CERT <<- EOM
##### DENGZIXU Public Keys #####
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3MVS68z2qVF22kbHD/RRvnKoJTp2xgdz/qQOgmFnJN DENGZIXU-EdDSA

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCcQJi/caWgRcksqudkNwRcOqpEKwUQV1cXcGCEtCwiiac/JFYQ7ZccrQNpcgtyfbiSJRLYtWs4N12CysOOi+XCG9ytoipOOfrI6ILBQEFNl3Ddv/kH3VCRTv+taewyLrDxQQ7CVORMNqB89Utbh92KxYk73IqS/MNVLvPls9Zl/5TgtyFu4sHVOcG7i3gSZv1k2azykD8CrdXASCy6kyikfA9X/B7jFIjjm7AUpxuaaSvl963tFCC1xdUmxFQD0C06daVUpxht8UApX6iKR7VU9XJ22oiUfca9AjknN+mfHPOiTe3Pmo+VoJXmMvLPdRkEGPRKAljsjPEC5lpdHzYUOXqrRbIV4PjcUPDd2v/9Yt/BPJU2pQR6DqM3BB4yIT3qGy8YLtUVDQuHvPjJ2DPBUbLQV2WreZW7N//g01nMGxqb8x1Em4EzewFBDmVNS+9cW1rSe9MCzTQkk1X21tgYMWUe6/+Au7u99S4hpjyhxk/6Tsbu+qBUxW40zRO3rrppHjWJFV2qegs+5odAbCTcAu7aHjxrQvU4zN+sksSM6gmU9BRgo2vrN0lV5mdWxmIq4X5rdbwPocf6+abnfAtMkSfCT+ZS+8Szsa43psLvpEdtq9fqDQDt0481M2diEbqY7wlDBAWpmA3oowcRZ9NgqRXfiVYuFXrEnVnAtEy5QQ== DENGZIXU-RSA4096
##### DENGZIXU Public Keys #####
EOM


if [ ! -d ~/.ssh/ ]; then
  mkdir ~/.ssh/
  touch ~/.ssh/authorized_keys
fi

echo "$PUBLIC_CERT" > ~/.ssh/authorized_keys

chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys
