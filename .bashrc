cd

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d'# -e 's/* \(.*\)/(\1)/'
}

COLOR_RED="\033[31m"
COLOR_YELLOW="\033[33m"
COLOR_GREEN="\033[32m"
# COLOR_OCHRE="\033[38;5;95m"
# COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[37m"
COLOR_RESET="\033[0m"
COLOR_BLUE="\033[36m"
COLOR_CYAN="\033[97m"

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local git_remote=($(git remote 2> /dev/null))
  local git_remote=${git_remote[0]}
  local git_ahead=$(git rev-list --left-only --count HEAD...$git_remote/$(git_branch))

  if [[ $git_status =~ "Changes to be committed:" ]] || [[ $git_status =~ "Changes not staged for commit:" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_ahead > 0 ]]; then
    echo -e $COLOR_YELLOW
  else
    echo -e $COLOR_GREEN
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_branch_print {
  local branch=$(git_branch)
  if [ ! -z "$branch" ]; then
    echo " ($branch)"
  fi
}

#colors of terminal
export CLICOLOR=1

PS1="\[$COLOR_BLUE\]\u:"          # username
PS1+="\[$COLOR_YELLOW\]\W"        # working directory
PS1+="\[\$(git_color)\]"          # colors git status
PS1+="\[\$(git_branch_print)\]"   # prints current branch
PS1+="\[$COLOR_RESET\]\$ "
export PS1










#export LSCOLORS=ExFxBxDxCxegedabagacad
# export PS1="\[\033[36m\]\u\[\033[m\]\[\033[32m\]:\[\033[33;1m\]\W\[\033[m\]\$(parse_git_branch)\[\033[00m\]\$"
alias ls='ls -GFh --color=auto'
export LS_COLORS=$LS_COLORS:'di=1;33:ln=0;37:ex=96'


# set up aliases for programs
alias notepad1="/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe"
notepad() {
	if [ -n "$1" ]
		then
		c=$( pwd )
		cd $( dirname $1 )
		notepad1 $( basename $1 ) &
		cd $c
#		notepad1 $1 &
	else
		notepad1 &
	fi
}
alias vsc="/c/Program\ Files/Microsoft\ VS\ Code/Code.exe"

# Set up python paths
source $HOME/.pypaths
py () {
        source $HOME/.pypaths
}

# Set up custom bash commands
source $HOME/libraries/bash/.commands

# Set Browser enviroment variable for jupyter notebook
export BROWSER=/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe


# method to hide files starting with a dot (as on mac)
hide () {
        cmd /c ATTRIB +H /s /d C:\.*
        cmd /c ATTRIB +H /s /d U:\.*
}

alias ssms1="/c/Program\ Files\ \(x86\)/Microsoft\ SQL\ Server/140/Tools/Binn/ManagementStudio/ssms.exe"
ssms() {
	if [ -n "$1" ]
		then
		ssms1 $1 &
	else
		ssms1 &
	fi
}


source /r/Data-Out/Internal/181122_EQEQ_useful_scripts/.useful_scripts

alias open='explorer'
alias python='winpty python.exe'
alias upload='~/libraries/python/other/upload.py'
alias export='~/libraries/python/other/export.py'
alias vm='vsc $( git modified $1 )'
alias vma='vsc $( git modified -i )'
alias vch='vsc $( git modified HEAD )'
alias pdflatex='/c/users/joshua.warren/AppData/Local/Programs/MiKTeX\ 2.9/miktex/bin/x64/pdflatex.exe'

