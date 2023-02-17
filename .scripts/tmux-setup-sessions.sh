#!/bin/bash

DEVENV_PATH="/Users/vernon/Devenv"

# -z, string, True if the length of string is zero.
# -n, string, True if the length of string is non-zero.

function tmux-setup-nvim-session() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Please supply the session name and path."
        return
    fi

    # We need to remove the carriage return.
    cd $2
    tmux new-session   -s $1 -d
    tmux send-keys     -t $1:0 'ls -la' Enter
    tmux new-window    -t $1:1 -n 'vim'
    tmux send-keys     -t $1:1 'nvim' Enter
    tmux send-keys     -t $1:1 ' e' Enter
    tmux select-window -t $1:1

    # We can check if there's a docker file available?
    cd -

    echo "Created session: $1"

    # Take some time to setup session.
    sleep 1
}

function tmux-setup-emacs-session() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Please supply the session name and path."
        return
    fi

    # We need to remove the carriage return.
    cd $2
    tmux new-session   -s $1 -d
    tmux send-keys     -t $1:0 'ls -la' Enter
    tmux new-window    -t $1:1 -n 'emacs'
    tmux send-keys     -t $1:1 'emacs -nw' Enter
    tmux send-keys     -t $1:1 C-x d Enter
    tmux select-window -t $1:1
    cd -

    echo "Created session: $1"

    # Take some time to setup session.
    sleep 1
}

####################
# General Sessions #
####################

tmux-setup-nvim-session "Home"                        "/Users/vernon/"
tmux-setup-nvim-session "Notes"                       "${DEVENV_PATH}/notes/"
tmux-setup-nvim-session "Projects"                    "${DEVENV_PATH}/projects/"

############################
# Current Project Sessions #
############################

tmux-setup-nvim-session "Art-And-Piece"               "${DEVENV_PATH}/projects/art-and-piece/source/art-and-piece/"
tmux-setup-nvim-session "Art-And-Piece-Digital-Books" "${DEVENV_PATH}/projects/art-and-piece-digital-books/source/aap-digital-books/"
tmux-setup-nvim-session "Atelier-Noel"                "${DEVENV_PATH}/projects/atelier-noel/source/atelier-noel/"
tmux-setup-nvim-session "C-Intro-And-Ref"             "${DEVENV_PATH}/projects/c-intro-and-ref/"
tmux-setup-nvim-session "Christopher-Sin"             "${DEVENV_PATH}/projects/christopher-sin/source/"
tmux-setup-nvim-session "Discovering Emacs"           "${DEVENV_PATH}/projects/discovering-emacs/"
tmux-setup-nvim-session "ECSAF"                       "${DEVENV_PATH}/projects/ecsaf/source/ecsaf-flex/"
tmux-setup-nvim-session "Emacs Keyboard Shortcuts"    "${DEVENV_PATH}/projects/emacs-keyboard-shortcuts/"
tmux-setup-nvim-session "Gloria-Yip"                  "${DEVENV_PATH}/projects/gloria-yip/source/gloria_yip/"
tmux-setup-nvim-session "MIO-Cancercare"              "${DEVENV_PATH}/projects/mio-cancercare/source/cancer-care/"
tmux-setup-nvim-session "MIO-Features-Plugin"         "${DEVENV_PATH}/projects/mio-features-plugin/source/mio-features"
tmux-setup-nvim-session "MIO-Floating-Buttons"        "${DEVENV_PATH}/projects/mio-floating-buttons/source/mio-floating-buttons/"
tmux-setup-nvim-session "MIO-Fungalnail"              "${DEVENV_PATH}/projects/mio-fungalnail/source/medic-in-one/"
tmux-setup-nvim-session "MIO-Gyn"                     "${DEVENV_PATH}/projects/mio-gyn/source/pregnancy-child/"
tmux-setup-nvim-session "MIO-Ibiomed"                 "${DEVENV_PATH}/projects/mio-ibiomed/source/allegiant/"
tmux-setup-nvim-session "MIO-Kneepain"                "${DEVENV_PATH}/projects/mio-kneepain/source/medic-in-one/"
tmux-setup-nvim-session "MIO-Papimi"                  "${DEVENV_PATH}/projects/mio-papimi/source/miopa-flex/"
tmux-setup-nvim-session "MIO-Premierclinic"           "${DEVENV_PATH}/projects/mio-premierclinic/source/health-center-child/"
tmux-setup-nvim-session "MIO-Retainership"            "${DEVENV_PATH}/projects/mio-retainership/"
tmux-setup-nvim-session "MIO-Shopify-EvisHealth"      "${DEVENV_PATH}/projects/mio-shopify-evishealth/"
tmux-setup-nvim-session "MIO-Tags"                    "${DEVENV_PATH}/projects/mio-tags/source/mio-tags/"
tmux-setup-nvim-session "MIO-Tortuga-Enhancements"    "${DEVENV_PATH}/projects/mio-tortuga-enhancements/source/mio-tortuga-enhancements/"
tmux-setup-nvim-session "MIO-Translate"               "${DEVENV_PATH}/projects/mio-translate/"
tmux-setup-nvim-session "MIO-Urogyn"                  "${DEVENV_PATH}/projects/mio-urogyn/source/medic-in-one-clinic/"
tmux-setup-nvim-session "MIO-Warts"                   "${DEVENV_PATH}/projects/mio-warts/source/medic-in-one/"
tmux-setup-nvim-session "MIO-colonhealth"             "${DEVENV_PATH}/projects/mio-colonhealth/source/mioch_flex/"
tmux-setup-nvim-session "Math-Diagrams"               "${DEVENV_PATH}/projects/math-via-diagrams/"
tmux-setup-nvim-session "News-Clippings"              "${DEVENV_PATH}/projects/news-clippings/"
tmux-setup-nvim-session "Ruppell-Flask"               "${DEVENV_PATH}/projects/ruppell-flask"
tmux-setup-nvim-session "Ruppell-Flex"                "${DEVENV_PATH}/projects/ruppell-flex/source/ruppell-flex/"
tmux-setup-nvim-session "Ruppell-Retainerships"       "${DEVENV_PATH}/projects/ruppell-retainerships/"
tmux-setup-nvim-session "Seedland-Flex"               "${DEVENV_PATH}/projects/seedland-flex/source/seedland_flex/"
tmux-setup-nvim-session "Seedland-Foundation-Symfony" "${DEVENV_PATH}/projects/seedland-foundation-symfony/source/"
tmux-setup-nvim-session "Vernon-Grant"                "${DEVENV_PATH}/projects/vernon-grant/"
tmux-setup-nvim-session "Volcano-Theme"               "${DEVENV_PATH}/projects/volcano-theme"
tmux-setup-nvim-session "Yellow-Bus"                  "${DEVENV_PATH}/projects/yellow-bus/source/yellow-bus/"
