set encoding=utf-8
scriptencoding=utf-8

syntax enable
set number
set smartindent
set list
set listchars=tab:>-,trail:-,extends:»,precedes:«,nbsp:%
set tabstop=4
set shiftwidth=4
set softtabstop=4
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformats=unix,dos,mac
set ignorecase
set smartcase
set statusline=%-(%f%m%h%q%r%w%)%=%{&ff}\|%{&fenc}\ %y%l,%c\ %0P
set nowritebackup
set noswapfile
set mouse=

"----------------------------------------
" dein.vim
"----------------------------------------
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.config/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on

function! s:remove_dust()
	let cursor = getpos('.')
	%s/\s\+$//ge
	call setpos('.', cursor)
	unlet cursor
endfunction

augroup vimrc
	autocmd!
	autocmd FileType python setlocal completeopt-=preview
	autocmd BufWritePre * call <SID>remove_dust()
augroup END

augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r
	autocmd BufWritePre * endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

