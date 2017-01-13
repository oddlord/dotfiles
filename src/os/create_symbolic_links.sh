#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlink() {

  if [ ! -e "$1" ] || $skipQuestions; then

      execute \
          "ln -fs $2 $1" \
          "$1 → $2"

  elif [ "$(readlink "$1")" == "$2" ]; then
      print_success "$1 → $2"
  else

      if ! $skipQuestions; then

          ask_for_confirmation "'$1' already exists, do you want to overwrite it?"
          if answer_is_yes; then

              rm -rf "$1"

              execute \
                  "ln -fs $2 $1" \
                  "$1 → $2"

          else
              print_error "$1 → $2"
          fi

      fi

  fi

}

create_symlinks() {

    declare -a HOME_FILES_TO_SYMLINK=(

        "shell/bash_aliases"
        "shell/bash_autocomplete"
        "shell/bash_exports"
        "shell/bash_functions"
        "shell/bash_logout"
        "shell/bash_options"
        "shell/bash_profile"
        "shell/bash_prompt"
        "shell/bashrc"
        "shell/curlrc"
        "shell/inputrc"

        "git/gitattributes"
        "git/gitconfig"
        "git/gitignore"

        "atom/config.cson"

    )

    local atom_home = "$HOME/.atom"

    declare -a ATOM_FILES_TO_SYMLINK=(

        "config.cson"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${HOME_FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        create_symlink "$targetFile" "$sourceFile"

    done

    if [ ! -d "$atom_home" ]; then
        execute \
            "mkdir $atom_home" \
            "Create directory $atom_home"
    fi

    for i in "${ATOM_FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/atom/$i"
        targetFile="$atom_home/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        create_symlink "$targetFile" "$sourceFile"

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n • Create symbolic links\n\n"
    create_symlinks "$@"
}

main "$@"
