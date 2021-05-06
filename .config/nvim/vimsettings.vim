function StripTrailingWhitespace()
    " dont strip on these filetypes
    if &ft =~ 'vim'
        return
    endif
    let save_cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", save_cursor)
endfunction

set nocompatible

" leader key
let mapleader = "\\"

" extra room for lint messages
set cmdheight=2

" auto reload file contents when they change on disk
set autoread

" ignore .DS_Store and shit like that
set wildignore+=*.DS_Store

" enable mouse cursor movement
set mouse=a

" Minimal automatic indenting for any filetype.
set autoindent

" Proper backspace behavior.
set backspace=indent,eol,start

" ensure 8 line buffer above and below cursor
set scrolloff=8

" strip trailing whitespace on save
autocmd BufWritePre * call StripTrailingWhitespace()

" add @, -, and $ as keywords for full SCSS support
set iskeyword+=@-@
set iskeyword+=-
set iskeyword+=$

" set tab width
" shiftwidth=0 makes it default to same as tabstop
set shiftwidth=0
set tabstop=2
set expandtab "this gets overridden by vim sleuth when necessary, but use spaces by default

" when splitting panes, put new one on the right/bottom, instead of left/top
set splitbelow
set splitright

"enable line wrapping with left and right cursor movement
set whichwrap+=<,>,h,l,[,]

" show the sign column always so the layout doesn't shift when signs are
" added
set signcolumn=yes

" Enable more than one unsaved buffer
set hidden

" show line numbers
set number

" persistent undo
set undofile
set undodir=~/.vim/undodir

" use system clipboard
set clipboard=unnamedplus

" command-line autocompletion
set wildmenu

" disable line wrapping
set nowrap

" set default file encoding
set enc=utf-8
set encoding=utf-8
set fileencoding=utf-8

" if using vimdiff, show vertically
set diffopt=vertical
