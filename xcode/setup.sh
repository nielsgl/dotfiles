#!/bin/sh
#
# Setup XCode Command Line Tools
#

function setup_xcode() {
  ask_for_confirmation "Do you want to install XCode Command Line Tools?"
  if answer_is_yes; then
    if [[ ! "$(type -P gcc)" ]] && is_osx; then
      print_error "XCode or the Command Line Tools for XCode must be installed first."
      # exit 1

      ###############################################################################
      # XCode Command Line Tools                                                    #
      ###############################################################################

      if ! xcode-select --print-path &> /dev/null; then

        # Prompt user to install the XCode Command Line Tools
        xcode-select --install &> /dev/null

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Wait until the XCode Command Line Tools are installed
        until xcode-select --print-path &> /dev/null; do
          sleep 5
        done

        print_result $? 'Install XCode Command Line Tools'

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Point the `xcode-select` developer directory to
        # the appropriate directory from within `Xcode.app`
        # https://github.com/alrra/dotfiles/issues/13

        sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
        print_result $? 'Make "xcode-select" developer directory point to Xcode'

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Prompt user to agree to the terms of the Xcode license
        # https://github.com/alrra/dotfiles/issues/10

        sudo xcodebuild -license
        print_result $? 'Agree with the XCode Command Line Tools licence'

      fi
    else
      print_success "XCode has been set up."
    fi
  fi
}

function main() {
  setup_xcode
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
