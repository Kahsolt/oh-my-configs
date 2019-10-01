#!/usr/bin/env sh

# Hardware
sudo update-pciids
sudo update-usbids

# Package manager
sudo apt update && apt upgrade
sudo apt install aptitude apt-file
sudo aptitude update && apt upgrade
sudo apt-file update

# Libraries
sudo aptitude install \
  libncursesw5 libncursesw5-dev

# CLI Programs
sudo aptitude install \
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
sudo aptitude install \
  i3-wm \
  virtualbox

# Development
sudo aptitude install \
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


# Debian/Ubuntu
apt install i3 compton feh scrot screenfetch
apt install p7zip-full tree
apt install zsh screen tmux
apt install moc sox libsox-fmt-all alsa-utils mplayer
apt install sakura
apt install chromium
apt install lynx elinks irssi
apt install git make cmake
apt install python3 python3-pip ipython3 ruby2.3 pry lua5.3
apt install mariadb mongodb
apt install nginx
apt install pure-ftpd

