#!/usr/bin/env bash

# Hardware
sudo update-pciids
sudo update-usbids

# Package manager
sudo pacman -Syu

# Libraries

# CLI Programs
sudo pacman -S \
  zsh tmux screen \
  alsa-utils \
  screenfetch \
  p7zip-full \
  elinks \
  wireshark tshark\
  nginx \
  polipo \
  mariadb-server mongodb \
  memcached redis-server \
  memcachedb \
  rabbitmq-server \
  docker.io

# GUI Programs
sudo pacman -S \
  i3-wm \
  virtualbox

# Development
sudo pacman -S \
  git \
  cmake \
  python3 python3-dev python3-pip ipython3 \
  ruby2.3 ruby2.3-dev gem pry \
  lua5.3 lib5.3-dev luarocks \
  openjdk-9-jdk-headless \
  r-base \
  erlang-base

# App
sudo pip3 install \
  shadowsocks \
  django flask \
  scrapy
gem install \
  rails

  
# Account
sudo useradd -m -U -p 1379 kahsolt
sudo gpasswd -a kahsolt wireshark
sudo gpasswd -a kahsolt docker


sudo pacman -S i3 compton feh scrot screenfetch
sudo pacman -S p7zip-full tree
sudo pacman -S zsh screen tmux
sudo pacman -S moc sox libsox-fmt-all alsa-utils mplayer
sudo pacman -S sakura
sudo pacman -S chromium
sudo pacman -S lynx elinks irssi
sudo pacman -S git make cmake
sudo pacman -S python3 python3-pip ipython3 ruby2.3 pry lua5.3
sudo pacman -S mariadb mongodb
sudo pacman -S nginx
sudo pacman -S pure-ftpd

