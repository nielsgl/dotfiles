#!/bin/sh
#
# install pyenv
# https://github.com/yyuu/pyenv

function install_pyenv() {
  if ! brew_test_package 'pyenv'; then
    ask_for_confirmation "Do you want to install pyenv?"
    if answer_is_yes; then
      brew update
      brew install pyenv
    fi
    print_success "pyenv has been installed. Please run 'pyenv init' and follow the instructions."
  fi
}

function main() {
  install_pyenv
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
