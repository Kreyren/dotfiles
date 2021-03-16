call plug#begin(stdpath('data') . '/plugged')

Plug 'mrjones2014/space-vim-theme'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-sleuth'

Plug 'tpope/vim-commentary'

Plug 'APZelos/blamer.nvim'

Plug 'blueyed/vim-diminactive'

Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'

Plug 'mhinz/vim-startify'

Plug 'Yggdroot/indentLine'

Plug 'farmergreg/vim-lastplace'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
