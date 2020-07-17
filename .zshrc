source ~/.config/zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme powerlevel10k/powerlevel10k

antigen apply

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

test -f ~/.aliases && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
