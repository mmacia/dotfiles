local magenta=$FG[201]
local red=$FG[196]
local cyan=$FG[014]
local blue=$FG[033]
local yellow=$FG[011]
local green=$FG[010]

prompt_hostname() {
  echo "%{$fg_bold[yellow]%}[`hostname`]"
}

prompt_python_version() {
  # test asdf
  asdf info | grep python 1> /dev/null 2>&1
  local python_enabled=$?

  if [ $python_enabled -eq 0 ]; then
    local python_version=$(asdf current python | awk '{print $2}')

    if [ "$python_version" != "system" ]; then
      echo -e "🐍%{$reset_colors%}%{$yellow%}$python_version"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

prompt_ruby_version() {
  # test asdf
  asdf info | grep python 1> /dev/null 2>&1
  local ruby_enabled=$?

  if [ $ruby_enabled -eq 0 ]; then
    local ruby_version=$(asdf current ruby | awk '{print $2}')

    if [ "$ruby_version" != "system" ]; then
      echo -e "💎%{$reset_colors%}%{$yellow%}$ruby_version"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

prompt_language_version() {
  echo "$(prompt_python_version)$(prompt_ruby_version)"
}


local ret_status="%(?:%{$green%}➜ :%{$red%}➜ %s)"


PROMPT='${ret_status}$(prompt_language_version)$(prompt_hostname) %{$cyan%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$blue%}git:(%{$red%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$blue%}) %{$yellow%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$blue%})"
