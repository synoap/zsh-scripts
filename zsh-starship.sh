#!/bin/bash

# Check if oh-my-zsh is installed
if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh is already installed"
else
	# Install oh-my-zsh
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check if ZI is installed
if [ -d ~/.zi ]; then
	echo "ZI is already installed"
else
	# Install ZI
	echo "Installing ZI..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/sh/install.sh)"
fi

# Create a backup of the current zshrc file
cp ~/.zshrc ~/.zshrc_backup

# Check if starship is installed
if [[ -f ~/local/bin/starship ]]; then
	echo "Starship is already installed"
else
	echo "Installing Starship..."
	curl -sS https://starship.rs/install.sh | sh
fi

# Install Plugins (autosuggestions and syntax-highlighting)

# Check if zsh-autosuggestions and zsh-syntax-highlighting are installed
if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
	echo "zsh-autosuggestions is already installed"
else
	echo "Installing zsh-autosuggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Check if zsh-syntax-highlighting is installed
if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
	echo "zsh-syntax-highlighting is already installed"
else
	echo "Installing zsh-syntax-highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Copie my custom zshrc file
cp .zshrc ~/.zshrc

# Set zsh as default z-shell
if [[ $(which zsh) == "/bin/zsh" ]]; then
	echo "zsh is already set as default shell"
else
	echo "Setting zsh as default shell..."
	chsh -s $(which zsh)
fi

# Add the line sh -c "$(starship init zsh)" to ~/.zshrc
echo "Adding starship init to .zshrc..."
echo 'eval "$(starship init zsh)"' >>~/.zshrc

# Create a new config files Startship and set the theme tokyo-night
if [ -f ~/.config/starship.toml ]; then
	echo "starship.toml already exists"
else
	echo "Creating starship.toml, and presetting it tokyo-night theme..."
	mkdir -p ~/.config && touch ~/.config/starship.toml
	starship preset tokyo-night -o ~/.config/starship.toml
fi

echo "All Done!"
echo "Please restart your terminal and enjoy the new shell!"
