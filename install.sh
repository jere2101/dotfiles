#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

# Create Symlink to file
create_symlink() {
    local name=$1
    echo "Creating symlink to $name in home directory."
    rm -rf ~/$name
    ln -s $script_dir/$name ~/$name
    wait
}

install_plugins() {
    echo "Installing zsh-autosuggetions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion"
    if [ ! -d "$DIR" ]; 
    then    
        echo 'Installing zsh-better-npm-completion'    
        git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion
    fi

}

echo "Initializing zsh."
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

install_plugins

wait

create_symlink .gitconfig
create_symlink .zshrc
