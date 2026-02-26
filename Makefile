DOTFILES_DIR=${HOME}/projects/dotfiles
PATH := ${DOTFILES_DIR}/bin:${PATH}

XDG_CONFIG_HOME=${HOME}/.config
XDG_DATA_HOME=${HOME}/.local/share
XDG_CACHE_HOME=${HOME}/.cache

PHONY: test

all: xcode packages settings

xcode:
	sudo softwareupdate -i -a
	sxcode-select --install || true

packages: brew-install brew link neovim-bootstrap update-go

settings: iterm2 osx-settings

install-fonts:
	cp $(DOTFILES_DIR)/fonts/*.ttf ~/Library/Fonts

brew-install:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
		echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ${HOME}/.zprofile

brew:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

brew-empty:
	brew remove --force $(brew list --formula) --ignore-dependencies

brew-dump:
	mv $(DOTFILES_DIR)/install/Brewfile $(DOTFILES_DIR)/install/Brewfile.old
	brew bundle dump --file=$(DOTFILES_DIR)/install/Brewfile

link:
	mkdir -p ${XDG_CONFIG_HOME}/nvim/
	mkdir -p ${XDG_CONFIG_HOME}/1Password/ssh
	mkdir -p ${XDG_CONFIG_HOME}/agent-deck
	mkdir -p ${XDG_CONFIG_HOME}/ghostty
	mkdir -p ${HOME}/.claude
	mkdir -p ${HOME}/Library/Application Support/xbar/plugins
	#ln -F -s ${DOTFILES_DIR}/configs/agent.toml ${XDG_CONFIG_HOME}/1Password/ssh
	ln -F -s ${DOTFILES_DIR}/configs/sqliterc ${HOME}/.sqliterc
	mkdir -p ${XDG_CONFIG_HOME}/git
	ln -F -s ${DOTFILES_DIR}/configs/git/config ${XDG_CONFIG_HOME}/git/config
	ln -F -s ${DOTFILES_DIR}/configs/git/ignore ${XDG_CONFIG_HOME}/git/ignore
	ln -F -s ${DOTFILES_DIR}/configs/zshrc ${HOME}/.zshrc
	ln -F -s ${DOTFILES_DIR}/configs/tmux ${XDG_CONFIG_HOME}/tmux
	ln -F -s ${DOTFILES_DIR}/configs/gemrc ${HOME}/.gemrc
	ln -F -s ${DOTFILES_DIR}/configs/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
	ln -F -s ${DOTFILES_DIR}/configs/lua ${XDG_CONFIG_HOME}/nvim/lua
	#ln -F -s ${DOTFILES_DIR}/configs/op ${XDG_CONFIG_HOME}/op
	ln -F -s ${DOTFILES_DIR}/configs/claude/settings.json ${HOME}/.claude/settings.json
	ln -F -s ${DOTFILES_DIR}/configs/claude/statusline.sh ${HOME}/.claude/statusline.sh
	ln -F -s ${DOTFILES_DIR}/configs/claude/agents ${HOME}/.claude/agents
	ln -F -s ${DOTFILES_DIR}/configs/agent-deck-config.toml ${XDG_CONFIG_HOME}/agent-deck/config.toml
	ln -F -s ${DOTFILES_DIR}/configs/hive ${XDG_CONFIG_HOME}/hive
	ln -F -s ${DOTFILES_DIR}/configs/ripgrep ${XDG_CONFIG_HOME}/ripgrep
	ln -F -s ${DOTFILES_DIR}/configs/ghostty/config ${XDG_CONFIG_HOME}/ghostty/config
	#ln -F -s ${DOTFILES_DIR}/configs/xbar/* "${HOME}/Library/Application Support/xbar/plugins"

neovim-plug:
	sh -c 'curl -fLo ${XDG_DATA_HOME}/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

neovim-bootstrap: neovim-plug neovim-install-deps

neovim-install-deps: install-languageservers
	go install github.com/grafana/jsonnet-language-server@latest
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

#install-languageservers: update-go
#	# https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
#	npm i -g yaml-language-server
#	npm i -g @tailwindcss/language-server
#	npm i -g intelephense
#	npm install -g neovim
#	# make sure using non-system ruby `rbenv global <version>`
#	gem install neovim
#	go install github.com/grafana/jsonnet-language-server@latest
#	composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
