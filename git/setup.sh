#!/bin/sh
#
# Setup gitconfig
#

function setup_gitconfig () {
  ask_for_confirmation "Do you want to generate gitconfig file?"
  rootdir="$(cd "$(dirname "$BASH_SOURCE")"; cd ..; pwd)"
  if answer_is_yes; then
    if ! [ -f $rootdir/git/gitconfig.local.symlink ]
    then
      print_info 'Setting up gitconfig.'

      git_credential='cache'
      if [ "$(uname -s)" == "Darwin" ]
      then
        git_credential='osxkeychain'
      fi

      ask "What is your github author name?" git_authorname
      ask 'What is your github author email?' git_authoremail

      sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" $rootdir/git/gitconfig.local.symlink.example > $rootdir/git/gitconfig.local.symlink

      print_success 'Setting up gitconfig complete.'
    fi
  fi
}

function main() {
  setup_gitconfig
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
