#!/bin/sh
# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

function setup_hostname () {
  ask_for_confirmation "Do you want to update the hostname?"
  if answer_is_yes; then
    print_info "Current hostname: '$(hostname)'"
    ask "Enter the hostname:" hostname
    print_info "Setting new hostname to $hostname..."
    sudo scutil --set HostName "$hostname"
    compname=$(sudo scutil --get HostName | tr '-' '.')
    print_info "Setting computer name to $compname"
    sudo scutil --set ComputerName "$compname"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"
  fi
  print_success "Hostname has been set up."
}

function storeupdate() {
  ask_for_confirmation "Do you want to update apps from the App Store?"
  if answer_is_yes; then
    print_info "Update apps from the App Store"
    sudo softwareupdate -i -a
    print_succcess "Completed updates from App Store"
  fi
}

function main() {
  setup_hostname
  storeupdate
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
