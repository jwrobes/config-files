"=============================================================================
" NEOVIM CONFIGURATION - Comprehensive setup for modern development
"=============================================================================
"
" KEY BINDINGS QUICK REFERENCE:
" 
" File Navigation:
"   Ctrl-P          = FZF file finder (fuzzy search, respects .gitignore)
"   Ctrl-B          = FZF file history
"   -               = Vinegar file browser (go to parent directory)
"   <Space><Space>  = Switch to previous file
"
" Search & Replace:
"   <Space>*        = Search word/selection across all files (ripgrep)
"   K               = Search word under cursor
"   \\              = Manual ripgrep search
"   <Space>q        = Clear search highlights
"
" Code Testing:
"   <Space>s        = Run nearest test
"   <Space>t        = Run test file
"   <Space>v        = Run last test
"
" Git/Project Navigation:
"   <Space>gp       = Files changed in current branch
"   <Space>gm/gv/gc = Navigate to models/views/controllers
"   <Space>gs       = Navigate to spec files
"
" Text Editing:
"   gcc             = Comment/uncomment line
"   gc<motion>      = Comment motion (gcap = comment paragraph)
"   ga<motion>      = Align text (ga= align on =, ga: align on :)
"   cs\"'           = Change surrounding \" to '
"   ds\"            = Delete surrounding \"
"   <Space>wht      = Strip trailing whitespace
"
" Folding:
"   <Space>ff       = Toggle fold under cursor
"   <Space>fu       = Fold all
"   <Space>uf       = Unfold all
"
" Utilities:
"   jk              = Quick escape from insert mode
"   <Space>u        = Copy file path to clipboard
"   <Space>sop      = Reload config file
"   <Space>bi       = Install vim plugins
"
" Linting/Formatting (ALE):
"   Automatic on save for JavaScript (prettier/eslint) and Python (black/ruff)
"   :ALEFix         = Manual fix
"   :ALELint        = Manual lint
"
" Markdown:
"   :MarkdownPreview = Live preview in browser
"
"=============================================================================

" General Vim Settings
set nocompatible

if exists('g:vscode')
    " VSCode extension
    nnoremap <leader>sop :source $MYVIMRC<CR>
    nnoremap - :e %:h<CR>
else
    " ordinary Neovim
endif


" Need to set the leader before defining any leader mappings
let mapleader = "\<Space>"

filetype plugin indent on

set backspace=2      " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set laststatus=2     " Always display the status line
set autowrite        " Automatically :write before running commands
set formatoptions-=t " Don't auto-break long lines (re-enable this for prose)

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Display relative line numbers, with absolute line number for current line
set number
set relativenumber

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Copy file path to clipboard
" Usage: <Space>u to copy current file path
nnoremap <mapleader>u :let @+=expand('%')<CR>

" Unhighlight search results
" Usage: <Space>q to clear search highlighting
nnoremap <mapleader>q :nohlsearch<CR>o

" Quick escape from insert mode
" Usage: Type 'jk' quickly to exit insert mode
inoremap jk <ESC>

" Map Caps Lock to Escape
inoremap <CapsLock> <Esc>
nnoremap <CapsLock> <Esc>
vnoremap <CapsLock> <Esc>
cnoremap <CapsLock> <Esc>

" Completion related settings
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Convenience - configs & mappings to smooth out rough edges and make vim feel like home
" Move between wrapped lines, rather than jumping over wrapped segments
nnoremap j gj
nnoremap k gk

" Ensure holding down navigation keys works
noremap <Up> k
noremap <Down> j
noremap <Left> h
noremap <Right> l

" Quick sourcing of the current file, allowing for quick vimrc testing
" Usage: <Space>sop to reload current file
nnoremap <leader>sop :source %<cr>

" Install vim plugins
" Usage: <Space>bi to install new plugins
nmap <leader>bi :PlugInstall<cr>

" Swap 0 and ^. I tend to want to jump to the first non-whitesapce character
" so make that the easier one to do.
nnoremap 0 ^
nnoremap ^ 0

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Copy file path
nnoremap <leader>u :let @+=expand('%')<CR>

" Switch between the last two files
" Usage: <Space><Space> to toggle between current and previous file
nnoremap <leader><leader> <c-^>

" Folding configurations
" Enable indent folding
set foldenable
set foldmethod=indent
set foldlevel=999

" Folding key mappings
" Usage: <Space>ff = toggle fold under cursor
"        <Space>FF = toggle fold recursively
"        <Space>fu = fold all (close all folds)
"        <Space>uf = unfold all (open all folds)
nnoremap <leader>ff za
nnoremap <leader>FF zA
nnoremap <LEADER>fu zM<CR>
nnoremap <LEADER>uf zR<CR>

" Vim Search Settings
" Use ripgrep for blazing fast text search with gitignore support
if executable('rg')
  " Use ripgrep over Grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

  " Use ripgrep for CtrlP file listing (fallback, since we use FZF now)
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0

  " Create Rg command for text search
  if !exists(":Rg")
    command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Rg<SPACE>
  endif
elseif executable('ag')
  " Fallback to ag if ripgrep not available
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
  let g:ctrlp_use_caching = 0
  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Search word under cursor with ripgrep
" Usage: K = search word under cursor across all files
" \\ = manual ripgrep search (type your search term)
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search / Substitute related configurations
" set hlsearch
" set incsearch
" set ignorecase
" set smartcase
" nnoremap <leader>sub :%s///g<left><left>
" vnoremap <leader>sub :s///g<left><left>

set statusline=\ %f           " Path to the file
set statusline+=\ %m          " Modified flag
set statusline+=\ %y          " Filetype
set statusline+=%=            " Switch to the right side
set statusline+=%l            " current line
set statusline+=/%L           " Total lines

" Visual settings
" Make it obvious where 80 characters is
set textwidth=100
set colorcolumn=+1

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Open new split panes to right and bottom
set splitbelow
set splitright

" Set up vim to copy from vim to osx using yank following this
" https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

" Initialize plugin system
call plug#begin('~/.vim/plugged')

" Easy Align - operators for aligning characters across lines
" https://github.com/junegunn/vim-easy-align
" Usage: ga<motion> or visual select + ga
"        Examples: gaip= (align paragraph on =), ga2j: (align 2 lines on :)
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF - Fuzzy file finder with comprehensive configuration
" https://github.com/junegunn/fzf
" https://github.com/junegunn/fzf.vim
" Usage: Ctrl-P = find files, Ctrl-B = file history
"        Respects .gitignore, excludes node_modules, build artifacts
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" FZF Configuration with file previews and ripgrep integration
let g:fzf_files_options =
  \ '--reverse ' .
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
nnoremap <C-p> :Files<cr>
" Use ripgrep for fast file searching with automatic gitignore support
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!dist/*" --glob "!build/*" --glob "!*.log"'

let g:fzf_history_options =
  \ '--reverse ' .
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
nnoremap <C-b> :History<cr>

" Branch file search commands - find files changed in current branch
" Usage: <Space>gp = files changed since master branch
let branch_files_options = { 'source': '( git status --porcelain | awk ''{print $2}''; git diff --name-only HEAD $(git merge-base HEAD master) ) | sort | uniq'}
let branch_files_options_develop = { 'source': '( git status --porcelain | awk ''{print $2}''; git diff --name-only HEAD $(git merge-base HEAD develop) ) | sort | uniq'}
command! BranchFiles call fzf#run(fzf#wrap('BranchFiles',
      \ extend(branch_files_options, { 'options': g:fzf_files_options }), 0))
command! BranchFilesDevelop call fzf#run(fzf#wrap('BranchFilesDevelop',
      \ extend(branch_files_options_develop, { 'options': g:fzf_files_options }), 0))
nnoremap <silent> <leader>gp :BranchFiles<cr>

" Quick directory navigation mappings (Rails-style)
" Usage: <Space>gm = models, <Space>gv = views, <Space>gc = controllers, etc.
nnoremap <leader>gm :Files app/models/<cr>
nnoremap <leader>gv :Files app/views/<cr>
nnoremap <leader>gc :Files app/controllers/<cr>
nnoremap <leader>gy :Files app/assets/stylesheets/<cr>
nnoremap <leader>gj :Files app/assets/javascripts/<cr>
nnoremap <leader>gr :Files client/app/<cr>
nnoremap <leader>grs :Files client/spec/<cr>
nnoremap <leader>gs :Files spec/<cr>

" Help tags search
" Usage: <Space>he = search vim help tags
nnoremap <silent> <leader>he :Helptags<cr>

" Auto pairs - Automatically insert closing brackets, quotes, etc.
" https://github.com/jiangmiao/auto-pairs
" Usage: Automatic - type ( and get (), type " and get ""
Plug 'jiangmiao/auto-pairs'

" Better Whitespace - Highlight trailing whitespace and provide command to kill
" https://github.com/ntpeters/vim-better-whitespace
" Usage: <Space>wht = strip trailing whitespace and save
Plug 'ntpeters/vim-better-whitespace'
nnoremap <leader>wht :StripWhitespace<cr>:w<cr>

" Commentary - Comment / uncomment via text operator w/ text objects
" https://github.com/tpope/vim-commentary
" Usage: gcc = comment line, gc<motion> = comment motion, gcap = comment paragraph
Plug 'tpope/vim-commentary'

" Endwise - Automatic insertion of closings like do..end
" https://github.com/tpope/vim-endwise
" Usage: Automatic - type 'if' in Ruby and get 'end', works for functions, etc.
Plug 'tpope/vim-endwise'

" Eunuch - Add handful of UNIXy commands to Vim
" https://github.com/tpope/vim-eunuch
" Usage: :Delete, :Move, :Rename, :Chmod, :Mkdir, :SudoWrite, etc.
Plug 'tpope/vim-eunuch'

" JavaScript - JS syntax and indent settings, along with JSX support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

" Jellybeans colorscheme
Plug 'nanotech/jellybeans.vim'

" Vim mkdir - automatically make intermediate directories if needed
Plug 'pbrisbin/vim-mkdir'

" Rails - Add Rails navigation and related commands
Plug 'tpope/vim-rails'

" Rake - Additional Ruby smarts in Vim
Plug 'tpope/vim-rake'

" Repeat - Repeat custom mappings with `.`
Plug 'tpope/vim-repeat'

" Ruby - More up to date Ruby filetype settings
Plug 'vim-ruby/vim-ruby'

" Surround - Mappings for adding, removing, and changing surrounding characters
" https://github.com/tpope/vim-surround
" Usage: cs"' = change " to ', ds" = delete ", ysiw" = surround word with "
Plug 'tpope/vim-surround'

" Split join - A vim plugin that simplifies the transition between multiline and single-line code
Plug 'andrewradev/splitjoin.vim'

" Vim Tmux Navigator - Seamlessly navigate between vim splits and tmux panes
" https://github.com/christoomey/vim-tmux-navigator
" Usage: Ctrl-h/j/k/l = navigate between vim splits and tmux panes seamlessly
Plug 'christoomey/vim-tmux-navigator'
noremap <C-f> :VtrSendLinesToRunner<cr>

" Vim Tmux Runner - Send commands to tmux panes
" https://github.com/christoomey/vim-tmux-runner
" Usage: <Space>va = attach to tmux pane, <Space>fr = focus runner pane
"        Ctrl-f = send current line to runner
Plug 'christoomey/vim-tmux-runner'
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>fr :VtrFocusRunner<cr>

" Vimux - Better tmux integration for tests (modern tslime replacement)
" https://github.com/preservim/vimux
" Usage: Used by vim-test plugin for running tests in tmux panes
"        Creates 20% bottom pane automatically, better than tslime
Plug 'preservim/vimux'

" Vinegar - Enhanced netrw file browser
" https://github.com/tpope/vim-vinegar
" Usage: Press - in any file to browse its parent directory
"        Complements FZF for when you want to explore file structure
Plug 'tpope/vim-vinegar'

" Visual Star Search - Search for selected text across files
" https://github.com/nelstrom/vim-visual-star-search
" Usage: <Space>* on word = search word in all files
"        Visual select + <Space>* = search selection in all files
"        Enhanced with ripgrep for speed and gitignore support
Plug 'nelstrom/vim-visual-star-search'

" ALE - Asynchronous Lint Engine for linting and fixing
" https://github.com/dense-analysis/ale
" Usage: Automatic linting while typing, auto-fix on save
"        :ALEFix = manual fix, :ALELint = manual lint
"        Supports JavaScript (prettier/eslint) and Python (black/ruff/mypy)
Plug 'dense-analysis/ale'

" Markdown Preview - Live preview of markdown files in browser
" https://github.com/iamcco/markdown-preview.nvim
" Usage: :MarkdownPreview = start preview, :MarkdownPreviewStop = stop preview
"        :MarkdownPreviewToggle = toggle preview
"        Great for editing README files and documentation
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Emmet - Generate HTML markup from css-like selector strings
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<c-e>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
inoremap <C-e>e <esc>:call emmet#expandAbbr(0,"")<cr>h:call emmet#splitJoinTag()<cr>wwi
nnoremap <C-e>e :call emmet#expandAbbr(0,"")<cr>h:call emmet#splitJoinTag()<cr>ww
autocmd FileType html,css,javascript.jsx EmmetInstall

" Matchit: The matchit.vim script allows you to configure % to match more than just single characters.
Plug 'tmhedberg/matchit'

" Vim-fugitive: Git Wrapper for Vim
Plug 'tpope/vim-fugitive'

" UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger="<c-g>"
" let g:UltiSnipsEditSplit="vertical"

" Write JavaScript ES6 easily with vim.
Plug 'isRuslan/vim-es6'

" Vim Test - Run tests at the speed of thought
" https://github.com/vim-test/vim-test
" Usage: <Space>s = run nearest test, <Space>t = run file, <Space>v = run last test
"        Supports Python/pytest, JavaScript/mocha, Ruby/rspec
"        Tests run in tmux pane via vimux (auto-creates 20% bottom pane)
Plug 'vim-test/vim-test'
let test#strategy = "vimux"
let test#python#runner = 'pytest'
let test#ruby#rspec#executable = 'rspec'
let test#javascript#mocha#file_pattern = 'Spec\.js'
let test#javascript#mocha#executable = 'npm test'
map <leader>s :TestNearest<CR>
map <Leader>t :TestFile<CR>
map <Leader>v :TestLast<CR>

" Adds vim coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


Plug 'leafgarland/typescript-vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" ALE Configuration for JavaScript and Python
" JavaScript: prettier + eslint for formatting and linting
" Python: black + isort + ruff for formatting, flake8 + mypy + ruff for linting
" All files auto-fix on save for consistent code style
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['black', 'isort', 'ruff_format'],
\}
let g:ale_linters = {
\   'python': ['flake8', 'mypy', 'ruff'],
\   'javascript': ['eslint'],
\}
" JavaScript Prettier options (single quotes, 100 char width, trailing commas)
let g:ale_javascript_prettier_options = '--single-quote --jsx-single-quote --print-width=100 --trailing-comma es5'
" Python tool configuration - ensure ALE finds the right Python environment
let g:ale_python_black_executable = 'black'
let g:ale_python_isort_executable = 'isort'
let g:ale_python_ruff_executable = 'ruff'
" Auto-fix on save - formats code automatically when you save
let g:ale_fix_on_save = 1

" Visual Star Search - Enhanced with ripgrep for fast project-wide search
" <Space>* on word = search word across all project files
" Visual select + <Space>* = search selected text across all project files
" Uses ripgrep for speed and automatic gitignore support
nnoremap <leader>* :Rg <C-r><C-w><CR>
" Simpler visual selection search that works reliably
vnoremap <leader>* y:Rg <C-r>"<CR>

" End Install Vim Plugins
call plug#end()

" Command to check spelling
command! -nargs=0 Spell :setlocal spell spelllang=<en>
