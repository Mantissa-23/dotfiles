# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ANTIGEN_LOG=~/.log/antigen.log

if [[ $(uname -s) == Darwin ]]
then
  source $(brew --prefix)/share/antigen/antigen.zsh
else
  source ~/.config/zsh/antigen.zsh
fi

antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

[[ -f ~/.aliases ]] && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
