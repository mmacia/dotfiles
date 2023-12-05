local magenta=$FG[201]
local red=$FG[196]
local cyan=$FG[014]
local blue=$FG[033]
local yellow=$FG[011]
local green=$FG[010]

prompt_hostname() {
  echo "%{$fg_bold[yellow]%}[`hostname`]"
}

local ret_status="%(?:%{$green%}➜ :%{$red%}➜ %s)"


PROMPT='${ret_status} %{$cyan%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$blue%}git:(%{$red%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$blue%}) %{$yellow%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$blue%})"
