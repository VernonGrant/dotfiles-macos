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

tmux-setup-vim-session "Home"                        "/Users/vernon/"
tmux-setup-vim-session "Notes"                       "${DEVENV_PATH}/notes/"
tmux-setup-vim-session "Projects"                    "${DEVENV_PATH}/projects/"

############################
# Current Project Sessions #
############################

tmux-setup-vim-session "Art-And-Piece"               "${DEVENV_PATH}/projects/art-and-piece/source/art-and-piece/"
tmux-setup-vim-session "Art-And-Piece-Digital-Books" "${DEVENV_PATH}/projects/art-and-piece-digital-books/source/aap-digital-books/"
tmux-setup-vim-session "Atelier-Noel"                "${DEVENV_PATH}/projects/atelier-noel/source/atelier-noel/"
tmux-setup-vim-session "C-Intro-And-Ref"             "${DEVENV_PATH}/projects/c-intro-and-ref/"
tmux-setup-vim-session "Christopher-Sin"             "${DEVENV_PATH}/projects/christopher-sin/source/"
tmux-setup-vim-session "Developer-Tips"              "${DEVENV_PATH}/projects/developer-tips/"
tmux-setup-vim-session "ECSAF"                       "${DEVENV_PATH}/projects/ecsaf/source/ecsaf-flex/"
tmux-setup-vim-session "Gloria-Yip"                  "${DEVENV_PATH}/projects/gloria-yip/source/gloria_yip/"
tmux-setup-vim-session "MIO-Cancercare"              "${DEVENV_PATH}/projects/mio-cancercare/source/cancer-care/"
tmux-setup-vim-session "MIO-Features-Plugin"         "${DEVENV_PATH}/projects/mio-features-plugin/source/mio-features"
tmux-setup-vim-session "MIO-Floating-Buttons"        "${DEVENV_PATH}/projects/mio-floating-buttons/source/mio-floating-buttons/"
tmux-setup-vim-session "MIO-Fungalnail"              "${DEVENV_PATH}/projects/mio-fungalnail/source/medic-in-one/"
tmux-setup-vim-session "MIO-Gyn"                     "${DEVENV_PATH}/projects/mio-gyn/source/pregnancy-child/"
tmux-setup-vim-session "MIO-Ibiomed"                 "${DEVENV_PATH}/projects/mio-ibiomed/source/allegiant/"
tmux-setup-vim-session "MIO-Kneepain"                "${DEVENV_PATH}/projects/mio-kneepain/source/medic-in-one/"
tmux-setup-vim-session "MIO-Papimi"                  "${DEVENV_PATH}/projects/mio-papimi/source/miopa-flex/"
tmux-setup-vim-session "MIO-Premierclinic"           "${DEVENV_PATH}/projects/mio-premierclinic/source/health-center-child/"
tmux-setup-vim-session "MIO-Retainership"            "${DEVENV_PATH}/projects/mio-retainership/"
tmux-setup-vim-session "MIO-Shopify-EvisHealth"      "${DEVENV_PATH}/projects/mio-shopify-evishealth/"
tmux-setup-vim-session "MIO-Tags"                    "${DEVENV_PATH}/projects/mio-tags/source/mio-tags/"
tmux-setup-vim-session "MIO-Tortuga-Enhancements"    "${DEVENV_PATH}/projects/mio-tortuga-enhancements/source/mio-tortuga-enhancements/"
tmux-setup-vim-session "MIO-Translate"               "${DEVENV_PATH}/projects/mio-translate/"
tmux-setup-vim-session "MIO-Urogyn"                  "${DEVENV_PATH}/projects/mio-urogyn/source/medic-in-one-clinic/"
tmux-setup-vim-session "MIO-Warts"                   "${DEVENV_PATH}/projects/mio-warts/source/medic-in-one/"
tmux-setup-vim-session "MIO-colonhealth"             "${DEVENV_PATH}/projects/mio-colonhealth/source/mioch_flex/"
tmux-setup-vim-session "Math-Diagrams"               "${DEVENV_PATH}/projects/math-via-diagrams/"
tmux-setup-vim-session "News-Clippings"              "${DEVENV_PATH}/projects/news-clippings/"
tmux-setup-vim-session "Ruppell-Flask"               "${DEVENV_PATH}/projects/ruppell-flask"
tmux-setup-vim-session "Ruppell-Flex"                "${DEVENV_PATH}/projects/ruppell-flex/source/ruppell-flex/"
tmux-setup-vim-session "Ruppell-Retainerships"       "${DEVENV_PATH}/projects/ruppell-retainerships/"
tmux-setup-vim-session "Seedland-Flex"               "${DEVENV_PATH}/projects/seedland-flex/source/seedland_flex/"
tmux-setup-vim-session "Seedland-Foundation-Symfony" "${DEVENV_PATH}/projects/seedland-foundation-symfony/source/"
tmux-setup-vim-session "Vernon-Grant"                "${DEVENV_PATH}/projects/vernon-grant/"
tmux-setup-vim-session "Volcano-Theme"               "${DEVENV_PATH}/projects/volcano-theme"
tmux-setup-vim-session "Yellow-Bus"                  "${DEVENV_PATH}/projects/yellow-bus/source/yellow-bus/"
