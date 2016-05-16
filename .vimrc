" REFERENCES: 
" CONTENT & ORGANIZATION OF .vimrc largely BASED ON THESE
" SOURCES {{{
" -- http://dougblack.io/words/a-good-vimrc.html
" -- https://github.com/amix/vimrc
"}}}

" DEPENDENCIES: {{{ yes this thing has dependencies!
" YOU NEED TO INSTALL FOLLOWING SOFTWARE IN ORDER FOR 
" THIS vim config TO WORK AT ITS BEST.
" - [pathogen github](http://github.com/tpope/vim-pathogen) | [pathogen on vim online](http://www.vim.org/scripts/script.php?script_id=2332)
" - [badwolf theme](https://github.com/sjl/badwolf)
" - [gundo.vim](https://github.com/sjl/gundo.vim.git)
" - [ag](https://github.com/ggreer/the_silver_searcher.git)
" - [ag.vim](https://github.com/rking/ag.vim.git)
" - [ctrlp.vim](https://github.com:ctrlpvim/ctrlp.vim.git)
" - [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors) "
"   ^ not installed yet.
" - [powerline](https://github.com/powerline/powerline)
" - [vim-jsbeautify](https://github.com/maksimr/vim-jsbeautify.git)
" }}}

" LAUNCH CONFIG {{{
" These are options set at launch to configure external tools exactly once.
" call pathogen#infect()                      " use pathogen
execute pathogen#infect()
call pathogen#helptags()
" ------
" The pathogen options extract all of the Vim plugins from 
" their location in ~/.vim/bundles to their respective places 
" in the ~/.vim folder.
"-}}}

" COLORS: {{{
" some options for color schemes: 
"   https://github.com/sjl/badwolf/
"   https://github.com/altercation/Vim-colors-solarized.git
"   https://github.com/tomasr/molokai.git
" colorscheme badwolf  " awesome color scheme  " FIXME: currently not installed.
try
    colorscheme badwolf    " until we have better color schemes installed 
catch
endtry

syntax enable         " enable syntax processing
" }}}

" SPACES AND TABS: {{{
set tabstop=4         " number of visual spaces per TAB
set softtabstop=4     " number of spaces in tab when editing
set expandtab         " tabs are spaces
" }}}

" UI CONFIG: {{{
set number            " show line numbers
set showcmd           " show command in bottom bar
set cursorline        " highlight current line
filetype plugin indent on   " load filetype-specific indent files
set wildmenu          " visual autocomplete for command menu
set lazyredraw        " redraw only when we need to
set showmatch         " highlight matching [{()}]
"-}}} 

" THEME CONFIG {{{
" Make the tab line darker than the background.
let g:badwolf_tabline = 0
" Turn on CSS properties highlighting
let g:badwolf_css_props_highlight = 1
" Make the gutters darker than the background.
let g:badwolf_darkgutter = 1
 " }}}

" POWERLINE CONFIG {{{
" following
" http://blog.codefront.net/2013/10/27/installing-powerline-on-os-x-homebrew/
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2 
" }}}

" SEARCHING: {{{
set incsearch         " search as characters are entered
set hlsearch          " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" ------
" explanation for the above:
    " Vim will keep highlighted matches from searches 
    " until you either run a new one or manually stop 
    " highlighting the old search with :nohlsearch. 
    " I find myself running this all the time so I've 
    " mapped it to ,<space>
"-}}}

" FOLDING {{{
set foldenable          " enable folding
set foldlevelstart=4   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
"-}}}

" CUSTOM MOVEMENTS {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV `[v`]
"-}}}

" CUSTOM LEADER {{{
let mapleader=","       " leader is comma
" jk is escape "XXXXX:YOU MAY WANT TO DISABLE THIS IF THIS GETS TOO MUCH IN THE WAY
inoremap jk <esc>
"-}}}
" Super undo {{{
" toggle gundo "XXXXX: NEED TO HAVE IT INSTALLED: https://github.com/sjl/gundo.vim.git
nnoremap <leader>u :GundoToggle<CR>
"-}}}

" EXTRA STUFF, BUT GOOD TO REMEMBER {{{
" edit vimrc/zshrc and load vimrc bindings ",ev / ,ez / ,sv
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" FROM THE AUTHOR: These are shortcuts to edit and source my vimrc and my zshrc. That's it.
"-}}}

" MORE CUSTOM COMMANDS {{{
" save session 
nnoremap <leader>s :mksession<CR> " ,s
" ------
" After saving a Vim session, you can reopen it with vim -S. 
" mnemonic: 'super save' ;)

" open ag.vim
nnoremap <leader>a :Ag
" ------
" This needs complete explanation
" The Silver Searcher[1] is a fantastic command line 
" tool to search source code in a project. It's 
" wicked fast. The command line tool is named ag 
" (like the element silver). Thankfully there is 
" a wonderful Vim plugin ag.vim[2] which lets you use 
" ag without leaving Vim and pulls the results into 
" a quickfix window for easily jumping to the matches. 
" Here I've mapped it to ,a.
" [1] https://github.com/ggreer/the_silver_searcher.git
" [2] https://github.com/rking/ag.vim.git

" Assign keybinding to ToggleNumber()
nnoremap <leader>n :call ToggleNumber()<CR> " needs the function definition in CUSTOM FUNCTIONS SECTION
"-}}}

" CTRLP SETTINGS {{{
" CtrlP is a fuzzy file searcher. Learn more about it!
" [1] https://github.com/ctrlpvim/ctrlp.vim.git
" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb' " order matching files top to bottom with ttb
let g:ctrlp_switch_buffer = 0 " always open files in new buffers
" ctrpp_working_path_mode lets us change the working directory during a 
" Vim session and make CtrlP respect that change
let g:ctrlp_working_path_mode = 0 
" tell CtrlP to run an external command to find matching files; use ag
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
"-}}}

" TMUX CONFIG {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" ------ 
" These lines change the cursor from block cursor mode to 
" vertical bar cursor mode when using tmux. Without these 
" lines, tmux always uses block cursor mode.
"-}}}

" AUTOGROUPS {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "            \:call <SID>StripTrailingWhitespaces()
    " FIXME: there is something wrong with this for all the filetypes
    " in the filter above. This needs some investigation and fixing.
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.html setlocal tabstop=2
    autocmd BufEnter *.html setlocal shiftwidth=2
    autocmd BufEnter *.html setlocal softtabstop=2
    autocmd BufEnter *.css setlocal tabstop=2
    autocmd BufEnter *.css setlocal shiftwidth=2
    autocmd BufEnter *.css setlocal softtabstop=2
augroup END
"-}}}

" COOL AUTO-COMMAND {{{
    autocmd BufWritePre *.log :normal "=strftime("\n%b %d, %Y %X\n")p
        " Pre Buf Write command for manual log -- filename should be *.m.log
        " above rule yanked from http://askubuntu.com/a/541579/179681
" }}}

" BACKUPS {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp/vim-backups,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp/vim-backups,/var/tmp,/tmp
set writebackup
" ------
" Write backup to those backupdir's instead of in CWD to minimize annoyance
"-}}}

" CUSTOM FUNCTIONS {{{
" --------------------------------------------------------------------------
" Some custom functions by the author of the document we used to create this
" entire vimrc: http://dougblack.io/words/a-good-vimrc.html
" Cheers Doug Black
" --------------------------------------------------------------------------
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
"-}}}

" ORGANIZATION {{{
set modelines=1
" }}}

" WRAPPING IT UP {{{

" modeline below
" }}}
" vim:foldmethod=marker:foldlevel=0
