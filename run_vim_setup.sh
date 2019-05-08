#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Setup/Installer for .vimrc and desired plugins
#
# NOTE: If you are running this setup script on a machine through an ssh 
#       connection, you can comment out the powerline font install at the 
#       bottom of this script
#
# tbd. 05.08.2019
# ---------------------------------------------------------------------------

echo " "
echo "----------------------------------------------------------------------"
echo "VIM .vimrc and plugin setup/installer"
echo "----------------------------------------------------------------------"
echo " "

# ------------------------------------------
# check some things first...
# ------------------------------------------
if [ ! $(which vim) ]; then
    echo "ERROR!!!"
    echo "No VIM installation detected. Please install VIM."
    echo " "
    exit 1
fi

vim_version=$(vim --version | head -1 | awk -F ' ' '{print $(5)}')
if (( $(echo "$vim_version < 7.3" |bc -l) )); then
    echo "ERROR!!!"
    echo "This requires VIM 7.3 or higher. Please update your VIM."
    echo " "
    exit 1
fi

if (( $(echo "$vim_version < 7.5" |bc -l) )); then
    echo "Warning: YouCompleteMe Plugin will not be installed."
    echo "YCM requires VIM 7.4.1+ and you have $vim_version"
    echo "Consider updating."
    echo " "
    ycm=false
else
    ymc=true
fi

# check for python
if [ ! $(vim --version | grep -o +python) ]; then
    echo "ERROR!!!"
    echo "This requires VIM with python support for the sweet, sweet powerline."
    echo "You disable that if you want, and remove this."
    echo " "
    exit 1
fi
# ------------------------------------------

cp .vimrc ~$HOME/
cd $HOME

# install Vundle for plugin management
echo "Installing Vundle Plugin manager..."
if [ -d .vim/bundle/Vundle.vim ]; then
    echo "Looks like you aready have Vundle...skipping."
else
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install plugins in .vimrc
echo "Installing VIM plugins..."
vim -c 'PluginInstall' -c 'qa!'

# install YouCompleteMe
if [ "$ycm" = true ]; then
    echo "Installing YouCompleteMe...\n"
    /usr/bin/python  ~/.vim/bundle/YouCompleteMe/install.py
fi

# install powerline fonts
echo "Installing powerline fonts..."
git clone https://github.com/powerline/fonts.git --depth=1                    
cd fonts                                                                      
./install.sh                                                                  
cd ..                                                                         
rm -rf fonts
echo "New fonts installed for powerline status bar."
echo "To enable, select for containing 'for Powerline' from terminal preferences."
echo "I recomend DejaVu Sans Mono for Powerline."

cd -

echo "----------------------------------------------------------------------"

