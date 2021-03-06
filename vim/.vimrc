set nocompatible
set encoding=utf-8

execute pathogen#infect()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set clipboard=unnamed             " Allow access to clipboard

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight the line of the cursor

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set updatecount=0

set expandtab                     " Use spaces, not tabs
set tabstop=2                     " A tab is two spaces
set shiftwidth=2                  " An autoindent (with <<) is two spaces

" Indicator chars
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\

" Auto-reload buffers when file changed on disk
set autoread

" rvm fix
set shell=/bin/sh

" Do not highlight syntax for long lines
set synmaxcol=300
" set colorcolumn=120

" ESC to shift zsh issue fix
set ttimeoutlen=0

set background=dark
colorscheme railscasts

if has("autocmd")
  " Avoid showing trailing whitespace when in insert mode
  au InsertEnter * :set listchars-=trail:•
  au InsertLeave * :set listchars+=trail:•

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " set .h, .m file types to Objective-C
  au BufNewFile,BufRead *.{h,m} set ft=objc

  " set .podspec, .podfile file types to ruby
  au BufNewFile,BufRead *.podspec,Podfile set ft=ruby

  " Objective-C identation settings
  au FileType objc set softtabstop=4 tabstop=4 shiftwidth=4

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " magic markers: enable using `H/S/J/C to jump back to
  " last HTML, stylesheet, JS or Ruby code buffer
  au BufLeave *.{erb,html}      exe "normal! mH"
  au BufLeave *.{css,scss,sass} exe "normal! mS"
  au BufLeave *.{js,coffee}     exe "normal! mJ"
  au BufLeave *.{rb}            exe "normal! mC"

  " Automatically removing all trailing whitespace
  au BufWritePre * :%s/\s\+$//e
endif

" Spell check
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb

" removed curly braces error for obj-c blocks
let c_no_curly_error = 1

" clang_complete settings
let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
let g:clang_auto_user_options="compile_commands.json, path, .clang_complete"
let g:clang_complete_auto = 0
let g:clang_periodic_quickfix = 0
let g:clang_close_preview = 1
" For Objective-C, this needs to be active, otherwise multi-parameter methods won't be completed correctly
let g:clang_snippets = 1
let g:clang_auto_select = 1
" Snipmate does not work anymore, ultisnips is the recommended plugin
let g:clang_snippets_engine = 'ultisnips'
" show diagnostics
nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>
let g:clang_complete_copen = 1
nnoremap <leader>c :cc<cr>

" ctrl-p settings
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CtrlP %%<cr>
map <leader>b :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = { 'dir': '\v(build|Pods|node_modules|components|bundle|vendor|_site|bin)$' }
let g:ctrlp_root_markers = ['.git', '.ctrlp']

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" toggle between last open buffers
nnoremap <leader><leader> <c-^>

" a.vim setting for objc
let g:alternateExtensions_m = "h"
let g:alternateExtensions_h = "m"

set splitright
set splitbelow

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" status linen settings
if has("statusline") && !&cp
  set laststatus=2              " always show the status bar
  set statusline=%f\ %m\ %r     " filename, modified, readonly
  set statusline+=%{fugitive#statusline()}
  set statusline+=\ %l/%L[%p%%] " current line/total lines
  set statusline+=\ %v[0x%B]    " current column [hex char]
  set statusline+=%{SyntaxItem()}
endif

" Dash.app integration
:nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = { 'objc': 'iphoneos' }

" Tabularize mappings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" smart square brackets for objc methods
imap <C-]> <Esc>yss]$i

" :Gstatus
nmap <leader>g :Gstatus<CR>

" Code completion
inoremap <C-k> <C-x><C-u>

" Objective-C related tasks bindings
nmap <leader>x :!rake xcode_build<CR>
nmap <leader>r :!rake simulator<CR>
nmap <leader>ll :!rake debug<CR>
nmap <leader>cl :!rake clang_db<CR>

" Rail.vim bindings
nmap <leader>t :Rrunner<CR>

" vim-lldb mappings
noremap <leader>po :Lpo<CR>
noremap <leader>pO :LpO<CR>
noremap <leader>lb :Lbreakpoint<CR>
noremap <leader>lc :Lcontinue<CR>
noremap <leader>ls :Lstep<CR>
noremap <leader>ln :Lnext <CR>

" ligthline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

" trailing whitespace
set list listchars=tab:→\ ,trail:·
set list

" syntastic
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_ruby_checkers = ['rubocop']
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
