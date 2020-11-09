# dotfiles

+ clone as bare repository
`git clone --bare https://github.com/USERNAME/dotfiles.git $HOME/.dotfiles-git`

+ add alias if needed
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'`

+ checkout content
`dotfiles checkout`
