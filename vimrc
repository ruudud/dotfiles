" Configuration file for vim
"Kudos: Berge, xim, sjl

" Enabled file type detection
filetype off
filetype plugin indent on

syntax enable

let base16colorspace=256         " Access colors present in 256 colorspace
colorscheme base16-ocean

" Now we set some defaults for the editor
set omnifunc=syntaxcomplete#Complete
set background=dark
set termguicolors               " All the colors
set completeopt=menu            " Don't display preview window in addition to popup
set nobackup                    " Backup is for puppies
set nowritebackup
set cryptmethod=blowfish2       " Zip is too easy to crack
set noswapfile
set encoding=utf-8              " wtf-8
set autoindent                  " always set autoindenting on
set shiftwidth=4                " How many columns to insert with indent keys (<<)
set shiftround                  " Indent/outdent to nearest tabstops
set softtabstop=4               " How many columns to insert when pressing Tab-key
set tabstop=4                   " Number of coloumns to indent
set expandtab                   " Set spaces instead of <tab>
set smarttab                    " Insert blanks according to 'shiftwidth'
set wrap                        " Text wrapping on
set textwidth=79                " Wrap words by default
set colorcolumn=80              " Color long lines
set formatoptions=qrn1          " When to wrap text, and how
set modelines=0                 " Dont use modelines, disable to prevent security issues
set nocompatible                " Use Vim defaults instead of vi compatibility
set backspace=indent,eol,start  " more powerful backspacing
set wildmenu
set wildmode=list:longest       " File completion in a menu
set wildignore+=.git,.pyc       " Ignore some files
set cursorline                  " Indicate what line we are on
set ttyfast                     " We are on a quick terminal
set laststatus=2                " Show a statusline all the time
set relativenumber              " Show numbers in column
set ignorecase                  " Defaults on search
set smartcase                   " Smarter search when applying upper case letters
set nobackup                    " Don't keep a backup file
set viminfo='20,\"50            " read/write a .viminfo file, don't store more than 50 lines of registers
set hlsearch                    " Hilight last search
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set showmode                    " Show mode we are in
set visualbell                  " Blink, no sound
set pastetoggle=<F3>            " Press F3 to enter paste mode
set errorformat=%f:%l:\ %m      "
set scrolloff=3                 " Keep more context when scrolling
set title
set grepprg=rg\ --vimgrep\ --no-heading\ $*\ \`git\ rev-parse\ --show-toplevel\`
set grepformat=%f:%l:%c:%m,%f:%l:%m
syntax on                       " I like syntax hilight

" Suffixes that get lower priority when doing tab completion
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" And some variables..
let mapleader = ","

" Magic variables to get colors working in tmux
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Automatically cd into the directory that the opened file is in
au BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Sane regexp (very magical)
nnoremap / /\v
vnoremap / /\v

" redraw window so search terms are centered
nnoremap n nzz
nnoremap N Nzz

" Create header lines
nnoremap <leader>1 yypVr=
nnoremap <leader>2 yypVr-

" Clear hilights
nnoremap <leader><space> :noh<cr>

" Select recently pasted text
nnoremap <leader>v V`]

" Use tab to jump to next matching bracket
nnoremap <tab> %
vnoremap <tab> %

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" jj in insert mode mapped as Esc, and same with F1
inoremap jj <Esc>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" hh in insert mode mapped as Esc + Write
inoremap hh <Esc>:w<cr>

" xclip integration
vmap <F6> :!xclip -f -sel clip<CR>
inoremap <F7> <ESC>:-1r !xclip -o -sel clip<CR>i
nnoremap <F7> :+1r !xclip -o -sel clip<CR>

" Open current file in OS default
inoremap <F10> <ESC>:!xdg-open %<CR>
nnoremap <F10> :!xdg-open %<CR>

" Command to remove trailing whitespaces
command Tws %s/\s\+$//

" Tired of forgetting sudo..
cmap w!! w !sudo tee %

" Language specific settings
" Remove trailing whitespace on save for py files
au BufWritePre *.py :%s/\s\+$//e
" Wrap in diff mode
au FilterWritePre * if &diff | set wrap | endif

" Set some filetypes
au BufNewFile,BufRead *.ftl        setlocal filetype=html
au BufNewFile,BufRead *.ts         setlocal filetype=javascript
au BufNewFile,BufRead *.tsx        setlocal filetype=javascript
au BufNewFile,BufRead *.eyaml      setlocal filetype=yaml
au BufNewFile,BufRead *.svelte     setlocal filetype=html

" Replace next occurrences of word
nnoremap <leader>s :%s/<c-r><c-w>/<c-r><c-w>/gcI<c-f>$F/hvb

" Quickfix shortcuts
nnoremap <leader>p :cprevious<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>o :copen<cr>
nnoremap <leader>c :cclose<cr>

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set norelativenumber
        set colorcolumn=0
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set relativenumber
        set colorcolumn=80
    endif
endfunction

nnoremap <leader>h :call ToggleHiddenAll()<CR>

" Plugin confs

" Fuzzy file search using skim/sk
let $SKIM_DEFAULT_COMMAND = 'eval "rg --files $(git rev-parse --show-toplevel)"'
nnoremap <c-p> :SK<cr>

" Git blame through fugitive.vim
nnoremap <leader>b :Gblame<cr>

" Use quickfix for linting results
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" load per machine settings, missing file will be ignored.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Load Vim8 plugins in pack/
packloadall

" Load all helptags
silent! helptags ALL
