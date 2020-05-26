set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'fatih/vim-go'
Plugin 'othree/html5.vim'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'digitaltoad/vim-pug'
Plugin 'rr-/vim-hexdec'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'jwalton512/vim-blade'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Basics
syntax on
set nowrap " Don't wrap lines
set shiftwidth=2 
set expandtab
set softtabstop=0
set tabstop=2
set smarttab
set backspace=indent,eol,start " Allow backspace anywhere
set number " Show line numbers
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/node_modules,*/dist " Ignore this stuff
colorscheme peachpuff " Theme
let mapleader = "\<Space>" " Set Leader to <SPACE>

" Highlight at 80 characters with an annoying red line
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

" Backups
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Shortcuts
nnoremap <Leader>w :w<CR> " Leader,w to save
 
" Moving line(s) around
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>== " Normal mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi " Insert mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv " Visual mode


" =============== CTRL-P ====================================
let g:ctrlp_working_path_mode = 0

" =============== Vim Airline Settings =======================
" let g:airline#extensions#tabline#enabled = 1 " Show all buffers when # of tabs == 1
let g:airline_theme='base16_colors'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_a = airline#section#create(['mode',' ','branch'])
let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
let g:airline_section_c = airline#section#create(['filetype'])
let g:airline_section_x = airline#section#create(['%P'])
let g:airline_section_y = airline#section#create(['%B'])
let g:airline_section_z = airline#section#create_right(['%l', '%c'])
let g:airline_powerline_fonts = 1 " Use patched fonts
set laststatus=2 " Show airline immediately


" ============= NERDTree Toggle Settings =====================

" Open up NERDTree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" CTRL-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Close vim if NERDTree is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ============= Vim JSX Settings =====================
let g:jsx_ext_required = 0

" ============= Syntastic Settings =====================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ============= Vim-Go Settings =====================let
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Stop opening ctrlP in NERDTree
function! CtrlPCommand()
    let c = 0
    let wincount = winnr('$')
    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    exec 'CtrlP'
endfunction

let g:ctrlp_cmd = 'call CtrlPCommand()'

" CtrlP - Respect .gitignore for search
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]
