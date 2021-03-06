#!/bin/sh
#
# install pyenv
# https://github.com/yyuu/pyenv

function install_pyenv() {
  if ! brew_test_package 'pyenv'; then
    ask_for_confirmation "Do you want to install pyenv?"
    if answer_is_yes; then
      brew update
      brew install pyenv pyenv-virtualenv

      if ! find_in_zshrc "eval \"\$(pyenv init -)\""; then
        ask_for_confirmation "Do you want to add the init script to ~/.zshrc?"
        if answer_is_yes; then
          printf "\n\n# Load pyenv automatically by appending\n# the following to ~/.zshrc:\neval \"\$(pyenv init -)\"\neval \"\$(pyenv virtualenv-init -)\"\n" >> $HOME/.zshrc
        else
          print_info "Please run 'pyenv init' and follow the instructions."
        fi
      fi

      print_info "Installing pyenv update in `pyenv root`/plugins"
      git clone git://github.com/yyuu/pyenv-update.git "$(pyenv root)/plugins/pyenv-update"

      # print_info "Installing pyenv-virtualenv in `pyenv root`/plugins"
      # git clone https://github.com/yyuu/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

      print_success "pyenv has been installed."
		fi
  else
    print_success "pyenv was already installed."
  fi
}

function main() {
  install_pyenv
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
