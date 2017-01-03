#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"

execute "gsettings set com.canonical.indicator.bluetooth visible false" \
    "Hide bluetooth icon from the menu bar"

execute "gsettings set com.canonical.indicator.sound visible false" \
    "Hide volume icon from the menu bar"

execute "gsettings set com.canonical.indicator.power icon-policy 'charge' && \
         gsettings set com.canonical.indicator.power show-time false" \
    "Hide battery icon from the menu bar when the battery is not in use"

execute "gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p' && \
         gsettings set com.canonical.indicator.datetime time-format 'custom'" \
    "Use custom date format in the menu bar"

execute "gsettings set org.gnome.desktop.background picture-options 'stretched'" \
    "Set desktop background image options"

execute "gsettings set org.gnome.libgnomekbd.keyboard layouts \"[ 'es' ]\"" \
    "Set keyboard languages"

execute "gsettings set com.canonical.Unity.Launcher favorites \"[
            'nautilus-home.desktop',
			'google-chrome-stable.desktop',
			'firefox.desktop',
			'atom.desktop',
			'org.gnome.Terminal.desktop',
			'unity-control-center.desktop'
         ]\"" \
    "Set Launcher favorites"

# http://askubuntu.com/questions/260510/how-do-i-turn-on-workspaces-why-do-i-only-have-one-workspace
execute "gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2 && \
         gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2" \
    "Enable workspaces"
