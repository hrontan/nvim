set encoding=utf-8
scriptencoding=utf-8

syntax enable
set number
set clipboard=unnamedplus
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
" neobundle
"----------------------------------------

if has('vim_starting')
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.config/nvim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/deoplete.nvim'
	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'Shougo/neosnippet-snippets'
	NeoBundle 'honza/vim-snippets'
	NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {'autoload':{'filetypes':['javascript','html']}}
	NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript','html']}}
	NeoBundleLazy 'kana/vim-filetype-haskell', {'autoload':{'filetypes': ['haskell']}}
	NeoBundleLazy 'ujihisa/neco-ghc', {'autoload':{'filetypes': ['haskell']}}
	NeoBundle 'scrooloose/syntastic.git'
	NeoBundle 'vim-scripts/autoload_cscope.vim'
call neobundle#end()
filetype plugin indent on

NeoBundleCheck
let g:deoplete#enable_at_startup = 1
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_compiler_options = ' -std=c11'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_python_python_exec = 'python3'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
if empty(neobundle#get("neosnippet"))
	imap <C-s> <Plug>(neosnippet_expand_or_jump)
	smap <C-s> <Plug>(neosnippet_expand_or_jump)
	xmap <C-s> <Plug>(neosnippet_expand_target)
	let g:neosnippet#enable_snipmate_compatibility = 1
	let g:neosnippet#disable_runtime_snippets = {'_' : 1}
	let g:neosnippet#snippets_directory = []
	if ! empty(neobundle#get("vim-octopress-snippets"))
		let g:neosnippet#snippets_directory += ['~/.nvim/bundle/vim-octopress-snippets/neosnippets']
	endif
	let g:neosnippet#snippets_directory += ['~/.nvim/bundle/neosnippet-snippets/neosnippets']
	if ! empty(neobundle#get("vim-snippets"))
	let g:neosnippet#snippets_directory += ['~/.nvim/bundle/vim-snippets/snippets']
  endif
endif

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

