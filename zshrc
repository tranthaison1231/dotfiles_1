#	-------------------------------------------
#		ENVIRONMENT CONFIGURATION
#	-------------------------------------------

#	Enable oh-my-zsh
#	------------------------------------------------------------------------
	export ZSH=$HOME/.oh-my-zsh
	export DOTFILES=$HOME/.dotfiles
	ZSH_THEME="clean"
	HIST_STAMPS="dd.mm.yyyy"

#	Homebrew settings
#	------------------------------------------------------------------------
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	export LANGUAGE=en_US.UTF-8
	export GPG_TTY=$(tty)

	export GIT_RADAR_FETCH_TIME=30
	export LESS=eFRX

	export COMPOSER_ALLOW_SUPERUSER=1


#	Enable Plugins
#	------------------------------------------------------------------------
	plugins=(
		colored-man-pages
		git
		encode64
		sudo
		zsh-syntax-highlighting
		zsh-autosuggestions
		yarn
		sublime
		docker
		docker-compose
		docker-machine
		rbates
		dotfiles
	)
	[ -f ~/.zshrc.local ] && source ~/.zshrc.local
	source $ZSH/oh-my-zsh.sh

#	-----------------------------------------
#		MAKE TERMINAL BETTER
#	-----------------------------------------

	alias cp="cp -iv"                                               # Preferred 'cp' implentation
	alias mv="mv -iv"                                               # Preferred 'mv' implentation
	alias mkdir="mkdir -pv"                                         # Preferred 'mkdir' implentation
	alias cd..='cd ../'                                             # Go back 1 directory level (for fast typers)
	alias ..='cd ../'                                               # Go back 1 directory level
	alias ...='cd ../../'                                           # Go back 2 directory levels
	alias .3='cd ../../../'                                         # Go back 3 directory levels
	alias .4='cd ../../../../'                                      # Go back 4 directory levels
	alias .5='cd ../../../../../'                                   # Go back 5 directory levels
	alias .6='cd ../../../../../../'                                # Go back 6 directory levels
	alias path='echo -e ${PATH//:/\\n}'                             # path:         Echo all executable Paths
	alias gh='history | grep '										# Grep from history, easy shortcut

	alias df="df -h -x overlay -x tmpfs"
	alias du="du -ch"
	alias du1="du -chd1"

	# Quick SSH without messing up your known hosts file
	alias ssh0="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

	if [ -x "$(command -v exa)" ]; then
		alias ls="exa"
		alias la="exa -la"
	fi

	alias wp="wp --allow-root"

#	-------------------------------------------
#		FILE AND FOLDER MANAGEMENT
#	-------------------------------------------
	zipf () { zip -r "$1".zip "$1" ; }                              # zipf:             To create a ZIP archive of a folder

#	extract:  Extract most know archives with one command
#	-------------------------------------------------------------------
	extract () {
		if [ -f $1 ] ; then
		  case $1 in
			*.tar.bz2)   tar xjf $1     ;;
			*.tar.gz)    tar xzf $1     ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar e $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xf $1      ;;
			*.tbz2)      tar xjf $1     ;;
			*.tgz)       tar xzf $1     ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)     echo "'$1' cannot be extracted via extract()" ;;
			 esac
		 else
			 echo "'$1' is not a valid file"
		 fi
	}

#	---------------------------------------
#		MAKE GIT BETTER
#	---------------------------------------
	alias status='git status'
	alias s='git status'
	alias add='git add'
	alias commit="git commit"
	alias push="git push"
	alias clone="git clone"

#	---------------------------------------
#		MAKE DOCKER BETTER
#	---------------------------------------
	# Show live stats
	alias ds='while true; do TEXT=$(docker stats --no-stream $(docker ps --format "{{.Names}}")); sleep 0.1; clear; echo "$TEXT"; done'

	# Kill all containers
	alias dk='docker kill $(docker ps -q)'

	# Docker compose
	alias dc='docker-compose'

#	---------------------------------------
#		NETWORKING
#	---------------------------------------
	alias myip='curl -4 icanhazip.com; curl -6 icanhazip.com'       # myip:             Public facing IP Address
	alias netCons='lsof -i'                                         # netCons:          Show all open TCP/IP sockets
	alias flushDNS='sudo killall -HUP mDNSResponder'                # flushDNS:         Flush out the DNS Cache
	alias lsock='sudo /usr/sbin/lsof -i -P'                         # lsock:            Display open sockets
	alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'               # lsockU:           Display only open UDP sockets
	alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'               # lsockT:           Display only open TCP sockets
	alias openPorts='sudo lsof -i | grep LISTEN'                    # openPorts:        All listening connections
	alias showBlocked='sudo ipfw list'                              # showBlocked:      All ipfw rules inc/ blocked IPs

	alias ip4="ip -4"
	alias ip6="ip -6"

#	---------------------------------------
#		SYSTEMS OPERATIONS & INFORMATION
#	---------------------------------------

#	cleanupDS:	Recursively delete .DS_Store files
#	-------------------------------------------------------------------
	alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#	mkcd:		Create a directory and cd into it
#	-------------------------------------------------------------------
	function mkcd {
		if [ ! -n "$1" ]; then
			echo "Enter a directory name"
		elif [ -d $1 ]; then
			echo "\`$1' already exists"
		else
			mkdir $1 && cd $1
		fi
	}

#	kopy:		Send stdin to kopy.io
#	-------------------------------------------------------------------
	kopy() {
		a=$(cat);
		curl -X POST -s -d "raw:$a" http://kopy.io/documents | awk -F '"' '{print "http://kopy.io/"$4}';
	}

#	gi:			Source templates for gitignore.io
#	-------------------------------------------------------------------
	function gi() {
		curl -L -s https://www.gitignore.io/api/$1;
	}

#	dadjoke:	Fetches a dadjoke straight to the terminal
#	-------------------------------------------------------------------
	function dadjoke() {
		curl -H "Accept: text/plain" https://icanhazdadjoke.com/
		echo ""
	}

#	mp4:		Input video file and convert it to mp4
#	-------------------------------------------------------------------
	function mp4() {
		ffmpeg -i $1 ${$(basename $1)%.*}.mp4
	}

#	neofetch:	Fancy boot info
#	-------------------------------------------------------------------
	if [ -x "$(command -v neofetch)" ]; then
		neofetch
	fi

#	Trigger a new load of autocompletions
#	-------------------------------------------------------------------
	autoload -U compinit && compinit
