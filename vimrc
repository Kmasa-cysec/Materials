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
"Plug 'tpope/vim-fugitive'
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
Plug 'lambdalisue/fern.vim'
" カラースキーム
Plug 'morhetz/gruvbox'
" Lsp関連のプラグイン
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Language
Plug 'OmniSharp/omnisharp-vim'
Plug 'rust-lang/rust.vim'
call plug#end()

" setting vim
if !has('nvim')
  set backspace=indent,eol,start
endif

"syntax enable
filetype plugin indent on

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


inoremap <silent> jj <Esc>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Fern自動起動
augroup __fern__
  autocmd!
  autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%
augroup END

nnoremap <C-n> :Fern . -drawer -stay -keep -toggle -reveal=%<cr>

" Rustの設定
let g:rustfmt_autosave = 1

" OmniSharpの設定
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :                                                                                                                    
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

nnoremap <gf> :OmniSharpFindUsages<CR>
nnoremap <gd> :OmniSharpGotoDefinition<CR>
nnoremap <gp> :OmniSharpPreviewDefinition<CR>
nnoremap <gr> :!dotnet run

let g:OmniSharp_server_type='roslyn'
let g:OmniSharp_server_path = '/Path/To/OmniSharp.exe'
let g:OmniSharp_server_use_mono = 1
