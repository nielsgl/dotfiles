#!/bin/sh
#
# Setup SSH Key
#

function setup_ssh() {
  print_info 'Checking for SSH key, generating one if it does not exist...'
  if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ask "Enter email address:" email
    ssh-keygen -t rsa -b 4096 -C "$email"
    ssh-add ~/.ssh/id_rsa
  fi
  print_success "SSH has been set up."
}

function main() {
  setup_ssh
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
