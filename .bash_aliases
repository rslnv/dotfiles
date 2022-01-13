# some ls aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# alias for bare git repo
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'

# rclone
alias rcmd='rclone mount Dropbox: ~/Dropbox'

# vpn
alias vpnru='cd ~/Downloads/vpn; sudo openvpn ru.protonvpn.com.udp.ovpn'
alias vpnee='cd ~/Downloads/vpn; sudo openvpn ee.protonvpn.com.udp.ovpn'
