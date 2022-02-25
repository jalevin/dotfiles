DOTFILES_DIR=${HOME}/projects/dotfiles
PATH := ${DOTFILES_DIR}/bin:${PATH}

PHONY: test

all: xcode packages

xcode:
	sudo softwareupdate -i -a
	xcode-select --install || true

packages: brew brew-packages cask-apps neovim-bootstrap link

brew:
	which brew || install-brew

install-brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ${HOME}/.zprofile

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

link:
	ln -F -s ${DOTFILES_DIR}/configs/gitconfig ${HOME}/.gitconfig
	ln -F -s ${DOTFILES_DIR}/configs/zshrc ${HOME}/.zshrc
	ln -F -s ${DOTFILES_DIR}/configs/tmux.conf ${HOME}/.tmux.conf
	ln -F -s ${DOTFILES_DIR}/configs/gemrc ${HOME}/.gemrc
	ln -F -s ${DOTFILES_DIR}/configs/init.vim ${HOME}/.config/nvim/init.vim

neovim-bootstrap:
	sh -c 'curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	# python required for leaderF
	python3 -m pip install --upgrade pip
	python3 -m pip install --user --upgrade pynvim
	nvim --headless +PlugInstall +qall
	nvim --headless +LeaderfInstallCExtension +qall
	nvim --headless +GoInstallBinaries +qall

iterm2:
	# Specify the preferences directory
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${DOTFILES_DIR}/configs/iterm2"
	# Tell iTerm2 to use the custom preferences in the directory
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
