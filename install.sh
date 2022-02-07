DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -s $DIR/.emacs ~/.emacs
ln -s $DIR/.emacs.d ~/.emacs.d
ln -s $DIR/.bashrc ~/.bashrc
ln -s $DIR/.bash_profile ~/.bash_profile

mkdir -p ~/.config/i3
ln -s $DIR/i3.config ~/.config/i3/config
