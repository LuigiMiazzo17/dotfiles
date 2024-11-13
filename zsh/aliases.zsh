if [ "$(uname)" = "Darwin" ]; then
    alias wireshark="/Applications/Wireshark.app/Contents/MacOS/Wireshark & disown"
    alias gdb='lima gdb -q'

    if [ -x "$(command -v figlet)" ]; then
        if [ -x "$(command -v lolcat)" ]; then
            figlet "Minimi's MBP" | lolcat
        else
            figlet "Minimi's MBP"
        fi
    fi
fi

alias cdtmp='cd $(mktemp -d /tmp/XXXXXXXXXXX)'
alias mkdir='mkdir -p'

alias vim="nvim"
alias erpitone="python3"

alias venv='python3 -m venv env'
alias activate='source env/bin/activate'

alias k='kubectl'

alias venv='source .venv/bin/activate'
