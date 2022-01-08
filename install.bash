#!/bin/bash

### Information ###
# This script deploys all dot files and installs all the following dependencies:
#   - curl
#   - zsh
#   - powerlevel10k
#   - ripgrep
#   - neovim
#   - bat
#   - exa
#
# Additional dependencies per operating system:
#   + MacOs (Darwin)
#       - homebrew
#
# By default this script backs up any existing files it has to overwrite to
#
#   ~/dot-files-backup-%+s
#
# Where %+s is seconds since unix epoch
### Information ###

### CONSTANTS AND GLOBALS ###
# These are variables used globally or are statically assigned for use
# later
### CONSTANTS AND GLOBALS ###

PKG_MANAGER="${1}"

PKG_MANAGER_DEPS=(
    git
    zsh
    curl
)

### Utilities ###
# These functions assist with basic lookups and reused
# functionality
### Utilities ###

determine_os() {
    # Determine the operating system or distribution if on linux.
    #
    # Sets the package manager accordingly and installs missing package managers
    # if necessary.

    # Initial detection for MacOS
    if [[ "${OSTYPE}" = "*darwin*" ]]; then
        log "info" "Detected distribution as $(important "MacOS")"
        PKG_MANAGER="brew install"
        if ! which "${PKG_MANAGER}" >/dev/null 2>&1; then
            log "info" "Installing homebrew for MacOS"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    else
        local etc_release
        local distribution
        etc_release="/etc/os-release"

        # Detect if os-release exists
        if [[ ! -f "${etc_release}" ]]; then
            log "error" "Could not find $(important "${etc_release}"), this system is unsupported..."
            return 1
        fi

        distribution="$(grep -i "^NAME=" "${etc_release}" | cut -d '"' -f 2 | tr "[:upper:]" "[:lower:]")"

        case "${distribution}" in
        *centos*)
            log "info" "Detected distribution as $(important "CentOS")"
            if which dnf >/dev/null 2>&1; then
                PKG_MANAGER="dnf install -y"
            else
                PKG_MANAGER="yum install -y"
            fi
            ;;
        *ubuntu*)
            log "info" "Detected distribution as $(important "Ubuntu")"
            PKG_MANAGER="apt install -y"
            ;;

        *)
            log "error" "Unable to determine distribution"
            return 1
            ;;
        esac

    fi
}

main() {
    ### Initial Lookups ###
    # This region is used to determine the OS,
    # what package manager is available, and
    # other useful information
    ### Initial Lookups ###
    if [[ -z "${PKG_MANAGER}" ]]; then
        log "info" "No package manager provided at command line, attempting to detect..."
        determine_os || exit "${?}"
    fi

    # Failover catch in case something doesn't get put through correctly
    if ! which "${PKG_MANAGER}" >/dev/null 2>&1; then
        log "error" "Unable to find a package manager!" && return 1
    fi

    log "info" "Package manager detected as $(important "${PKG_MANAGER}")"

    ### ZSH Installation ###
    # This does NOT configure your shell to be zsh
    # In order to set your shell to zsh use chsh:
    #
    #   chsh -s zsh
    #
    ### ZSH Installation ###

    # Package Manager Installations, things from the given package manager, e.g. yum
    for pkg in "${PKG_MANAGER_DEPS[@]}"; do
        if ! which "${pkg}" >/dev/null 2>&1; then
            log "info" "Installing package dependency $(important "${pkg}")"
            if ! "${PKG_MANAGER}" "${pkg}"; then
                log "error" "Unable to install $(important "${pkg}")"
                return 2
            fi
        fi
    done

    log "info" "Installing $(important "oh-my-zsh")"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log "info" "Installing $(important "powerlevel10k")"
}
