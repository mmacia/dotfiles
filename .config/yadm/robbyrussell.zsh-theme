local magenta=$FG[201]
local red=$FG[196]
local cyan=$FG[014]
local blue=$FG[033]
local yellow=$FG[011]
local green=$FG[010]

prompt_vim_subshell() {
  local my_pcmdline=$(ps --no-header -o cmd -p $(ps --no-header -o ppid -p $$) 2>/dev/null) # get its command line
  local my_cmddash=$(awk '{print $1}' <<<$my_pcmdline)               # gets command name, possibly with preceding hyphen
  local my_cmd=${my_cmddash#-}                                       # get bare command name

  echo $my_cmd | grep ^vi > /dev/null
  if [ $? -eq 0 ]; then
    echo "%{$reset_colors%} %{$magenta%}$my_cmd!"
  else
    echo ""
  fi
}

prompt_hostname() {
  [[ -n "" ]] && echo "%{$yellow%}[`hostname`]"
}

prompt_python_version() {
  # test pyenv
  pyenv local 1> /dev/null 2>&1
  local pyenv_enabled=$?

  if [ $pyenv_enabled -eq 0 ]; then
    echo -e "🐍%{$reset_colors%}%{$yellow%}$(pyenv_prompt_info)"
  else
    echo ""
  fi
}

prompt_ruby_version() {
  # test pyenv
  rbenv local 1> /dev/null 2>&1
  local rbenv_enabled=$?

  if [ $rbenv_enabled -eq 0 ]; then
    if [ "$(rbenv local)" != "system" ]; then
      echo -e "💎%{$reset_colors%}%{$yellow%}$(rbenv_prompt_info)"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

local ret_status="%(?:%{$green%}➜ :%{$red%}➜ %s)"


PROMPT='${ret_status}$(prompt_python_version)$(prompt_ruby_version)$(prompt_hostname)$(prompt_vim_subshell) %{$cyan%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$blue%}git:(%{$red%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$blue%}) %{$yellow%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$blue%})"
