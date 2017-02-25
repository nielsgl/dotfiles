#!/bin/bash

function find_in_file() {
  [[ -f $1 ]] && return 0 || return 1
}

function find_in_zshrc() {
  if find_in_file $PWD/zsh/zshrc.symlink; then
    grep -Fxq "$1" $PWD/zsh/zshrc.symlink && return 0 || return 1
  fi
  return 1
}

echo "find_in_file"
if ! find_in_zshrc "eval \"\$(nodenv init -)\""; then
  echo "not found"
else
  echo "found"
fi
