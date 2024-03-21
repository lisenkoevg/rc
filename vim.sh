#!/bin/bash -

# vimExe=$(echo $0 | grep -o gvim)
# vimExe=${vimExe:-vim}
vimExe=gvim
args="${@/~/c:/cygwin64/home/Evgen}"
cygstart c:/Users/Evgen/Documents/Vim/vim90/$vimExe.exe "$args"

# ln -s /cygdrive/c/bin/vim.sh /bin/gvim
# ln -s /cygdrive/c/bin/vim.sh /bin/vim
