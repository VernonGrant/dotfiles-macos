#!/bin/bash

DEVENV_PATH="/Users/vernon/Devenv"

# -z, string, True if the length of string is zero.
# -n, string, True if the length of string is non-zero.

function tmux-setup-session() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Please supply the session name and path."
        return
    fi

    # We need to remove the carriage return.
    cd $2
    tmux new-session   -s $1 -d
    tmux send-keys     -t $1:0 'ls -la' C-m
    tmux new-window    -t $1:1 -n 'vim'
    tmux send-keys     -t $1:1 'nvim' C-m
    tmux send-keys     -t $1:1 ' e' C-m
    tmux select-window -t $1:1

    # We can check if there's a docker file available?
    cd -

    echo "Created session: $1"

    # Take some time to setup session.
    sleep 1.00s
}

####################
# General Sessions #
####################

tmux-setup-session "Home"                        "/Users/vernon/"
tmux-setup-session "Notes"                       "${DEVENV_PATH}/notes/"
tmux-setup-session "Projects"                    "${DEVENV_PATH}/projects/"

############################
# Current Project Sessions #
############################

tmux-setup-session "Art-And-Piece"               "${DEVENV_PATH}/projects/art-and-piece/source/art-and-piece/"
tmux-setup-session "Art-And-Piece-Digital-Books" "${DEVENV_PATH}/projects/art-and-piece-digital-books/source/aap-digital-books/"
tmux-setup-session "Atelier-Noel"                "${DEVENV_PATH}/projects/atelier-noel/source/atelier-noel/"
tmux-setup-session "C-Intro-And-Ref"             "${DEVENV_PATH}/projects/c-intro-and-ref/"
tmux-setup-session "Christopher-Sin"             "${DEVENV_PATH}/projects/christopher-sin/source/"
tmux-setup-session "Developer-Tips"              "${DEVENV_PATH}/projects/developer-tips/"
tmux-setup-session "ECSAF"                       "${DEVENV_PATH}/projects/ecsaf/source/ecsaf-flex/"
tmux-setup-session "Gloria-Yip"                  "${DEVENV_PATH}/projects/gloria-yip/source/gloria_yip/"
tmux-setup-session "MIO-Cancercare"              "${DEVENV_PATH}/projects/mio-cancercare/source/cancer-care/"
tmux-setup-session "MIO-Features-Plugin"         "${DEVENV_PATH}/projects/mio-features-plugin/source/mio-features"
tmux-setup-session "MIO-Floating-Buttons"        "${DEVENV_PATH}/projects/mio-floating-buttons/source/mio-floating-buttons/"
tmux-setup-session "MIO-Fungalnail"              "${DEVENV_PATH}/projects/mio-fungalnail/source/medic-in-one/"
tmux-setup-session "MIO-Gyn"                     "${DEVENV_PATH}/projects/mio-gyn/source/pregnancy-child/"
tmux-setup-session "MIO-Ibiomed"                 "${DEVENV_PATH}/projects/mio-ibiomed/source/allegiant/"
tmux-setup-session "MIO-Kneepain"                "${DEVENV_PATH}/projects/mio-kneepain/source/medic-in-one/"
tmux-setup-session "MIO-Papimi"                  "${DEVENV_PATH}/projects/mio-papimi/source/miopa-flex/"
tmux-setup-session "MIO-Premierclinic"           "${DEVENV_PATH}/projects/mio-premierclinic/source/health-center-child/"
tmux-setup-session "MIO-Retainership"            "${DEVENV_PATH}/projects/mio-retainership/"
tmux-setup-session "MIO-Shopify-EvisHealth"      "${DEVENV_PATH}/projects/mio-shopify-evishealth/"
tmux-setup-session "MIO-Tags"                    "${DEVENV_PATH}/projects/mio-tags/source/mio-tags/"
tmux-setup-session "MIO-Tortuga-Enhancements"    "${DEVENV_PATH}/projects/mio-tortuga-enhancements/source/mio-tortuga-enhancements/"
tmux-setup-session "MIO-Translate"               "${DEVENV_PATH}/projects/mio-translate/"
tmux-setup-session "MIO-Urogyn"                  "${DEVENV_PATH}/projects/mio-urogyn/source/medic-in-one-clinic/"
tmux-setup-session "MIO-Warts"                   "${DEVENV_PATH}/projects/mio-warts/source/medic-in-one/"
tmux-setup-session "MIO-colonhealth"             "${DEVENV_PATH}/projects/mio-colonhealth/source/mioch_flex/"
tmux-setup-session "Math-Diagrams"               "${DEVENV_PATH}/projects/math-via-diagrams/"
tmux-setup-session "News-Clippings"              "${DEVENV_PATH}/projects/news-clippings/"
tmux-setup-session "Ruppell-Flask"               "${DEVENV_PATH}/projects/ruppell-flask"
tmux-setup-session "Ruppell-Flex"                "${DEVENV_PATH}/projects/ruppell-flex/source/ruppell-flex/"
tmux-setup-session "Ruppell-Retainerships"       "${DEVENV_PATH}/projects/ruppell-retainerships/"
tmux-setup-session "Seedland-Flex"               "${DEVENV_PATH}/projects/seedland-flex/source/seedland_flex/"
tmux-setup-session "Seedland-Foundation-Symfony" "${DEVENV_PATH}/projects/seedland-foundation-symfony/source/"
tmux-setup-session "Vernon-Grant"                "${DEVENV_PATH}/projects/vernon-grant/"
tmux-setup-session "Volcano-Vim"                 "${DEVENV_PATH}/projects/volcano-vim"
tmux-setup-session "Yellow-Bus"                  "${DEVENV_PATH}/projects/yellow-bus/source/yellow-bus/"
