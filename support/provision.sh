#!/bin/bash -x

# fix locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

# Uncomment the following to build using package manager:
sudo apt-get install -y mosh

# Uncomment the following to build from source:
# sudo apt-get install -y libncurses5-dev libprotobuf-dev libssl-dev protobuf-compiler zlib1g-dev
# sudo apt-get install -y autoconf build-essential git pkg-config
# git clone https://github.com/keithw/mosh
# cd mosh
# ./autogen.sh
# ./configure
# make
# sudo make install
# cd ../
# rm -rf mosh/
