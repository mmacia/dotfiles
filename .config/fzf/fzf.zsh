# Setup fzf
# ---------
FZF_DIR="$ASDF_DATA_DIR/installs/fzf/$(asdf current fzf | awk '{print $2}')"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_DIR/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_DIR/shell/key-bindings.zsh"
