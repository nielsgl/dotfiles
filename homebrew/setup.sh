#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

function install_homebrew() {
  print_info 'Checking for Homebrew'

  if ! cmd_exists "brew"; then
    print_info "Installing Homebrew"

    # Install the correct homebrew for each OS type
    if test "$(uname)" = "Darwin"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
    fi

    brew update
  fi

  if ! brew_test_package 'git'; then
    print_info 'Installing Git with Homebrew.'
    brew install git --with-brewed-curl --with-brewed-openssl --with-gettext
  fi

  print_success "Homebrew has been setup."
}

function main() {
  install_homebrew
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
