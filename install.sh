#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cat << "EOF"
                                   o                     _      _          
         |        o                /         |          | | o  | |         
 __,   __|   ,_       __,   _  _     ,     __|   __ _|_ | |    | |  _   ,  
/  |  /  |  /  |  |  /  |  / |/ |   / \_  /  |  /  \_|  |/  |  |/  |/  / \_
\_/|_/\_/|_/   |_/|_/\_/|_/  |  |_/  \/   \_/|_/\__/ |_/|__/|_/|__/|__/ \/ 
                                                        |\                 
                                                        |/ 
EOF

echo "Checking for Vundle installation..."
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "No Vundle installation found! Installing Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "Checking for zprezto..."
if [ ! -d ~/.zprezto ]; then
  echo "No zprezto installation found! Installing Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "Creating symlinks for zsh..."
ZSH_FILES="zlogin zlogout zpreztorc zprofile zshenv"
for file in $ZSH_FILES;do
  ln -s ~/.zprezto/runcoms/$file ~/.$file
done

FILES="tmux.conf vimrc zshrc gitconfig"
echo "Backing up old dotfiles..."
for file in $FILES;do
  if [ -f ~/.$file ]; then
    echo "Backing up ~/.$file to ~/.$file.BAK"
    mv ~/.$file ~/.$file.BAK
  fi
done

echo "Installing dotfiles"
for file in $FILES;do
  ln -sf $DIR/$file ~/.$file
done

# tell user to change shell with chsh -s /bin/zsh and logout
echo "Creating needed directories for vim"
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap

# install all plugins for vim
echo "Installing vim plugins"
vim +PluginInstall +qall

echo "dotfiles installed! Make sure to transfer anything from your .BAK files into your new dotfiles."
echo "Make sure your default shell is zsh! example: 'chsh -s /bin/zsh'"
echo "Logout then log back in to enjoy your new shell!"

exit 0
