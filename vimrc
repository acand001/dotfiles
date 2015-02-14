call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/rainbow_parentheses.vim'

" Edit
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'rizzatti/dash.vim'

" Visual
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'

" Movement
Plug 'Lokaltog/vim-easymotion'
Plug 'bkad/CamelCaseMotion'

" Git
Plug 'airblade/vim-gitgutter'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

" Arduino
Plug 'tclem/vim-arduino'

call plug#end()

"----------------------------------------[Basic settings]----------------------------------------

" No Vi compatibility mode
set nocompatible

" Plugin on indent on filetype detection on
filetype plugin indent on

set encoding=utf-8
scriptencoding utf-8

syntax enable
set background=dark
colorscheme solarized

set clipboard=unnamed
set formatoptions-=cro

"Return cursor to previous position on load
autocmd BufReadPost * normal `""`

augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

let g:mapleader=","

"Changing movement to be like emacs
map <C-e> $
map <C-a> ^
imap <C-e> <ESC>$a
imap <C-a> <ESC>^i

"Adding newlines without entering insert mode
nmap O O<Esc>
nmap o o<Esc>k

" Sign Column made by solarized color is strange, clear it.
highlight clear SignColumn
" vim-gitgutter will use Sign Column to set its color, reload it.
call gitgutter#highlight#define_highlights()"

"---------------------------------------[Plugin Settings]----------------------------------------
"--------[Sensible]--------
runtime! plugin/sensible.vim
set mouse=""
set noshowmode
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

"--------[IndentLine]--------
let g:indentLine_char = '¦'

"--------[Neocomplete]--------
let g:neocomplete#enable_at_startup = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"--------[EasyMotion]--------
" Disable default mapping
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
nmap s <Plug>(easymotion-s)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0

"---------[tcomment]--------
vmap <Leader>c :TComment<CR>
nmap <Leader>c :TComment<CR>

"--------[Tmuxline]--------
let g:tmuxline_preset = {'a'    : '#W',
                        \'y'    : '#W %R'}

"--------[Airline]--------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 1

"--------[Arduino]--------
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

"--------[RainbowParen]--------
au VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['"', '"']]
let g:rainbow#max_level = 16
