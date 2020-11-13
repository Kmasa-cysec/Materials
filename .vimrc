scriptencoding utf-8

if has('vim_starting') " Changing encoding in Vim at runtime is undefined behavior.
  set fileencodings=utf-8,sjis,cp932,euc-jp
  set fileformats=unix,mac,dos
endif

" setting vim-plug
call plug#begin('~/.vim/plugged')
" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'
" シンタックスハイライト
Plug 'sheerun/vim-polyglot'
" インクリメンタルサーチ
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" テキストオブジェクト
Plug 'easymotion/vim-easymotion'
" インターフェース改善
Plug 'itchyny/vim-cursorword'
" url見やすくする
Plug 'tyru/open-browser.vim'
" ファイラ
Plug 'cocopon/vaffle.vim'
" カラースキーム
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'ghifarit53/tokyonight-vim'
" Lsp関連のプラグイン
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'lambdalisue/gina.vim'

Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}

Plug 'rust-lang/rust.vim'
call plug#end()

" setting vim
if !has('nvim')
  set backspace=indent,eol,start
endif

"syntax enable
filetype plugin indent on

set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

syntax enable
colorscheme gotham

set number
set autoindent
set smartindent
" インクリメンタルサーチ
set incsearch
set nobackup
set noswapfile

if has('mouse')
  set mouse=a
endif

if &t_Co != 256
  set t_Co=256
endif

" ファイルタイプごとにインデントを設定
augroup MyFileTypeIndentOverRide
  autocmd!
  autocmd FileType py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" vimのキーバインド設定
nnoremap <ESC><ESC> :nohlsearch<CR>

if has('terminal')
  tnoremap <silent><C-u> <C-\><C-N>
endif
"スペースをトリガーにする
let mapleader = "\<Space>"

noremap <Leader>t :terminal<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>

" インデントを一括で行う
function s:Indent()
  let save_cursor = getcurpos()
  execute "normal " . "gg=G"
  call setpos('.', save_cursor)
endfunction

" インデントコマンドを定義
command -nargs=0 Indent call s:Indent()

" setting vim-airline
set ttimeoutlen=10
let g:airline_extensions = ['branch', 'fzf', 'tabline']

" setting vim-lsp
nnoremap <expr> <silent> <C-]> execute(':LspDefinition') =~ "not supported" ? "\<C-]>" : ":echo<cr>"

" setting open-blowser.vim
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" setting fzf
let g:fzf_layout = { 'window': '10new' }

" setting vaffle
function! RenderMyFavoriteIcon(item) abort
  return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
endfunction
let g:vaffle_render_custom_icon = 'RenderMyFavoriteIcon'

nnoremap <silent><leader>crd :QuickRun<CR>  " キーマップの設定
let g:quickrun_config = {}

let g:rustfmt_autosave = 1

inoremap <silent> jj <Esc>
inoremap <silent> っj <Esc>

inoremap <C-j> <Down> 
inoremap <C-k> <Up> 
inoremap <C-h> <Left> 
inoremap <C-l> <Right>

let g:lsp_diagnostics_echo_cursor = 1
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
endfunction
