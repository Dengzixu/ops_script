#!/bin/bash

VER="2024.03.13.0"

if [ ! -d ~/.ssh/ ]; then
  mkdir ~/.ssh/
  touch ~/.ssh/authorized_keys
fi

wget -qO- http://sh.zixu.tech/public_key/dengzixu_pub.keys > ~/.ssh/authorized_keys

chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys
