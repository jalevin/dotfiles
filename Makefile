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
	ln -F -s ${DOTFILES_DIR}/configs/sqliterc ${HOME}/.sqliterc
	ln -F -s ${DOTFILES_DIR}/configs/gitconfig ${HOME}/.gitconfig
	ln -F -s ${DOTFILES_DIR}/configs/gitignore ${HOME}/.gitignore
	ln -F -s ${DOTFILES_DIR}/configs/zshrc ${HOME}/.zshrc
	ln -F -s ${DOTFILES_DIR}/configs/tmux.conf ${HOME}/.tmux.conf
	ln -F -s ${DOTFILES_DIR}/configs/gemrc ${HOME}/.gemrc
	ln -F -s ${DOTFILES_DIR}/configs/init.vim ${HOME}/.config/nvim/init.vim
	ln -F -s ${DOTFILES_DIR}/configs/lua ${HOME}/.config/nvim/lua

neovim-bootstrap:
	sh -c 'curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	neovim-install-deps

neovim-install-deps: install-languageservers
	# adds language server. have to use npm, not yarn
	npm install --global typescript
	# handle plugin config
	nvim --headless +PlugInstall +qall
	nvim --headless +GoInstallBinaries +qall
	# fix language servers at some point
	#nvim --headless -c "MasonInstall lua-language-server rust-analyzer" -c qall


osx-settings:
	${DOTFILES_DIR}/install/macos

iterm2:
	# Specify the preferences directory
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${DOTFILES_DIR}/configs/iterm2"
	# Tell iTerm2 to use the custom preferences in the directory
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

update-go:
	brew update
	brew upgrade go
	cd /tmp; \
		go install golang.org/x/tools/gopls@latest; \
		go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
		go install github.com/nametake/golangci-lint-langserver@latest

install-languageservers: update-go
	# https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
	npm i -g yaml-language-server
	npm i -g @tailwindcss/language-server
	npm i -g intelephense
	npm install -g neovim
	# make sure using non-system ruby `rbenv global <version>`
	gem install neovim
	go install github.com/grafana/jsonnet-language-server@latest
	composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
