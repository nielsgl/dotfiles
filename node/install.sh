#!/bin/sh
#
# install nodenv
# https://github.com/nodenv/nodenv

function install_nodenv() {

  if ! brew_test_package 'nodenv'; then
    brew tap nodenv/nodenv
    brew update
    brew install nodenv nodenv/nodenv/nodenv-package-rehash

    if ! find_in_zshrc "eval \"\$(nodenv init -)\""; then
      ask_for_confirmation "Do you want to add the init script to ~/.zshrc?"
      if answer_is_yes; then
        printf "\n\n# Load nodenv automatically by appending\n# the following to ~/.zshrc:\neval \"\$(nodenv init -)\"\n\n" >> $HOME/.zshrc
      else
        print_info "Please run 'nodenv init' and follow the instructions."
      fi
    fi

    print_info "Installing nodenv update in `nodenv root`/plugins"
    git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)/plugins/nodenv-update" &> /dev/null

    print_info "Installing nodenv vars in `nodenv root`/plugins"
    git clone https://github.com/nodenv/nodenv-vars.git "$(nodenv root)/plugins/nodenv-vars" &> /dev/null

    print_info "Installing nodenv package rehash in `nodenv root`/plugins"
    git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)/plugins/nodenv-package-rehash" &> /dev/null

    print_success "nodenv has been installed."
  else
    print_success "Nodenv was already installed. Please run 'nodenv init' and follow the instructions."
  fi
}

function main() {
	if ! cmd_exists 'nodenv' && ! cmd_exists 'nvm'; then
		print_info "You can install and manage node with nodenv or nvm"
	  ask_for_confirmation "Do you want to install nodenv?"
	  if answer_is_yes; then
	    install_nodenv
	  elif ! brew_test_package 'nodenv'; then
	    ask_for_confirmation "Do you want to install nvm?"
	    if answer_is_yes; then
	      # ...
	      # curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
	      curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
	      print_success "nvm has been installed and added to your shell config."
	    else
	      print_error "Unable to install nvm, please remove nodenv first."
	    fi
	  fi
	else
		if cmd_exists 'nodenv'; then
			print_success 'nodenv was already installed'
		elif cmd_exists 'nvm'; then
			print_success 'nvm was already installed'
		fi
	fi
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
