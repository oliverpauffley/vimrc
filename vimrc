" install vimplug if it's not already there.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged') 


" General Plugins
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf'
Plug 'preservim/nerdtree'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mileszs/ack.vim'
Plug 'vimwiki/vimwiki'

" Visuals
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git Plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Language Plugins
Plug 'fatih/vim-go'
Plug 'vim-scripts/c.vim'
Plug 'lifepillar/pgsql.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'shmup/vim-sql-syntax'
Plug 'lervag/vimtex'
Plug 'pangloss/vim-javascript'
Plug 'bufbuild/vim-buf'
Plug 'stephpy/vim-yaml'

" Lint and code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'


" Initialize plugin system
call plug#end()

"----------------------------------------------------------------------
" Leader key
let mapleader = "\\"

" Clear search with ctrl l
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" vim-go
"----------------------------------------------------------------------
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1

" Test func with \ t
autocmd FileType go nmap <leader>t <Plug>(go-test-func)
" Test file with \ T
autocmd FileType go nmap <leader>T <Plug>(go-test)
" Use \ q to close quickfix.
nnoremap <leader>q :cclose<CR>

" Ale setting
" -------------------------------------------------------------------- 
let g:ale_linters = {
\   'go': ['golangci-lint --disable= wsl, deadcode'],
\   'tex': ['chktex'],
\   'proto': ['buf-check-lint',],
\   'sql': ['sqlint',],
\   'python': ['flake8', 'pylint'],
\   'vue': ['eslint'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'sql': ['pgformatter',],
\   'python': ['black','reorder-python-imports'],
\   'javascript': ['prettier'],
\   'vue': ['prettier'],
\   'json': ['jq']
\}

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1

" navigate to errors with ctrl j + k
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" FZF and Ag searching 
"----------------------------------------------------------------------
"search with \ s
nmap <silent><leader>s :FZF<cr>

" use ag for searching inside files with :ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Coc settings
"----------------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction 
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


let g:ClangFormatAutoEnable=1

" set colourschemes
colorscheme gruvbox
set bg=dark
let g:gruvbox_contrast_dark = 1 

" VimWiki
let g:vimwiki_ext = '.md' " set extension to .md
let g:vimwiki_list = [{'path': '~/notes/'}]

" Airline options
let g:airline#extensions#coc#enabled = 1
let g:airline_theme='gruvbox'

" general options and autoline numbers
set nocompatible
filetype plugin on
filetype indent on
syntax on
set hlsearch 

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" comments in italics
highlight Comment cterm=italic gui=italic

" Change cursor 
let &t_SI = "\e[4 q"
let &t_EI = "\e[2 q"
set termguicolors

" vimtex
let g:tex_flavor = 'latex'

" for json and jsonnet files dont make a .swp file
autocmd FileType json,jsonnet setlocal nowritebackup noswapfile nobackup

" NERDTree settings
"---------------------------------------------------------------------------------
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1 
nnoremap <Leader>f :NERDTreeToggle<Enter>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Vim Markdown
" ________________________________________________________________________________
let g:vim_markdown_folding_disabled = 1
let vim_markdown_preview_github=1

" Split settings
" ________________________________________________________________________________
set splitbelow splitright
" resize windows with CTRL + Up, Down, Left, Right
nnoremap <silent> <S-Left> :vertical resize +3<CR>
nnoremap <silent> <S-Right> :vertical resize -3<CR>
nnoremap <silent> <S-Up> :resize +3<CR>
nnoremap <silent> <S-Down> :resize -3<CR>
