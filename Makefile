DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := ${PATH}

XDG_CONFIG_HOME=${HOME}/.config
XDG_DATA_HOME=${HOME}/.local/share
XDG_CACHE_HOME=${HOME}/.cache
CLAUDE_HOME=${HOME}/.claude

PHONY: test

all: xcode packages settings

xcode:
	sudo softwareupdate -i -a
	sxcode-select --install || true

packages: brew-install brew link install-typescript update-go neovim-setup

settings: osx-settings

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
	# XDG configs — symlink whole directory where possible
	mkdir -p ${XDG_CONFIG_HOME}/git
	ln -F -s ${DOTFILES_DIR}/configs/git/config ${XDG_CONFIG_HOME}/git/config
	ln -F -s ${DOTFILES_DIR}/configs/git/ignore ${XDG_CONFIG_HOME}/git/ignore
	ln -F -s ${DOTFILES_DIR}/configs/tmux ${XDG_CONFIG_HOME}/tmux
	ln -F -s ${DOTFILES_DIR}/configs/nvim ${XDG_CONFIG_HOME}/nvim
	ln -F -s ${DOTFILES_DIR}/configs/agent-deck ${XDG_CONFIG_HOME}/agent-deck
	ln -F -s ${DOTFILES_DIR}/configs/k9s ${XDG_CONFIG_HOME}/k9s
	ln -F -s ${DOTFILES_DIR}/configs/hive ${XDG_CONFIG_HOME}/hive
	ln -F -s ${DOTFILES_DIR}/configs/ripgrep ${XDG_CONFIG_HOME}/ripgrep
	ln -F -s ${DOTFILES_DIR}/configs/ghostty ${XDG_CONFIG_HOME}/ghostty
	# Claude — uses ~/.claude (not XDG); symlink individual files since Claude
	# writes dynamic content (sessions, memory, todos) to the same directory
	mkdir -p ${CLAUDE_HOME}
	ln -F -s ${DOTFILES_DIR}/configs/claude/settings.json ${CLAUDE_HOME}/settings.json
	ln -F -s ${DOTFILES_DIR}/configs/claude/statusline.sh ${CLAUDE_HOME}/statusline.sh
	ln -F -s ${DOTFILES_DIR}/configs/claude/agents ${CLAUDE_HOME}/agents
	ln -F -s ${DOTFILES_DIR}/configs/claude/commands ${CLAUDE_HOME}/commands
	# Legacy dotfile locations
	ln -F -s ${DOTFILES_DIR}/configs/zshrc ${HOME}/.zshrc
	ln -F -s ${DOTFILES_DIR}/configs/gemrc ${HOME}/.gemrc
	ln -F -s ${DOTFILES_DIR}/configs/sqliterc ${HOME}/.sqliterc

neovim-setup:
	nvim --headless "+Lazy! sync" +qa

neovim-reset:
	rm -rf ${XDG_DATA_HOME}/nvim/lazy ${XDG_DATA_HOME}/nvim/lazy-rocks

install-typescript:
	# adds language server. have to use npm, not yarn
	npm install --global typescript

osx-settings:
	${DOTFILES_DIR}/install/macos

update-go:
	brew update
	brew upgrade go
	cd /tmp; \
		go install golang.org/x/tools/gopls@latest; \
		go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
		go install github.com/nametake/golangci-lint-langserver@latest
		go install github.com/grafana/jsonnet-language-server@latest
	#	go install github.com/colonyops/hive@latest

