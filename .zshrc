# Powerlevel10k instant prompt (must stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH
export PATH="$HOME/.local/bin:$HOME/.docker/bin:$HOME/bin:$HOME/.composer/vendor/bin:$PATH"

# Oh My Zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git docker docker-compose)
source "$ZSH/oh-my-zsh.sh"

# Environment
export LANG=en_US.UTF-8
export EDITOR='vim'

# Shell config
source "$HOME/.aliases"
source "$HOME/.functions"
source "$HOME/.directories"
source "$HOME/.leedya"

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Homebrew (manual setup — avoids slow path_helper)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fpath[1,0]="/opt/homebrew/share/zsh/site-functions"
export MANPATH="/opt/homebrew/share/man:${MANPATH:-}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# fzf (Ctrl+T: files, Ctrl+R: history, Alt+C: cd)
source <(fzf --zsh)

# zoxide (smart cd)
eval "$(zoxide init zsh)"
