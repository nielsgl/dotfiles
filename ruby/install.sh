#!/bin/sh
#
# install rbenv
# https://github.com/nodenv/nodenv

function install_rbenv() {
  if ! brew_test_package 'rbenv'; then
    ask_for_confirmation "Do you want to install rbenv?"
    if answer_is_yes; then
      brew update
      brew install rbenv
    fi
    print_success "Rbenv has been installed. Please run 'rbenv init' and follow the instructions."
  fi
}

function main() {
  install_rbenv
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
