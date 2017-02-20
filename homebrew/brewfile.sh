#!/bin/sh
#
# Install packages from Brewfile
#

function install_brewfile() {
  print_info 'Tapping homebrew/bundle.'
  brew tap homebrew/bundle
  print_info 'Installing Brewfile.'
  brew bundle
  print_success 'Brewfile has been installed.'
}

function main() {
  install_brewfile
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
