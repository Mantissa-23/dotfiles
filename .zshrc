# Path to your oh-my-zsh installation.
#plugins=(zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dylan/.build/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dylan/.build/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dylan/.build/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dylan/.build/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
