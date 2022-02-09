DOTFILES_DIR=${HOME}/projects/dotfiles
PATH := ${DOTFILES_DIR}/bin:${PATH}

PHONY: test

all: xcode packages

xcode:
	sudo softwareupdate -i -a
	xcode-select --install || true

packages: brew brew-packages cask-apps link

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
	ln -F -s ${PWD}/gitconfig ${HOME}/.gitconfig
	ln -F -s ${PWD}/zshrc ${HOME}/.zshrc
	ln -F -s ${PWD}/tmux.conf ${HOME}/.tmux.conf
	ln -F -s ${PWD}/gemrc ${HOME}/.gemrc
	ln -F -s ${PWD}/init.vim ${HOME}/.config/nvim/init.vim
	ln -F -s ${PWD}/vim.vimrc ${HOME}/.vim.vimrc
	ln -F -s ${PWD}/default.vimrc ${HOME}/.vimrc
	ln -F -s ${PWD}/vscode.vimrc ${HOME}/.vscode.vimrc
