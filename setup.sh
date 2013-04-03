#!/bin/sh

# this script maps my configuration files in a fresh system.
# does not delete any configuration file or directory, if any exists
# the install process simply rename it to *.old

# you can safetely run this install script many times in order to update
# git submodules and check symlinks

install_helper_scripts() {
  echo "Installing helper scripts ..."

  # install autostart scripts
  if [ -d ~/.kde -a ! -L ~/.kde/Autostart/bootstrap.sh ]; then
    ln -s ~/.dotfiles/scripts/bootstrap.sh ~/.kde/Autostart/bootstrap.sh
  fi
}

configure_git() {
  git config --global alias.st status
  git config --global alias.ci commit
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global color.ui always
  git config --global alias.df diff
  git config --global alias.pr "pull --rebase --stat"
  git config --global alias.in "merge --squash --commit"
  git config --global core.editor vim
}

echo "Saving old files ..."
for file in ~/.vimrc ~/.vim ~/.vimrc-keymaps ~/.vimrc-au ~/.bashrc ~/.bash_aliases ~/.bash_colors ~/.irbrc; do
  if [ -L $file ]; then
    rm -f $file
  elif [ -e $file ]; then
    mv $file "$file.`date +%s`.old"
  fi
done

echo "Linking dot files ..."
for file in vim vimrc vimrc-keymaps vimrc-au bashrc bash_aliases bash_colors irbrc; do
  ln -s "`pwd`/$file" "$HOME/.$file"
done

echo "Installing bundles..."
if [ $(which ruby 2>/dev/null) ]; then
  ruby `pwd`/vim/bin/vim-update-bundles.rb
  gem install interactive_editor
else
  echo "ERROR: ruby is not installed. You have to install ruby package!"
fi

install_helper_scripts

# ask user to configure git options
if [ $(which git 2>/dev/null) ]; then
  read -p "Do you wish to autoconfigure Git (y/N) " choose
  case $choose in
    [yY]* ) configure_git; break;;
    * ) echo "Skiping Git configuration."; break;;
  esac
fi

echo "Done."
