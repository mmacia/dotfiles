# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/share/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/share/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/share/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/share/fzf/shell/key-bindings.bash"
