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

      if ! find_in_zshrc "eval \"\$(rbenv init -)\""; then
        ask_for_confirmation "Do you want to add the init script to ~/.zshrc?"
        if answer_is_yes; then
          printf "\n\n# Load rbenv automatically by appending\n# the following to ~/.zshrc:\neval \"\$(rbenv init -)\"\n\n" >> $HOME/.zshrc
        else
          print_info "Please run 'rbenv init' and follow the instructions."
        fi
      fi

      print_info "Installing rbenv update in `rbenv root`/plugins"
      git clone https://github.com/rkh/rbenv-update.git "$(rbenv root)/plugins/rbenv-update" &> /dev/null

      print_info "Installing rbenv vars in `rbenv root`/plugins"
      git clone https://github.com/rbenv/rbenv-vars.git "$(rbenv root)/plugins/rbenv-vars" &> /dev/null

    	print_success "rbenv has been installed."
		fi
  else
    print_success "rbenv was already installed."
  fi
}

function main() {
  install_rbenv
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
