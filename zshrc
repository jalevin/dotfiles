# DOCS - http://zsh.sourceforge.net/Doc/Release/Options.html

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=100000

setopt hist_expire_dups_first # remove duplicate from beginning of history
setopt hist_find_no_dups      # don't show dups when searching history
setopt hist_verify            # perform command expansion then run
setopt inc_append_history     # append history

#setopt nomatch                # not sure why I had this
#setopt append_history        # share history between terminals immediately

unsetopt autocd beep extendedglob notify

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jefe/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH="$HOME/bin:$PATH"

# temporary build for nvim since brew is outdated
export PATH="$HOME/nvim/bin:$PATH"


#ssh forwarding
/usr/bin/ssh-add -k /Users/Jefe/.ssh/id_rsa

# text highlighting
export PS1="%10F%m%f:%11F%1~%f \$ "
export CLICOLOR=1
export HOMEBREW_GITHUB_API_TOKEN="ea146b5cef777f50d0078d34149cfe4b5acfdb34"
export TERM=xterm-256color
export EDITOR="nvim"

# homebrew
export HOMEBREW_NO_ANALYTICS=1

# go
export GOPATH="$HOME/projects/go"
export PKG_CONFIG_PATH="/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig"
export CGO_CFLAGS_ALLOW='-Xpreprocessor'
export PATH="${PATH}:/usr/local/opt/gettext/bin"
export PATH="${PATH}:$GOPATH/bin"

godoc(){
		go doc -u "$@" | bat -l go
}

gosrc(){
    go doc -u -src "$@" | bat -l go
}
# add autopoint to path for libpff build

# docker
export DOCKER_ID_USER="levinology"

# cpan
PATH="/Users/jefe/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/jefe/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/jefe/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/jefe/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/jefe/perl5"; export PERL_MM_OPT;

# ansible path
export PATH="/usr/local/opt/ansible@2.0/bin:$PATH"
# psql path
export PATH="/usr/local/opt/libpq/bin:$PATH"

# node version manager config path
#export NVM_DIR="/Users/jefe/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# python
export PATH="$HOME/.pyenv/shims:/usr/local/sbin:$PATH"
alias python="python3"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
eval "$(pyenv init -)"
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# NOTE not sure if I need these
#export LDFLAGS="-L/usr/local/opt/readline/lib"
#export CPPFLAGS="-I/usr/local/opt/readline/include"
# add python scripts
# NOTE not sure if I should  be adding this version of python 3... probably let
# pyenv do this
#export PATH=${PATH}:/Users/jefe/Library/Python/3.7/bin
#export PATH="/usr/local/opt/libxml2/bin:$PATH"
#export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# aws
export PATH=/usr/local/opt/awscli:$PATH
source /usr/local/opt/awscli/share/zsh/site-functions/aws_zsh_completer.sh
alias aws-ident="aws sts get-caller-identity"

# system
alias cat="bat"
alias top="htop"
alias grep="rg"
alias ogrep="grep"
alias vim="nvim"
alias less="less -N"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cpu_usage="watch \"ps -Ao user,uid,comm,pid,pcpu,tty -r | head -n 6\""

#alias clear_vim_swap="find . -type f -name ".*.sw[klmnop]" -delete"
#alias vi="nvim -Nu"

alias git_loc="git ls-files | while read f; do git blame -w -M -C -C --line-porcelain \"$f\" | grep -I '^author '; done | sort -f | uniq -ic | sort -n"
alias gdiff="git --no-pager diff"

alias cleandocker="docker system prune -f"

# ruby
alias update_rbenv="brew update && brew upgrade ruby-build"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
serve() {
  if [ -n "$1" ]
  then
    ruby -run -ehttpd . -p$1
  else
    ruby -run -ehttpd . -p8080
  fi
}

export RUBYOPT="-W:no-deprecated"
alias old_ruby="RUBYOPT=\"\""

# rails
export PATH="$HOME/.rbenv/shims:/usr/local/sbin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
alias be="bundle exec"
alias ptest="PARALLELIZE_TESTS=true be rails test"
alias stest="PARALLELIZE_TESTS=true be rails test:system"

alias editvscode="vim \"/Users/$(whoami)/Library/Application Support/Code/User/settings.json\""

alias cap="be cap"
alias rake="be rake"
#alias rails="bundle exec rails"
alias rspec="be rspec"
alias guard="be guard"
#alias killpuma="ps -l | awk '/puma/ {print $2}' | xargs kill -9"
alias killpuma="pgrep puma 3 | xargs kill -9"
alias killruby="pgrep ruby 3 | xargs kill -9"
alias flushredis="redis-cli flushall"

alias fixgitk="rm ~/.config/git/gitk"

#make json pretty
pj(){
		echo $1 | jq
}

# php - only used for bash
#export WP_CLI_PHP="/Applications/MAMP/bin/php/php5.6.10/bin/php"
#source /Users/jefe/support_scripts/wp-completion.bash

# command history for zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

#Permiso
if [ -f ~/projects/permiso/shell_scripts.zsh ]; then
  source ~/projects/permiso/shell_scripts.zsh
else
  print "No permiso shell scripts found"
fi
