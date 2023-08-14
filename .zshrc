# vim: fdm=marker
#                  ██     
#                 ░██     
#   ██████  ██████░██     
#  ░░░░██  ██░░░░ ░██████ 
#     ██  ░░█████ ░██░░░██
#    ██    ░░░░░██░██  ░██
#   ██████ ██████ ░██  ░██
#  ░░░░░░ ░░░░░░  ░░   ░░ 
#
#  ~/.zsh-fzf
#  ~/.zsh-local
#
#  Might wanna add `export XDG_CURRENT_DESKTOP=GNOME` to /etc/profile on fresh installs
#  TODO: Install LMOD automatically if it doesn't exist
#  https://ianthehenry.com/posts/zsh-autoquoter/

stty -ixon                                                       # Disables ctrl-s/ctrl-q

ARCH=$(uname -a | awk '{print $(NF-1)}')

# autoload -U +X bashcompinit && bashcompinit
# # NOTE: Uncomment in case compaudit complains of insecure directories
# # Probably best to unset FPATH in bash before calling zsh in case of a nested call
# autoload -U +X compinit && compinit -i
# autoload -Uz compinit; compinit


# Package Manager: {{{

# ZINIT: {{{
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

zinit lucid for \
     wait"0b" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" @zdharma-continuum/fast-syntax-highlighting \
     wait"0b" blockf @zsh-users/zsh-completions \
     wait"0a" atload"!_zsh_autosuggest_start" @zsh-users/zsh-autosuggestions

zinit lucid for \
    OMZL::functions.zsh  \
    OMZL::directories.zsh  \
    OMZL::termsupport.zsh \
    OMZL::completion.zsh \
    OMZP::git

zinit snippet https://raw.githubusercontent.com/soheilpro/zsh-vi-search/master/src/zsh-vi-search.zsh

# CATPPUCCIN
zinit snippet https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# TODO: 
# OMZP::git-extras

# Theme and Colors {{{
zinit light-mode for pick"async.zsh" src"pure.zsh" @sindresorhus/pure

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit light-mode for atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!' @trapd00r/LS_COLORS
zinit light chrissicool/zsh-256color
zinit light-mode for atclone"dircolors -b src/dir_colors > c.zsh" \
            atpull'%atclone' \
            pick"c.zsh" \
            nocompile'!' \
            @arcticicestudio/nord-dircolors
# }}}

# Install fzf and related completion tools
# wait"0c" as"command" id-as"junegunn/fzf-tmux" pick"bin/fzf-tmux" @junegunn/fzf \
zinit lucid light-mode for \
    wait"0c" multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null" @junegunn/fzf \
    atload"zicompinit;zicdreplay" @Aloxaf/fzf-tab

zinit wait"1" lucid light-mode for @chisui/zsh-nix-shell

## Conditionally install regularly used tools if not found
zinit from"gh-r" as"command" light-mode for \
    if'[[ -z "$commands[fzf]" ]]' @junegunn/fzf \
    if'[[ -z "$commands[nvim]" ]]' mv"nvim*->nvim" pick"nvim/bin/nvim" @neovim/neovim \
    if'[[ -z "$commands[rg]" ]]' mv"ripgrep*->ripgrep" pick"ripgrep/rg" @BurntSushi/ripgrep \
    if'[[ -z "$commands[fd]" ]]' mv"fd*->fd" pick"fd/fd" @sharkdp/fd \
    if'[[ -z "$commands[nnn]" ]]' bpick"nnn-static*" mv"nnn*->nnn" @jarun/nnn \
    if'[[ -z "$commands[gh]" ]]' mv"gh*->gh" pick"gh/bin/gh" @cli/cli \
    if'[[ -z "$commands[btop]" ]]' pick"btop/bin/btop" @aristocratos/btop \
    if'[[ -z "$commands[lazygit]" ]]' mv"lazygit*->lazygit" pick"lazygit" @jesseduffield/lazygit 

# Load scripts directly from repo
zinit from"gh" as"command" light-mode for \
    if'[[ -z "$commands[cb]" ]]' pick"cb" @niedzielski/cb \

# mv"tmux*->tmux" atclone"cd tmux && ./configure && make" atpull"%atclone" pick"tmux/tmux" @tmux/tmux

# }}}

# Package Manager: }}}

# # Autocompletion for some scripts: moved to zcl
# # autoload -Uz compinit; compinit
# compdef '_files -W $NOTES_DIR' note
# compdef '_files -W $NOTES_DIR' notes
# compdef '_files -W $HOME/bin' se

# Bindkeys: {{{
# Allow v to edit the command line
bindkey -v                                                       # vim mode in shell 
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

bindkey '  ' autosuggest-accept
bindkey '^ ' autosuggest-clear
bindkey '^ ' kill-line
bindkey '^s' vi-forward-blank-word
# bindkey '^v' vi-backward-blank-word
bindkey '^p' up-history
bindkey '^n' down-history

bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
bindkey '^[[Z' reverse-menu-complete                             # shift-tab reverse selection direction


## Bindkeys: }}}

# setopts: {{{

setopt MENU_COMPLETE
setopt promptsubst

setopt BANG_HIST                 # Don't treat '!' specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt APPEND_HISTORY            # Appends history to history file on exit
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

## Directories
DIRSTACKSIZE=9
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt GLOB_DOTS
unsetopt AUTO_NAME_DIRS     # Don't add variable-stored paths to ~ list




## Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

# setopts: }}}

# Basics:{{{

function! prependToEnv()
{
    case ":$(printenv $1):" in
        *":$2:"*) :;; # already there
        *) export $1="$2:$(printenv $1)";;
    esac
}

function! appendToEnv()
{
    case ":$(printenv $1):" in
        *":$2:"*) :;; # already there
        *) export $1="$(printenv $1):$2";; 
    esac
}

[ -f ~/.zsh-local ] && source ~/.zsh-local
[ -f ~/.zsh-fzf ] && source ~/.zsh-fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#}}}

# zstyle completions: {{{

# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o'
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.o'

zstyle '*' single-ignored complete
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
  max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# Have the completion system announce what it is completing
# zstyle ':completion:*' format 'Completing %d'
# In menu-style completion, give a status bar
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# zstyle ':completion:*:descriptions' format '-- %d --'
# zstyle ':completion:*:processes' command 'ps -au$USER'
# zstyle ':completion:complete:*:options' sort false
# zstyle ':fzf-tab:complete:_zlua:*' query-string input
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
# zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# }}}

# Exports: {{{

ZSH_TMUX_AUTOCONNECT=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100000
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=120000  # Larger than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work
SAVEHIST=100000
LISTMAX=9999    # In the line editor, number of matches to show before asking permission

DISABLE_UNTRACKED_FILES_DIRTY="true"

[[ -n $(infocmp xterm-256color-italic 2>/dev/null) ]] && export TERM="xterm-256color-italic"
export LESS="-iR"

export NNN_FIFO=/tmp/nnn.fifo 
export NNN_OPTS="exaAE"
export NNN_COLORS="2136" ## Different colors for contexts 
export NNN_PLUG='g:getplugs;c:fuznavconf;f:fuznav;i:imgview;d:fuznavdir;j:jump;a:autojump;x:-!&xdg-open $nnn*;X:xdgdefault;p:!ptd -m "$nnn"*;r:!frifle "$nnn"*;s:fuznavsubdir'
export LC_COLLATE="C" ## dot files clumped together

## Exports: }}}

command -v nvim >/dev/null && export EDITOR='nvim' || export EDITOR='vim'
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d" # Use neovim for vim if present.

#Alias {{{

alias sudo="sudo -E"
alias i3c="dotf $HOME/.config/i3/config"
alias zc="dotf $HOME/.zshrc"
alias zcf="dotf $HOME/.zsh-fzf"
alias zcl="$EDITOR ~/.zsh-local"
# alias nrc="dotf $HOME/.config/nvim/init.vim"
alias nrc="$EDITOR $HOME/.config/nvim/init.lua +'lcd %:p:h'"
alias zz="source $HOME/.zshrc"

alias n="notes"
alias nn="note"
# alias ns="notesearch"
alias fns="fnotesearch"

alias nd="notes -d $HOME/Dropbox/DND"
alias ndn="note -d $HOME/Dropbox/DND"
# alias nd="ls --group-directories-first $NOTES_DIR"

alias t="thesaurus"
alias gj="git-jump"
alias fu="findup.py"

# alias -g ff="fuzscope | filer"
alias -g ff="fuzscope | peek"
alias -g G='| grep -i --color'  ## Global alias
alias -g F='| fzf'  ## Global alias
alias -g X='>/dev/null 2>&1 & disown'
alias -g T='|& tee'
alias -g TL='|& tee out.log'
alias -g L='| less'
alias -g C='| xclip -i -selection clipboard'
alias -g V='| vipe'
alias -g R='rep'

alias d='dirs -v | head -10'

alias ls='ls --color -v -N'
alias la='ls -la --color -v -N'
# alias ll='ls -la --color --group-directories-first'
alias ll='exa --long --all --links --git --git-ignore'

# Open modified files
# ACMR = Added || Copied || Modified || Renamed
alias vd="$EDITOR \$(git diff HEAD --name-only --diff-filter=ACMR)"
alias vds="$EDITOR \$(git diff --staged --name-only --diff-filter=ACMR)"
alias vdc="$EDITOR \$(git diff HEAD^ --name-only --diff-filter=ACMR)"
alias vdd="$EDITOR \$(git diff develop --name-only --diff-filter=ACMR)"

alias stj="ssh -qTfnN2 -D 8086 ibt014"

# alias f=". nnnwrap"

alias val='valgrind -v --leak-check=full --show-leak-kinds=all --track-origins=yes --show-reachable=yes'

#}}}

# Functions {{{

# xdg-open:{{{
xo()
{
	# arg=""
	# for value in "$@"; do
	# 	arg="$arg$value"
	# done

    if [[ "$1" =~ ":" ]];
    then
        EXT=${1##*.}
        scp -rC "$1" "/tmp/remotefile.$EXT"
        if [[ $? -eq 0 ]] ; then 
            nohup xdg-open "/tmp/remotefile.$EXT" >/dev/null 2>&1 & disown
        else
            >&2 echo "file not found!"
            return -1
        fi
    else
        nohup xdg-open "$@" >/dev/null 2>&1 & disown
    fi

}

xx()
{
	# arg=""
	# for value in "$@"; do
	# 	arg="$arg$value"
	# done

    if [[ "$1" =~ ":" ]];
    then
        EXT=${1##*.}
        scp -rC "$1" "/tmp/remotefile.$EXT"
        if [[ $? -eq 0 ]] ; then 
            nohup xdg-open "/tmp/remotefile.$EXT" >/dev/null 2>&1 & disown
            exit
        else
            >&2 echo "file not found!"
            return -1
        fi
    else
        nohup xdg-open "$@" >/dev/null 2>&1 & disown
        exit
    fi

}

#}}}
# eXecute: {{{
x()
{
	# arg=""
	# for value in $@; do
	# 	arg="$arg$value"
	# done
    # nohup "$@" >/dev/null 2>&1 & disown

    if [[ "$2" =~ ":" ]];
    then
        EXT=${2##*.}
        scp -rC "$2" "/tmp/remotefile.$EXT"
        if [[ $? -eq 0 ]] ; then 
            nohup "$1" "/tmp/remotefile.$EXT" >/dev/null 2>&1 & disown
        else
            >&2 echo "file not found!"
            return -1
        fi
    else
        nohup "$@" >/dev/null 2>&1 & disown
    fi

}
#}}}
#CHT.SH:{{{
function cht()
{
    curl cht.sh/$1
}
#}}}
# C-Z: {{{
fgkey() { fg }
zle -N fgkey
bindkey '^Z' fgkey
# }}}
#panwebmark: {{{
# Pandoc convert web html to markdown
function pwm()
{
    curl --silent "$1" | pandoc --wrap=preserve --strip-comments --reference-links --from html-raw_html --to markdown_strict -o "$2"
    sed -i '0,/===/d' "$2"
    sed -i '/-----/,$d' "$2"
}
#}}}
# vimwhich - vimw: {{{
vimw()
{
    vim $(readlink -f $(which "$@"))
}
# }}}
# vim-rg-to-quickfix:{{{
function! vq()
{
    nvim -q <( rg -S --vimgrep "$@" )
}
# }}}
# mkc: {{{
function mkc()
{
    mkdir "$1" && cd "$1"
}
# }}}
# yank-path and yank-dirs: {{{
function yp() {echo "$PWD/$1" | tr -d '\n' | xclip -i -selection clipboard}
function yd() {echo "$PWD" | tr -d '\n' | xclip -i -selection clipboard}
#}}}
# MAN: {{{

function man() {

# LESS_TERMCAP_mb # blinking mode (not common in manpages)
# LESS_TERMCAP_md # double-bright mode (used for boldface)
# LESS_TERMCAP_me # exit/reset all modes
# LESS_TERMCAP_so # enter standout mode (used by the less statusbar and search results)
# LESS_TERMCAP_se # exit standout mode
# LESS_TERMCAP_us # enter underline mode (used for underlined text)
# LESS_TERMCAP_ue # exit underline mode

    env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "${@}"
}
# MAN: }}}
# ranger-cd: {{{
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# function ranger-shell {
#     ranger && exit
# }

[[ -n $RANGERSHELL ]] && unset RANGERSHELL && ranger && exit
[[ -n $RANGERCD ]] && unset RANGERCD && ranger-cd && exit

#}}}
# nnn: cd on quit: {{{
f()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
# nnn: cd on quit: }}}
# ring: {{{
ring() {
    ## Works even if terminal is closed, unlike the other two
    local dtime=$1; shift
    local time
    if [[ $dtime =~ ":" ]]; then
        time=$dtime
    else
        time=$(pdd --add $(toseconds $dtime) | head -n 1)
    fi
    # echo $time
    time=$(echo $time | tr -d ':') 
    time=$time[1,4] ## Move to 'at' format
    # echo $time
    echo "notify-send --urgency=critical 'Reminder' $@" | at $time
}
# }}}
# Dotfile management: {{{
## Functions are better for pipes
export DOTDIR=$HOME/.dots
function dot()  {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME "$@"}
function dots() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME status "$@"}
function dotc() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME commit --verbose "$@"}
function dota() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME add "$@"}
function dotu() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME add --update "$@"}
function dotd() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME diff "$@"}
function dotr() {/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME rm "$@"}
function dotlg() {lazygit --git-dir=$DOTDIR --work-tree=$HOME} 

function dotf(){
    ## setting the env vars helps vim-fugitive know what's going on
    [ -n "$@" ] && QUERY="-q $@"
    /usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME ls-tree --full-tree -r HEAD | awk '{print $NF}' | sed "s@^@$HOME/@" | fzf --preview="scope.sh {q} {}" -1 -0 -e $QUERY | GIT_DIR=$DOTDIR GIT_WORK_TREE=$HOME peek
}

function dotaf(){
    files=$(/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME diff --name-only | sed "s@^@$HOME/@" | fzf -m --preview="/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME diff --color {}" )
    [ -n "$files" ] && echo "$files" | xargs /usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME add 
}

function dotcf(){
    files=$(/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME diff --name-only | sed "s@^@$HOME/@" | fzf -m --preview="/usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME diff --color {}" )
    [ -n "$files" ] && echo "$files" | xargs /usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME add 
    /usr/bin/git --git-dir=$DOTDIR --work-tree=$HOME commit --verbose "$@"
}

function dotsparsity(){
    $EDITOR $DOTDIR/info/sparse-checkout
    dot read-tree -m -u HEAD
}

function dotziupg() { dot pull && zi self-update && zi update --parallel 40 && zi cclear }

## FZF
function dotlog(){
    _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git --git-dir=$DOTDIR --work-tree=$HOME show --color=always % | less '"
    dot log --color=always --format="%C(auto)%h%d %s %C(cyan)%C(bold)%cr% C(auto)%an" "$@" |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, ctrl-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "ctrl-y:execute:$_gitLogLineToHash | xclip -i -selection clipboard"
}

## To use local dotfile directories, 
## DOTDIR=$HOME/.localdots dot
## An alias to make even that easy:
alias LD="DOTDIR=$HOME/.localdots"

# }}}
# peek: {{{
peek()
{
    urlregex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    DEBUG="OFF"
    MODE="EDIT"

    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
        key="$1"
        case $key in
            -p|--print)
                shift # past value
                MODE="PRINT"
                ;;
            -d|--debug)
                DEBUG="ON"
                shift # past value
                ;;
            *)    # unknown option
                POSITIONAL+=("$1") # save it in an array for later
                shift # past argument
                ;;
        esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters


    if [[ -n "$@" ]]; then
        FILES="$@"
    else
        ## Space separated
        # read -r FILES

    ## Newline separated, becuase fzf pipes
    FILES=()
    while read -r line; do
        # echo "> $line"
        FILES+=( "$line" )
    done
    fi

    open()
    {
        nohup "$@" > /dev/null 2>&1 & disown
    }

    guiopen()
    {
        nohup xdg-open "$@" >/dev/null 2>&1 & disown
    }

    special()
    {
        FILE="$@"
        FILEBASENAME=$(basename "$FILE")
        [[ "$FILEBASENAME" =~ "." ]] && EXT=${FILEBASENAME##*.} || EXT=""
        FILETYPE="$(file --mime-type "$FILE" | awk -F ': ' '{print $2}')"

        if [[ "$FILE" =~ $urlregex ]]; then
            if [[ -x $(command -v urler.sh) ]]; then
                urler.sh "$FILE"
            else
                guiopen "$FILE"
            fi
        else
            guiopen "$FILE"
        fi

    }

    driver()
    {
        FILE="$@"
        FILEBASENAME=$(basename "$FILE")
        [[ "$FILEBASENAME" =~ "." ]] && EXT=${FILEBASENAME##*.} || EXT=""
        FILETYPE="$(file --mime-type "$FILE" | awk -F ': ' '{print $2}')"

        if [[ "$FILETYPE" == "inode/symlink" ]]; then
            driver "$(readlink -f "$FILE")"
        fi

        if [[ "$DEBUG" == "ON" ]]; then 
            echo "file=$FILE"
            echo "filebasename=$FILEBASENAME"
            echo "ext=$EXT"
            echo "c[0]=${FILEBASENAME:0:1}"
            echo "filetype=$FILETYPE"
            echo "------------------"
        fi

        if [[ "$MODE" == "EDIT" ]]; then
            case "$FILETYPE" in 
                "inode/directory"         ) builtin cd "$FILE"            ; return ;;
                "inode/x-empty"           ) $EDITOR "$FILE"               ; return ;;
                "application/octet-stream") dex -e "$FILE"                ; return ;;
                "text/html"               ) guiopen "$FILE"               ; return ;;
                "application/pdf"         ) guiopen "$FILE"               ; return ;;
                "application/json"        ) $EDITOR "$FILE"               ; return ;;
                text/*              ) $EDITOR "$FILE"               ; return ;;
                *                         ) special "$FILE"               ; return ;;
            esac
        elif [[ "$MODE" == "PRINT" ]]; then
            case "$FILETYPE" in 
                "inode/directory"         ) ls "$FILE"                    ; return ;;
                "inode/x-empty"           ) cat "$FILE"                   ; return ;;
                "application/octet-stream") dex -p "$FILE"                ; return ;;
                "text/html"               ) guiopen "$FILE"               ; return ;;
                "application/pdf"         ) guiopen "$FILE"               ; return ;;
                "application/json"        ) cat "$FILE"                   ; return ;;
                text/*              ) cat "$FILE"                   ; return ;;
                *                         ) special "$FILE"               ; return ;;
            esac
        fi

    }

    for FILE in "${FILES[@]}"; do
        driver "$FILE"
    done
}
# peek: }}}
# }}}

# Bell Hook: {{{
## this may already be in your ~/.zshrc
autoload -Uz add-zsh-hook
# duration in seconds after which a bell should be sent
typeset -i LONGRUNTIME=30
# function to save time at which a command was started
save_starttime () {
  starttime=$SECONDS
}
# function to print \a if the command took longer than LONGRUNTIME
set_longrunning_alert () {
  if ((LONGRUNTIME > 0 && SECONDS - starttime >= LONGRUNTIME)); then
    print "\a"
  fi
}
# run save_starttime before a command is executed
add-zsh-hook preexec save_starttime
# run set_longrunning_alert after a command finishes (before the prompt)
add-zsh-hook precmd set_longrunning_alert
# }}}

## SSH TMUX REFRESH ENV: {{{
# updates DISPLAY env in outdated tmux sessions
function tmux_update_display(){
    if [ -n "$TMUX" ]; then
        if [[ $(tmux show-env | grep "^DISPLAY" | sed 's/DISPLAY=//') != $DISPLAY ]]; then
            # echo "DISPLAY OUTDATED!"
            export $(tmux show-environment | grep "^DISPLAY")
        fi
    fi
}
add-zsh-hook preexec tmux_update_display

## SSH TMUX REFRESH ENV: }}}

function vimfu()
{
    file=$(findup.py "$@")
    if [ -n "$file" ]; then
        $EDITOR "$file"
    fi
}

## Fuzzy pass browser
fpass() {
    local DIR=${PWD}
    cd ~/.password-store
    fzf --bind="enter:execute@dex -p {}@,ctrl-d:execute@rm {}@,ctrl-b:execute@echo {} | sed 's/.gpg//' | xargs pass | grep url | awk '{print \$2}' | xargs firefox --new-tab@,ctrl-o:execute@echo {} | sed 's/.gpg//' | xargs pass edit@" | less
    cd "$DIR"
}

alias F="sudo -E nnn -dH" # sudo file browser



alias ma="mamba"
alias maa="mamba activate"
alias mad="mamba deactivate"
alias mai="mamba install"
alias mae="mamba env"

alias lg="lazygit"
alias lgd="lazygit --git-dir=$DOTDIR --work-tree=$HOME"
alias llgd="lazygit --git-dir=$HOME/.localdots --work-tree=$HOME"

alias ns="nix-shell"
alias ne="nix-env"
alias neq="nix-env -q"
alias neqas="nix-env -qas"
alias neqm="nix-env -qa --meta --json -A"
alias neia="nix-env -iA"
alias neu="nix-env --uninstall"
alias znix="module load nix && nix-shell --command zsh"

function nsd(){
    nix show-derivation $(nix path-info --derivation "nixpkgs#$1")
}

function nsp(){
    storepath=$(nix eval --raw 'nixpkgs#'$1'.outPath')
    echo $storepath
}

function ned(){
    nix edit 'nixpkgs#'$1
}

alias an="archlinux-nix"

function fml(){
    module load $(fmod $@)
}

## Use this to trace the libs loaded at runtime
## LDTRACE ./main
alias LDTRACE="LD_TRACE_LOADED_OBJECTS=1"

function is_chroot(){
    awk 'BEGIN{exit_code=1} $2 == "/" {exit_code=0} END{exit exit_code}' /proc/mounts
    echo $?
}

alias h="home-manager"
alias hh="home-manager switch"
alias he="home-manager edit"
alias hg="home-manager generations"

alias news="newsboat"
alias newsc="vim ~/.newsboat/config"
alias newsu="vim ~/.newsboat/urls"

alias sst="ssh -O stop"

function ssr() { 
    ssh -O stop "$1"
    ssh "$1"
}

function rep(){
    repeat "$1" { echo "${@:2}" }
}


