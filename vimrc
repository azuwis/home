" Pathogen {{{1
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
runtime ftplugin/man.vim

" Colorschema {{{1
let g:solarized_diffmode="high"
let g:solarized_hitrail=1
colorscheme solarized

" Option {{{1
let mapleader=","

set list
"set listchars+=tab:▸\ 
"set listchars+=eol:¬
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

set modeline
set relativenumber
set cursorline
set colorcolumn=85
" disable startup message
set shortmess+=I
set fileencodings=ucs-bom,utf-8,cp936,default,latin1
set ignorecase
set smartcase
set hlsearch
if exists("*fugitive#statusline")
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

" Mapping {{{1
map Q gq
nnoremap / /\v
vnoremap / /\v
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap ; :
"inoremap jj <ESC>

" Disable <up> <down> <left> <right>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
"inoremap <left> <nop>
inoremap <right> <nop>

" Space & tab {{{1
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
    autocmd FileType vim,yaml,html,css setlocal ts=2 sts=2 sw=2 et
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet

    " no list and relativenumber for manpages
    autocmd FileType man setlocal nolist norelativenumber colorcolumn=

    " treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    " auto save file on losing focus
    autocmd FocusLost * silent! wa

    " auto load .vimrc
    autocmd BufWritePost ~/.vimrc source $MYVIMRC

    " restore cursor position
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END
endif

" Command {{{1
"command! CleanSRT %s/{[^}]*}//g<CR>

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Plugin setting {{{1
" slime
let g:slime_target="tmux"

" powerline
let g:Powerline_symbols='fancy'

" vim: fdm=marker
