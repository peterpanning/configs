# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

####### ZSHRC #######

# This zsh configuration file relies mainly on built in zsh features,
# antidote (the successor to antigen and antibody), and Powerlevel10k
# (a simple and powerful prompt customization plugin).


####### ZSH BUILTINS #######

# Make path variable unique to prevent duplicate entries

typeset -aU path

# Start zsh completion

autoload -U compinit
compinit


# Hyphen-insensitive autocompletion

HYPHEN_INSENSITIVE="true"

# Display red dots while waiting for command completion

COMPLETION_WAITING_DOTS="true"

####### ALIASES #######

# For a full list of active aliases, run `alias`.

alias zshconfig="vim ~/.zshrc"
alias ls="ls -G" 		# Adds colored output

# causes chpwd() to function as it normally would in zsh and ls in the new dir. 

function chpwd() {
  emulate -L zsh
  ls -a
}

####### ANTIDOTE #######

# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load


####### POWERLEVEL9K #######

# On the left, show user and host if its not peter@mercury, git repo info,
# and error code of last command if it resulted in an error.
# On the right, show virtualenv or rvm information if we're using them
# and the current time.

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv rvm time)

# Two-line prompt so command line entry is always in the same place

POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Set default user so context (user and host) is only printed if it's
# in some way unusual

if [[ $(whoami)="peter.mutch" || $(whoami)="peter" ]]; then
  DEFAULT_USER=$(whoami)
fi

# Show status only if it was an error

POWERLEVEL9K_STATUS_OK='false'

# Various color and icon settings, including custom prompt icon
# (implemented as a prompt prefix)

POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='yellow'
POWERLEVEL9K_RVM_BACKGROUND='162'
POWERLEVEL9K_RVM_FOREGROUND='white'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='005'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='009'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
POWERLEVEL9K_VCS_DIRTY_BACKGROUND='red'
POWERLEVEL9K_VCS_DIRTY_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=$'\u2771 '
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX_BACKGROUND='005'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX_FOREGROUND='white'


###### ITERM2 SHELL INTEGRATION ######

#source 	~/.iterm2_shell_integration.zsh

###### RVM ######
# Has to be loaded last or RubyMine complains
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
