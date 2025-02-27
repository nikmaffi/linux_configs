call plug#begin()

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

au BufNewFile,BufRead *.COB set filetype=cobol

:set termguicolors
:syntax on
:colorscheme catppuccin_mocha

function! s:SetupTree()
	if bufexists(1) && bufname(1) ==# ''
		NERDTree $HOME
	elseif &filetype !=# 'nerdtree'
		NERDTreeFind
	endif
endfunction

:command Term belowright term
:command Tree call s:SetupTree()

if $XDG_SESSION_TYPE == 'wayland'
	:command -range=% Pbcopy '<,'>y | call system('wl-copy', @0)
	:command Pbpaste put =system('wl-paste')
elseif $XDG_SESSION_TYPE == 'x11'
	:command -range=% Pbcopy '<,'>y | call system('xsel --input --clipboard', @0)
	:command Pbpaste put =system('xsel --output --clipboard')
endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
