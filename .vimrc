set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

"Code Folding
Plugin 'tmhedberg/SimpylFold'
"Auto Indent
Plugin 'vim-scripts/indentpython.vim'
"Auto-Complete
Bundle 'Valloric/YouCompleteMe'
"Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'
" add PEP 8 checking
Plugin 'nvie/vim-flake8'
" Color Schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
"File Browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"git
Plugin 'tpope/vim-fugitive'
"status bar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"auto pairs
Plugin 'windwp/nvim-autopairs'

Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
set rtp+=/usr/bin/fzf
" Track the engine.
"iPlugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"add the proper PEP 8 indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

autocmd FileType python setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"For full stack development,
au BufNewFile, BufRead *.js,*.html,*.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

"Flagging Unnecessary Whitespace
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"using UTF-8
set encoding=utf-8


"auto cmplete setup with YCM
"let g:ycm_python_interpreter_path = ''
"let g:ycm_python_sys_path = []
"let g:ycm_extra_conf_vim_data = [
"  \  'g:ycm_python_interpreter_path',
"  \  'g:ycm_python_sys_path'
"  \]
"let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'
"
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


let python_highlight_all=1
syntax on

if has('gui_running')
  set background=dark
    colorscheme solarized
  else
    colorscheme zenburn
endif

set clipboard=unnamedplus

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

let g:gutentags_add_default_project_roots = 0
" config project root markers.
let g:gutentags_project_root = ['package.json', '.git', '.root']



" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
