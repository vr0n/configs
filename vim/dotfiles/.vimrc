" Vundle configs
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'zah/nim.vim'

" all plugins must be added before these lines
call vundle#end()
filetype plugin indent on

" color
color pablo

" remaps
imap jj <esc>

" line configs
set nu

" syntax
syntax on

" spellcheck
set spell spelllang=en_us
hi SpellBad ctermfg=none ctermbg=none cterm=underline
hi SpellLocal ctermfg=185 ctermbg=88 cterm=none
hi SpellCap ctermfg=none ctermbg=235 cterm=none

"set cursorline
"set cursorcolumn
"hi clear CursorLine
"hi link CursorLine CursorColumn
map ,s :s/ /-/ge\|s/./&̶/g<CR>
map ,u :s/./&̲̲/g\|/̲̲ / /ge<CR>
set encoding=utf-8

" others
map ZW :w!<CR>
