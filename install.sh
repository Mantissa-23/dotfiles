git clone --bare https://github.com/Mantissa-23/dotfiles $HOME/.cfg
function config {
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $?=0  ]; then
    echo "Checked out config.";
else
    echo "Backing up preexisting dot files to .config-backup.";
    config checkout 2>$1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
