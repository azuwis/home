" NeoBundle Start{{{1
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim', {'directory' : 'neobundle'}

" Options {{{1

"set list
"set showbreak=↪
"set listchars+=tab:▸\ 
"set listchars+=eol:¬
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

set modeline
set laststatus=2
"set relativenumber
"set cursorline
set colorcolumn=80
" disable startup message
set shortmess+=I
set fileencodings=ucs-bom,utf-8,cp936,default,latin1
set ignorecase
set smartcase
set hlsearch
set wildignore=
set noswapfile
set undodir=~/.vim/.undodir
set undofile
set splitright splitbelow
"if exists("*fugitive#statusline")
"  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
"endif

" Mappings {{{1
map Q gq
nnoremap <F5> :update<CR>
inoremap <F5> <C-o>:update<CR>
"nnoremap / /\v
"vnoremap / /\v
nnoremap <silent> <leader>s :set spell!<CR>
"nnoremap ; :
"inoremap jj <ESC>

" Disable <up> <down> <left> <right> {{{2
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Quick toggles {{{2
nnoremap <silent> <leader>l :set list!<CR>
nnoremap <silent> <leader>n :silent :nohlsearch<CR>

" Window switching {{{2
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" File opening {{{2
" Shortcuts for opening file in same directory as current file
cnoremap <expr> %% getcmdtype() == ':' ? escape(expand('%:h'), ' \').'/' : '%%'
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" Prompt to open file with same name, different extension
map <leader>er :e <C-R>=expand("%:r")."."<CR>

" Fix the & command in normal+visual modes {{{2
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" Recall command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Indentation {{{1
set ts=8 sts=4 sw=4 et
" http://vimcasts.org/episodes/tabs-and-spaces/
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Autocmd {{{1
if has("autocmd")
  augroup vimrcEX
    autocmd!
    " space and tab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noet
    autocmd FileType vim,yaml,html,css,ruby,eruby,sh setlocal ts=2 sts=2 sw=2 et
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet

    " filetype specific mapping
    autocmd FileType vim nnoremap <buffer> K :h <C-r><C-w><CR>

    " no list and relativenumber for manpages
    autocmd FileType man setlocal nolist norelativenumber colorcolumn=

    " treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    " treat .mrconfig files as cfg, ~/.mrlib as sh
    autocmd BufNewFile,BufRead */.mrconfig setfiletype cfg
    autocmd BufNewFile,BufRead ~/.mrlib setfiletype sh

    " .adoc as asciidoc
    autocmd BufNewFile,BufRead *.adoc,*.asc setfiletype asciidoc

    " set spell for git commit msg
    autocmd FileType gitcommit setlocal spell

    " auto save file on losing focus
    autocmd FocusLost * silent! :update

    " auto load .vimrc
    autocmd BufWritePost ~/.vimrc source $MYVIMRC

    " restore cursor position
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " load ~/.Xresources if modified
    autocmd BufWritePost ~/.Xresources :silent !xrdb ~/.Xresources
  augroup END
endif

" Command {{{1
command! CleanSRT normal :%s/{[^}]*}//g<CR>

" Commands to quickly set >1 option in one go {{{2
command! -nargs=* Wrap set wrap linebreak nolist


if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Recipe {{{1
" trailing whitespace http://www.bestofvim.com/tip/trailing-whitespace/
"match ErrorMsg '\s\+$'
match ErrorMsg /\s\+\%#\@<!$/
command! RTW normal :%s/\s\+$//e<CR>

" General Bundles {{{1
NeoBundle 'bling/vim-airline'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

NeoBundle 'jnurmine/Zenburn', {'directory' : 'zenburn' }

" man
runtime ftplugin/man.vim
nmap K <Leader>K

" colorscheme

" gundo
map <Leader>u :GundoToggle<CR>

" BeoBundle End {{{1
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

colorscheme zenburn

" vim: fdm=marker
