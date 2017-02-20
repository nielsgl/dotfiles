#!/bin/sh
#
# Install packages from Brewfile
#

function install_brewfile() {
  ask_for_confirmation "Do you want to install Brewfile?"
  if answer_is_yes; then
    print_info 'Tapping homebrew/bundle.'
    brew tap homebrew/bundle
    print_info 'Installing Brewfile.'
    brew bundle
    sudo chown -R "$(whoami)":staff ~/.config
    print_success 'Brewfile has been installed.'
  fi
}

function main() {
  install_brewfile
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
