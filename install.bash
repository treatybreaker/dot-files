#!/bin/bash

# Exit on error
set -euo pipefail

### Information ###
# This script deploys all dot files and installs all the following dependencies:
#   - curl
#   - python3
#   - rust
#   - zsh
#   - ripgrep
#   - bat
#   - fzf
#   - exa
#   - neovim
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

SCRIPT_DEPENDENCIES=(
    zsh
    gcc
    git
    curl
)

GIT_REPOSITORY="https://gitlab.orion-technologies.io/philler/dot-files.git"
PKG_MANAGER="${1}"

OLD_DOT_FILES_BACKUP="dot-files-backup-$(date "+%s")"

### Utilities ###
# These functions assist with basic lookups and reused
# functionality
### Utilities ###

check_sudo() {
    sudo -v >/dev/null 2>&1
    return "${?}"

}

echo_rgb() {
    # Echo a colored string to the terminal based on rgb values
    #
    # NOTE: This function will only truly work with terminals that support TRUE COLOR, see:
    #   https://gist.github.com/XVilka/8346728
    #
    # Positional Arguments:
    #
    #   message <type: string> <position: 1> <required: true>
    #     - The message to be printed to stdout
    #   red <type: int> <position: 2> <required: true>
    #     - The red value from 0 to 255
    #   green <type: int> <position: 3> <required: true>
    #     - The green value from 0 to 255
    #   blue <type: int> <position: 4> <required: true>
    #     - The blue value from 0 to 255
    #   bg_red <type: int> <position: 5> <required: false>
    #     - The background red value from 0 to 255
    #   bg_green <type: int> <position: 6> <required: false>
    #     - The background green value from 0 to 255
    #   bg_blue <type: int> <position: 7> <required: false>
    #     - The background blue value from 0 to 255
    #
    # Usage:
    #   echo_rgb "Yep" 10 80 30
    #   echo_rgb "DESTROY MY EYES" 255 0 255  0 255 0
    #
    # POSIX Compliant:
    #   N/A
    #

    local red
    local green
    local blue
    local input

    local bg_red
    local bg_green
    local bg_blue

    input="${1}"
    red="${2}"
    green="${3}"
    blue="${4}"
    bg_red="${5}"
    bg_green="${6}"
    bg_blue="${7}"

    for num in "${@:2}"; do
        [[ ! "${num}" =~ [0-9] ]] &&
            echo "Given RGB value was not a number, received ${num}" >&2 &&
            return 1
        [[ "${num}" -gt 255 ]] &&
            echo "Given RGB value must be less than 255, received ${num}" >&2 &&
            return 1
        [[ "${num}" -lt 0 ]] &&
            echo "Given RGB value must be more than 0, received ${num}" &&
            return 1
    done

    if [ -n "${5}" ]; then
        [[ -z "${6}" ]] && echo "A value must be passed for bg_green" && return 1
        [[ -z "${7}" ]] && echo "A value must be passed for bg_blue" && return 1
        printf "\033[38;2;%s;%s;%s;48;2;%s;%s;%sm%s\033[m\n" \
            "${red}" "${green}" "${blue}" "${bg_red}" "${bg_green}" "${bg_blue}" "${input}"
    else
        printf "\033[0;38;2;%s;%s;%sm%s\033[m\n" "${red}" "${green}" "${blue}" "${input}"
    fi
    return 0
}

important() {
    echo_rgb "${1}" 0 220 255
}

log() {
    # Print a message and send it to stdout or stderr depending upon log level, also configurable with debug etc.
    #
    # Arguments:
    #   level <type: string> <position: 1> <required: true>
    #     - The log level, defined within a case check in this function
    #   message <type: string> <position: 2> <required: true>
    #     - The info message
    #   line_number <type: int> <position: 3> <required: false>
    #     - The line number of the calling function (${LINNO})
    #
    # Usage:
    #   log "info" "Could not find that directory"
    #
    # POSIX Compliant:
    #   Yes
    #

    # Set debug status depending if a global debug variable has been set to either 1 or 0
    local debug
    if [ ${DEBUG} ]; then
        debug=${DEBUG}
    else
        debug=0
    fi

    local FORMAT
    FORMAT="[$(echo_rgb "$(date +%Y-%m-%dT%H:%M:%S)" 180 140 255)]"

    # Convert the level to uppercase
    local level
    level=$(echo "${1}" | tr '[:lower:]' '[:upper:]')

    local message
    message="${2}"

    case "${level}" in
    INFO)
        # Output all info log levels to stdout
        printf "${FORMAT}[$(echo_rgb "INFO" 0 140 255)] %s\n" "${message}" >&1
        return 0
        ;;
    WARN | WARNING)
        # Output all warning log levels to stdout
        printf "${FORMAT}[$(echo_rgb "WARNING" 255 255 0)] %s\n" "${message}" >&1
        return 0
        ;;
    DEBUG)
        # Output all debug log levels to stdout
        if [ "${DEBUG}" ]; then
            printf "${FORMAT}[$(echo_rgb "DEBUG" 0 160 110)] %s\n" "${message}" >&1
        fi
        return 0
        ;;
    ERROR)
        # Output all error log levels to stderr
        printf "${FORMAT}[$(echo_rgb "ERROR" 255 0 0)] %s\n" "${message}" >&2
        return 0
        ;;
    # Further log levels can be added by extending this switch statement with more comparisons

    *) # Default case, no matches
        # Returns non-zero code as an improper log option was passed, this helps with using `set -e`
        printf "${FORMAT}[ERROR] %s\n" "Invalid log level passed, received level \"${level}\" with message \"${message}\"" >&2
        return 1
        ;;
    esac
}

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
            SCRIPT_DEPENDENCIES+=(python39.x86_64 gcc-c++.x86_64)
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

install_dependencies() {
    if [[ -z "${PKG_MANAGER}" ]]; then
        log "info" "No package manager provided at command line, attempting to detect..."
        determine_os || return 1
    fi

    # Failover catch in case something doesn't get put through correctly
    if ! which "$(echo "${PKG_MANAGER}" | cut -d " " -f1)" >/dev/null 2>&1; then
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

    local install_str
    for pkg in "${SCRIPT_DEPENDENCIES[@]}"; do
        if ! which "${pkg}" >/dev/null 2>&1; then
            log "info" "Installing package dependency $(important "${pkg}")"

            if [[ "${OSTYPE}" = *"darwin"* ]]; then
                install_str="${PKG_MANAGER} ${pkg}"
            else
                install_str="sudo ${PKG_MANAGER} ${pkg}"
            fi

            if ! eval "${install_str}"; then
                log "error" "Unable to install $(important "${pkg}")"
                return 1
            fi
        fi
    done
}

check_script_dependencies() {
    for dep in "${SCRIPT_DEPENDENCIES[@]}"; do
        if ! which "${dep}" >/dev/null 2>&1; then
            log "error" "Script dependency $(important "${dep}") could not be located, contact your local administrator to install this dependency"
        fi
    done
}

install_source_sudo() {
    local program_path
    program_path="${1}"

    local program_name
    program_name="$(basename "${program_path}")"

    local install_dir
    install_dir="${2:-/usr/bin}"

    if check_sudo; then
        log "info" "Sudo access detected, copying $(important "${program_name}") to $(important "${install_dir}/${program_name}")"
        sudo cp "${program_path}" "${install_dir}"
        sudo chown "root:root" "/${install_dir}/${program_name}"
        sudo chmod 751 "/${install_dir}/${program_name}"
    fi
}

source_installer() {
    local cargo_path
    cargo_path="${HOME}/.cargo/"

    local cargo_bin
    cargo_bin="${cargo_path}/bin/"

    log "info" "Installing $(important "rust")"
    bash <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y
    source "${cargo_path}/env"

    log "info" "Installing $(important "ripgrep") from cargo"
    cargo install --locked ripgrep
    install_source_sudo "${cargo_bin}/rg"

    log "info" "Installing $(important "bat") from cargo"
    cargo install --locked bat
    install_source_sudo "${cargo_bin}/bat"

    log "info" "Installing $(important "fzf") from git"
    mv "${HOME}/.fzf" "${OLD_DOT_FILES_BACKUP}" 2>/dev/null
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    eval ~/.fzf/install --all

    log "info" "Installing $(important "exa")"
    cargo install --locked exa
    install_source_sudo "${cargo_bin}/exa"

    log "info" "Installing $(important "neovim")"
    if [[ "${OSTYPE}" = *"darwin"* ]]; then
        eval "${PKG_MANAGER} neovim"
    else
        local nvim_url
        nvim_url="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
        curl -LO "${nvim_url}" --output nvim.appimage
        chmod u+x nvim.appimage
        ./nvim.appimage --appimage-extract
        if sudo -v >/dev/null 2>&1; then
            sudo chown -R "root:root" "squashfs-root"
            sudo rsync -a "./squashfs-root/usr/" "/usr/"
            sudo rm -rf "./squashfs-root/"
        else
            log "warning" "Unable to add neovim to path from $(important "${squashfs-root}"), did not have sudo permissions"
        fi
    fi


    log "info" "Installing $(important "oh-my-zsh")"
    if [[ -d "${HOME}/.oh-my-zsh/" ]]; then
        log "info" "Found a previous oh-my-zsh installation, backing up to $(important "${OLD_DOT_FILES_BACKUP}")"
        mv "${HOME}/.oh-my-zsh" "${OLD_DOT_FILES_BACKUP}"
    fi

    # Set zsh to empty to handle pathing issues
    export ZSH=""
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

main() {
    cd "${HOME}"
    log "info" "Installing dependencies"
    if check_sudo; then
        log "info" "Sudo access found, installing dependencies"
        if ! install_dependencies; then
            log "error" "Unable to install dependencies"
            return 1
        fi
    else
        if ! check_script_dependencies; then
            log "error" "Unable to find required script dependencies"
            return 1
        fi
    fi

    if ! source_installer; then
        log "error" "Failed to install some dependencies from source"
        return 1
    fi


    local dot_files_temp
    dot_files_temp="dot-files-$(date "+%s")"

    log "info" "Cloning $(important "dot files") from $(important "https://gitlab.orion-technologies.io/philler/dot-files.git") to $(important "${dot_files_temp}")"

    mkdir -p "${OLD_DOT_FILES_BACKUP}"

    git clone --recurse-submodules "${GIT_REPOSITORY}" "${dot_files_temp}" && cd "${dot_files_temp}"

    log "info" "Installing $(important "dot files")"

    local dot_base
    local dot_home

    local exclusion_dirs
    exclusion_dirs=(
        ".."
        "."
        "install.bash"
        ".git"
        ".gitignore"
        ".gitmodules"
    )
    for dot_file in {,.}*; do
        if [[ "${exclusion_dirs[*]}" =~ "${dot_file}" ]]; then
            continue
        fi

        dot_base="$(basename "${dot_file}")"
        dot_home="${HOME}/${dot_base}"
        if dir "${dot_home}" >/dev/null 2>&1; then
            log "info" "Found existing dot file: $(important "${dot_home}"), moving to $(important "${OLD_DOT_FILES_BACKUP}/${dot_base}")"
            mv "${dot_home}" "${OLD_DOT_FILES_BACKUP}"
        fi
        log "info" "Installing dot file $(important "${dot_file}") to $(important "${dot_home}")"
        mv "${dot_file}" "${dot_home}"
    done

    log "info" "Cleaning up..."
    rm -rf "${dot_files_temp}"

    log "info" "Finished, don't forget to change your shell to zsh: $(important "chsh -s zsh")"
}

main
