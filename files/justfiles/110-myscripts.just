# vim: set ft=make :

# Configure ssh keys
[group('MyJusts')]
install-ssh-keys:
  #!/usr/bin/env bash
  curl http://192.168.148.24:8081/id_rsa.pub --create-dirs -o ~/.ssh/id_rsa.pub
  curl http://192.168.148.24:8081/id_rsa --create-dirs -o ~/.ssh/id_rsa
  curl http://192.168.148.24:8081/id_ed25519_gitlab.pub --create-dirs -o ~/.ssh/id_ed25519_gitlab.pub
  curl http://192.168.148.24:8081/id_ed25519_gitlab --create-dirs -o ~/.ssh/id_ed25519_gitlab
  curl http://192.168.148.24:8081/id_ed25519_codeberg.pub --create-dirs -o ~/.ssh/id_ed25519_codeberg.pub
  curl http://192.168.148.24:8081/id_ed25519_codeberg --create-dirs -o ~/.ssh/id_ed25519_codeberg
  curl http://192.168.148.24:8081/config --create-dirs -o ~/.ssh/config

  chmod 600 ~/.ssh/id*
  chmod 600 ~/.ssh/config

  if ! ssh-keygen -F github.com; then
    ssh-keyscan github.com >> ~/.ssh/known_hosts
  fi

  if ! ssh-keygen -F gitlab.com; then
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
  fi

  if ! ssh-keygen -F codeberg.org; then
    ssh-keyscan codeberg.org >> ~/.ssh/known_hosts
  fi

  chmod 600 ~/.ssh/known_hosts

# Install bluebox toolbox: ghcr.io/pliveyns/bluebox
[group('MyJusts')]
toolbox-bluebox:
  #!/bin/sh
  # should not run if the toolbox already exists
  toolbox list --containers | grep bluebox >& /dev/null
  if [ $? -eq 0 ]
  then
    echo "The toolbx bluebox already exists and will not be installed"
  else
    echo "Installing bluebox toolbx"
    toolbox create -y -i ghcr.io/pliveyns/bluebox -c bluebox
  fi

# Install iotbox toolbox: ghcr.io/pliveyns/iotbox
[group('MyJusts')]
toolbox-iotbox:
  #!/bin/sh
  # should not run if the toolbox already exists
  toolbox list --containers | grep iotbox >& /dev/null
  if [ $? -eq 0 ]
  then
    echo "The toolbx iotbox already exists and will not be installed"
  else
    echo "Installing iotbox toolbx"
    toolbox create -y -i ghcr.io/pliveyns/iotbox -c iotbox
  fi

# Set firefox as default default browser
[group('MyJusts')]
default-browser-firefox:
  xdg-settings set default-web-browser org.mozilla.firefox.desktop

# Run the ansible postinstalscript
[group('MyJusts')]
postinstall:
  curl http://192.168.148.24:8081/bootstrapublue | bash

# Setup dotfiles with chezmoi
[group('MyJusts')]
setup-chezmoi:
  systemctl enable --user --now chezmoi-init.service chezmoi-update.timer

# Workaround for libvirt issues
[group('MyJusts')]
libvirt-workaround:
  sudo groupadd -g 963 libvirt
  sudo groupadd -g 107 qemu
  sudo useradd -u 107 -g 107 -d / -s /usr/sbin/nologin qemu
  sudo usermod -aG livirt ${USER}
  sudo usermod -aG qemu ${USER}
  sudo restorecon -rv /var/lib/libvirt/
  sudo restorecon -rv /var/log/libvirt/
