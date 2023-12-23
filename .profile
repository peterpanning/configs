# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

###### JAVA HOME ENV VARIABLE ######
export JAVA_HOME="$(/usr/libexec/java_home)"

###### NVM ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###### GO ######
path=($path /Users/peter.mutch/go/bin)

###### SBIN ######
path=($path /usr/local/sbin)
