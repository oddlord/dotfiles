#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_repos() {

    add_repo "Atom (WebUpd8 team)" "ppa:webupd8team/atom"
    add_repo "Git (git-core)" "ppa:git-core/ppa"
}

install_apps() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons.

    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Java (JDK)" "default-jdk"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Python pip" "python-pip"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Eclipse" "eclipse"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Atom" "atom"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "google-chrome-stable"; then

        add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
            || print_error "Google Chrome (add key)"

        add_to_source_list "[arch=amd64] https://dl.google.com/linux/deb/ stable main" "google-chrome.list" \
            || print_error "Google Chrome (add to package resource list)"

        update &> /dev/null \
            || print_error "Google Chrome (resync package index files)"

    fi

    install_package "Google Chrome" "google-chrome-stable"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Flash" "flashplugin-installer"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GIMP" "gimp"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Jekyll" "jekyll"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "VLC" "vlc"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "xclip" "xclip"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}

install_atom_packages() {

    install_atom_package "EditorConfig" "editorconfig"

    install_atom_package "Auto Close HTML" "autoclose-html"
}

install_python_packages() {

    install_python_package "pip" "pip"

    install_python_package "Virtualenv" "virtualenv"
}

main() {
    print_in_purple "\n • Installs\n\n"

    print_in_purple "   Repositories\n\n"
    add_repos

    print_in_purple "\n   Miscellaneous\n\n"

    update
    upgrade
    printf "\n"
    install_apps
    printf "\n"
    autoremove

    print_in_purple "\n   Python packages\n\n"
    install_python_packages

    print_in_purple "\n   Atom packages\n\n"
    install_atom_packages
}

main
