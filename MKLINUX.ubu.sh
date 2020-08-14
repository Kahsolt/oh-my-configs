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
sudo apt install i3 compton feh scrot screenfetch
sudo apt install p7zip-full tree
sudo apt install zsh screen tmux
sudo apt install moc sox libsox-fmt-all alsa-utils mplayer
sudo apt install sakura
sudo apt install chromium
sudo apt install lynx elinks irssi
sudo apt install git make cmake
sudo apt install python3 python3-pip ipython3 ruby2.3 pry lua5.3
sudo apt install mariadb mongodb
sudo apt install nginx
sudo apt install pure-ftpd

