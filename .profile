#!/bin/bash

# shellcheck source=./.zstyle
source ~/.zstyle

. "$HOME/.cargo/env"

### Pathing ###

export PATH="${HOME}/.bin:${PATH}"
export PATH="${PATH}:/opt/homebrew/Cellar/llvm/13.0.0_2/bin"

# Mac pathing beneath
if [[ "${OSTYPE}" = "darwn"* ]]; then
    export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"
    export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:${MANPATH}"
fi

### OPTS ###
setopt extendedglob

### Environment Variables ###

export LANG=en_US.UTF-8
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_CLI_AUTO_PROMPT=on
export ZSH_HIGHLIGHT_MAXLENGTH=10000
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=2
export LANG=en_US.UTF-8

if which nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL=nvim
else
    export EDITOR=vim
    export VISUAL=vim
fi

### Terminal Specific Configuration ###
# If using the kitty terminal we want to set our TERM var to be xterm as kitty will send
# kitty-xterm which causes a fucking headache and a half due to ncurses not containing
# that by default
if [[ "${TERM}" = *"xterm-kitty"* ]]; then
    alias ssh="TERM=xterm ssh"
    __kitty_complete
fi

### Zsh Vi-Mode Configuration ###

# Makes the cursor change based on the mode
export VI_MODE_SET_CURSOR=true
# Set the editor to neovim for visual mode
export ZVM_VI_EDITOR="${EDITOR}"
# This ensures that fzf completion works
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

### Aliases ###

## Exa ls Replacement Configuration ##
if which exa >/dev/null 2>&1; then
    alias ls="exa --icons --group"
    alias l="exa --icons --group -alh"
    alias tree="ls --tree"
fi

## Git Aliases ##
if which git >/dev/null 2>&1; then
    alias gc="git commit -m"
    alias ga="git add"
    alias gp="git push"
    alias gb="git branch"
    alias gco="git checkout"
    alias gpl="git pull"
    alias gs="git status"
    alias gd="git diff"
    alias gr="git remote"
    alias git-remote="git config --get remote.origin.url"
fi

## Mac Specific Aliases ##
if [[ "${OSTYPE}" = "darwin"* ]]; then
    alias c="pbcopy"
    alias p="pbpaste"
    alias grep="ggrep"
    alias find="gfind"
    alias kill="gkill"
fi

## Python Aliases ##
if which python3.10 >/dev/null 2>&1; then
    alias python3="python3.10"
fi

## Neovim Aliases ##
if which nvim >/dev/null 2>&1; then
    alias n="nvim"
    alias :profile="nvim ~/.profile"
fi

## Bat (Alternative to Cat) Aliases ##
if which bat >/dev/null 2>&1; then
    alias cat="bat"
fi

## Misc Aliases ##
alias btop="bpytop"
alias ghidra="ghidraRun"
alias v="vim"
alias :q="exit"
alias Get-Public-IPV4="dig @resolver4.opendns.com myip.opendns.com +short -4"
alias Get-Public-IPV6="dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6"

### Completions ###

# Homebrew completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
fi

### Functions ###

TCPDump-Capture() {
    tcpdump -qns 0 -X -r "${1}"
}

Known-Hosts() {
    local prev_ifs
    prev_ifs="${IFS}"
    while IFS=$'\n' read -r line; do
        echo "${line}" | cut -d " " -f1
    done <~/.ssh/known_hosts
    IFS="${prev_ifs}"
}

Work-Hours() {
    local WORK_HOURS_PATH
    WORK_HOURS_PATH=~/Vircio/Work-Hours
    mkdir -p "${WORK_HOURS_PATH}"
    ${EDITOR} "${WORK_HOURS_PATH}/$(date +%Y-%m-%d)"
}

date_iso_8601() {
    date +%Y-%m-%dT%H:%M:%S
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

chr() {
    python3 -c "print(chr(int('${1}')))"
}

ord() {
    python3 -c "print(ord('${1}'))"
}