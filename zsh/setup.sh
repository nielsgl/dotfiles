#!/bin/sh
#
# Setup ZSH as default shell
# Install Oh-My-ZSH

function install_zsh() {
  # Test to see if zshell is installed with brew

  if brew_test_package 'zsh'; then
    print_success 'Homebrew has installed ZSH.'

    # Install Oh My Zsh if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
      print_info 'Installing Oh My ZSH.'
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
      print_success 'Oh My ZSH has been installed.'
    fi
  else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
      if [[ -f /etc/redhat-release ]]; then
        sudo yum install zsh
        install_zsh
      fi
      if [[ -f /etc/debian_version ]]; then
        sudo apt-get install zsh
        install_zsh
      fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
      print_info "We'll install zsh, then re-run this script!"
      if ! brew_test_package 'zsh'; then
        print_info 'Installing ZSH with Homebrew'
        brew install zsh --with-unicode9
      fi

      # Set the default shell to zsh if it isn't currently set to zsh
      if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
        chsh -s $(which zsh)
      fi

      exit
    fi
  fi

}

function main() {
  install_zsh
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
