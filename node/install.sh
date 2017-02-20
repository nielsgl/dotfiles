#!/bin/sh
#
# install nodenv
# https://github.com/nodenv/nodenv

function install_nodenv() {
  if ! brew_test_package 'nodenv'; then
    ask_for_confirmation "Do you want to install Nodenv?"
    if answer_is_yes; then
      brew tap nodenv/nodenv
      brew update
      brew install nodenv nodenv/nodenv/nodenv-package-rehash
    fi
    print_success "Nodenv has been installed. Please run 'nodenv init' and follow the instructions."
  fi
}

function main() {
  install_nodenv
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
