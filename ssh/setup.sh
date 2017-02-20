#!/bin/sh
#
# Setup SSH Key
#

function setup_ssh() {
  ask_for_confirmation "Do you want to generate SSH keys if they don't exist?"
  if answer_is_yes; then
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
      ask "Enter email address:" email
      ssh-keygen -t rsa -b 4096 -C "$email"
      ssh-add ~/.ssh/id_rsa
    fi
    print_success "SSH has been set up."
  fi
}

function main() {
  setup_ssh
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
