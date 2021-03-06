# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source Bash completion if it doesn't work yet
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

function settitle {
if [ -z "$VIRTUAL_ENV" ]; then
    LOCATION="###"
else
    LOCATION=$(basename $VIRTUAL_ENV)
fi
echo -ne "\033]0;${LOCATION} (${USER}@${HOSTNAME})\007"
}

PROMPT_COMMAND='settitle'
PS1='\[\033[01;32m\]\t\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;33m\]🍔\[\033[00m\]  '
export LANG=en_US.UTF-8 #this way screen will also start wtih utf8
export EDITOR=vi

source ~/.bash_aliases

# shortcut for github repository cloning (GitHub Clone)
# credit goes to chepner for this optimization:
# http://stackoverflow.com/a/15361490/131120
#
# :param repo: a string containing the end of the github url
ghc () { git clone git@github.com:"${@?need to set param: <dev>/<proj>}"; }


# a HidaV shortcut to the dev shell
#
# :param recipe: the name of the recipe that should be edited
devshell() {
    if [ -z "$1" ]; then
        echo "need to set param: <recipe-name>"
    else
        cd ~/coding/HidaV
        . ./hidav-init.sh .
        bitbake -c devshell $1
    fi
}

# a HidaV shortcut to building sd cards for HidaV devices
#
# :param usb: the path to the sd card, optional
sdcard() {
    [-z $1] && 1=/dev/sdc
    cd ~/coding/Hidav
    . ./hidav-init.sh .
    cd ./tmp-eglibc/deploy/images/hidav-ti81xx
    ./ti814x-bootable-sdcard.sh $1
}

# builds a complete tex file with all the indexes, libraries and so on.
#
# :param filename: which file should be compiled
ertex() {
    if [ -z "$1" ]; then
        echo "need to set param: <filename>"
    else
        pdflatex $1.tex -interaction=nonstopmode
        bibtex $1.aux
        pdflatex $1.tex -interaction=nonstopmode
        pdflatex $1.tex -interaction=nonstopmode
    fi
}
PATH=$PATH:/home/erikb85/coding/golang/bin

#virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
# # add manual go installation
# export PATH=$PATH:/usr/local/go/bin


deactivate-touchpad() {
    touchpadid=`xinput | awk -F= '/Synaptics TouchPad/ { print $2; }' | awk '{print $1}'`
    if [[ $touchpadid =~ [[:digit:]] ]] ; then
        echo "touchpad is $touchpadid, deactivate it"
        xinput set-prop "$touchpadid" "Device Enabled" 0
    fi
}

hotline() {
    cd ~/.local/share/Steam/SteamApps/common/hotline_miami/
    optirun ./hotline_launcher
}
