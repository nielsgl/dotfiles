#!/bin/sh
#
# install nodenv
# https://github.com/nodenv/nodenv

function install_nodenv() {
  if ! brew_test_package 'nodenv'; then
    brew tap nodenv/nodenv
    brew update
    brew install nodenv nodenv/nodenv/nodenv-package-rehash

    ask_for_confirmation "Do you want to add the init script to ~/.zshrc?"
    if answer_is_yes; then
      printf "\n\n# Load nodenv automatically by appending\n# the following to ~/.zshrc:\neval \"\$(nodenv init -)\"\n\n" >> $HOME/.zshrc
    else
      print_info "Please run 'nodenv init' and follow the instructions."
    fi
    print_success "nodenv has been installed."
  else
    print_success "Nodenv was already installed. Please run 'nodenv init' and follow the instructions."
  fi
}

function main() {
  print_info "You can install and manage node with nodenv or nvm"
  ask_for_confirmation "Do you want to install nodenv?"
  if answer_is_yes; then
    install_nodenv
  fi
  if ! brew_test_package 'nodenv'; then
    ask_for_confirmation "Do you want to install nvm?"
    if answer_is_yes; then
      # ...
      # curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
      curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
      print_success "nvm has been installed and added to your shell config."
    fi
  else
    print_error "Unable to install nvm, please remove nodenv first."
  fi
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
