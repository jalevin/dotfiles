# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt nomatch
unsetopt appendhistory autocd beep extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jefe/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

#ssh forwarding
/usr/bin/ssh-add -k /Users/Jefe/.ssh/id_rsa

# text highlighting
export PS1="%10F%m%f:%11F%1~%f \$ "
export CLICOLOR=1
export HOMEBREW_GITHUB_API_TOKEN="ea146b5cef777f50d0078d34149cfe4b5acfdb34"
export TERM=xterm-256color
export EDITOR="nvim"

# rails
export PATH="$HOME/.rbenv/shims:/usr/local/sbin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# go
export GOPATH="$HOME/projects/go"
export PATH="$HOME/projects/go/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig"

# python
#export PATH="$HOME/.pyenv/shims:/usr/local/sbin:$PATH"
#eval "$(pyenv init -)"

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

# add autopoint to path for libpff build
export PATH=${PATH}:/usr/local/opt/gettext/bin

# add python scripts
export PATH=${PATH}:/Users/jefe/Library/Python/3.7/bin
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# ???
export CGO_CFLAGS_ALLOW='-Xpreprocessor'
export PYTHON_CONFIGURE_OPTS="--enable-framework"
export PYTHONPATH=/usr/local/lib/python3.7/site-packages

#ssh autocomplete
#zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# aws
export PATH=/usr/local/opt/awscli:$PATH
source /usr/local/opt/awscli/share/zsh/site-functions/aws_zsh_completer.sh
#complete -C '/usr/local/bin/aws_completer' aws
#source /usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh


# system
alias vim="nvim"
alias less="less -N"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cpu_usage="watch \"ps -Ao user,uid,comm,pid,pcpu,tty -r | head -n 6\""

#alias clear_vim_swap="find . -type f -name ".*.sw[klmnop]" -delete"
#alias vi="nvim -Nu"

alias git_loc="git ls-files | while read f; do git blame -w -M -C -C --line-porcelain \"$f\" | grep -I '^author '; done | sort -f | uniq -ic | sort -n"
alias cleandocker="docker system prune -f"

# rails
alias cap="bundle exec cap"
alias rake="bundle exec rake"
alias rails="bundle exec rails"
alias rspec="bundle exec rspec"
alias guard="bundle exec guard"
#alias killpuma="ps -l | awk '/puma/ {print $2}' | xargs kill -9"
alias killpuma="pgrep puma 3 | xargs kill -9"

# php - only used for bash
#export WP_CLI_PHP="/Applications/MAMP/bin/php/php5.6.10/bin/php"
#source /Users/jefe/support_scripts/wp-completion.bash

# command history for zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

