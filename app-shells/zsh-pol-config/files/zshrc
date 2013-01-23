################################################################################
# aliases
################################################################################

# ls
alias l1='/bin/ls -1hNT 0 --color=auto'
alias ls='ls -hNFT 0 --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# interactive cp/mv/rm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# misc
alias s='cd ..'
alias c='clear'

alias grep='grep --color=auto'
alias less='less -q'

alias df='df -h'
alias du='du -h'

alias http-server='python -m SimpleHTTPServer'

# C/C++
alias bcpp='bcpp -s -i 2'

# Gentoo
alias emerge='emerge --tree --jobs=8'
alias unmerge='emerge --unmerge'
alias update='eix-sync'
alias upgrade='emerge --keep-going --ask --update --newuse --deep world'
alias up-live='emerge --oneshot @live-rebuild'
alias up='update && upgrade'
alias rebuild_world='emerge --keep-going world'
alias which-package='equery belongs'
alias which-use='equery hasuse'
alias build-kernel='genkernel --menuconfig all'
alias dg='ebuild $(ls -1 *.ebuild | head -n1) manifest'
alias chk='for i in `eix "-I*" --format "<installedversions:NAMEVERSION>" --only-in-overlay`; do equery k $i; done'

################################################################################
# prompt and completion
################################################################################

# init
autoload -U compinit promptinit
compinit
promptinit

# prompt
prompt gentoo
source /etc/zsh/zshprompt

# completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

# options
setopt nullglob           # remove non-matching jokers instead of failing
setopt auto_remove_slash  # auto-remove useless slash at end of folders
unsetopt glob_dots        # remove hidden folders from completion choice
setopt chase_links        # follow symlinks
setopt hist_verify        # display history (!) command before execution

################################################################################
# keys
################################################################################

if [[ "$TERM" != emacs ]]; then
  bindkey '^[[3~' delete-char             # Del
  bindkey '^[[2~' overwrite-mode          # Insert
  bindkey '^[[5~' history-search-backward # PgUp
  bindkey '^[[6~' history-search-forward  # PgDn
  bindkey '^[[H'  beginning-of-line       # Home
  bindkey '^A'    beginning-of-line       # Ctrl-a
  bindkey '^[[F'  end-of-line             # End
  bindkey '^E'    end-of-line             # Ctrl-e
  bindkey '^[[Z'  reverse-menu-complete   # Shift-Tab
  bindkey '^N'    forward-word            # Ctrl-n
  bindkey '^B'    backward-word           # Ctrl-b
fi

################################################################################
# ls colors
################################################################################

if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  else
    eval "`dircolors`"
  fi
fi

################################################################################
# misc options
################################################################################

# no beep
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# force usage of '>|' when redirect output to existing file
unsetopt clobber

# ctrl+d for logout
unsetopt ignore_eof

# display return value on errors
setopt print_exit_value

# ask confirmation on 'rm *'
unsetopt rm_star_silent

# automaticly do cd if the command correspond to an existing folder name
setopt auto_cd

# use pushd for cd
setopt auto_pushd

# remove duplicate in pushd
setopt pushd_ignore_dups

# do not display stack on pushd and popd
setopt pushd_silent

# pushd go to home without args
setopt pushd_to_home

# background task are niced to 0
unsetopt bg_nice

# do not close backgroud jobs on closing shell
unsetopt hup

################################################################################
# history
################################################################################

setopt HISTIGNOREDUPS HISTIGNORESPACE EXTENDED_HISTORY
export HISTORY=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.history
