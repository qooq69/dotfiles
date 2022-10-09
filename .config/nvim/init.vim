set nocompatible
filetype off

call plug#begin("~/.config/nvim/plugged")
" Plug 'dense-analysis/ale'

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" clang-format plugin
Plug 'rhysd/vim-clang-format'

" completion engine based off of vscode plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" syntax highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'skywind3000/asyncrun.vim'

" nvim theme that also supports treesitter
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" opens URI in da browser
Plug 'tyru/open-browser.vim'

Plug 'navarasu/onedark.nvim'

Plug 'lervag/vimtex'


" Snippets for coc-snippets
Plug 'honza/vim-snippets'
call plug#end()

filetype plugin indent on

syntax on

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>
inoremap <C-tab>   <Esc>:tabnext<CR>

" `gx` opens URI or searches keyword under cursor
let g:netrw_nogx = 1
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

let g:vimtex_view_method = 'zathura'

set termguicolors

" lua config {{{

lua << EOF
local line_ok, feline = pcall(require, "feline")
require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require('material').setup({

	contrast = {
		sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		line_numbers = false, -- Enable contrast background for line numbers
		sign_column = false, -- Enable contrast background for the sign column
		cursor_line = false, -- Enable darker background for the cursor line
		non_current_windows = false, -- Enable darker background for non-current windows
		popup_menu = false, -- Enable lighter background for the popup menu
	},

	italics = {
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	high_visibility = {
		lighter = true, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},

	disable = {
		borders = false, -- Disable borders between verticaly split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

    custom_colors = {
        comments = '#91759c' -- Make comments a bit brighter cause I'm blind
        },

	custom_highlights = {} -- Overwrite highlights with your own
})

require('lualine').setup {
    options = {
        theme = 'auto',
    },
    sections = {
        lualine_a = {'%f%m%r%h%w'},
        lualine_b = {'g:coc_status'},
        lualine_c = {'b:coc_current_function'},
        lualine_x = { {'fileformat', icons_enabled = false } },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "c", "cpp" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },

--  indent = {
--    enable = true
--    }
}
EOF

" }}}

" Set theme
let g:material_style = "deep ocean"
colorscheme onedark

" Ignore various cache/vendor folders
set wildignore+=*/node_modules/*,*/dist/*,*/__pycache__/*,*/venv/*

" Ignore C/C++ Object files
set wildignore+=*.o,*.obj
set wildignore+=*.ilk
set wildignore+=*/build/*
set wildignore+=*/build_native/*
set wildignore+=*/build-*/*
set wildignore+=*/vendor/*

" Use case insensitive search
set smartcase
set ignorecase
" Disable swap file. Some people say to keep swap file enabled but in a
" temporary folder instead. I dislike the dialog that pops up every now and
" then if a swapfile is left so I just leave it fully disabled
set noswapfile

" Enable line numbers
set number
" Enable relative line numbering
set relativenumber
" Set the number gutter to be 6 chars wide
set numberwidth=6

" Highlight the current line
set cursorline

" Don't wrap lines
set nowrap

" Enable mouse support
set mouse=a

" Disable mode line
set nomodeline

" Incremental search. start searching and moving through the file while typing
" the search phrase
set incsearch
set inccommand=nosplit
" Don't highlight previous search pattern
set nohlsearch

" Other options that I just copied and haven't tried understanding yet
set wildmenu
set lazyredraw
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cindent

" Customize our status line
"set statusline=%f%m%r%h%w\ 
"set statusline+=[%{&ff}]
"set statusline+=\ %{coc#status()}%{get(b:,'coc_current_function','')}
"set statusline+=%=
"set statusline+=[\%03.3b/\%02.2B]\ [POS=%04v]

" Always show status line
set laststatus=2

" Store an undo buffer in a file in $HOME/.config/nvim/vimundo/
set undofile
set undodir=$HOME/.config/nvim/vimundo
set undolevels=1000
set undoreload=10000

" Customize certain chars (e.g., show dots when there are trailing spaces), more info in :help 'list'
set list
set listchars=tab:\ \ ,trail:·,extends:>

nnoremap ; :

nnoremap <S-k> <nop>

let g:ale_linters = { 
            \ 'cpp': ['clangtidy', 'clang-format'],
            \ 'python': ['jedils']
            \ }

" Python leader-bindings (Space+Key)
au FileType python nmap <leader>f <Plug>(ale_fix)

au FileType html setlocal ts=2 sw=2 sts=2

let g:ale_python_executable='/usr/bin/python'
let b:ale_fixers = {
    \ 'python': ['black', 'isort'],
    \ 'typescript': ['tslint', 'prettier'],
    \ 'html': ['prettier'],
    \ 'json': ['prettier'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'javascriptreact': ['eslint', 'prettier'],
    \ 'rust': ['rustfmt'],
    \ 'markdown': ['prettier'],
    \ 'systemd': ['systemd-analyze'],
    \ 'cmake': ['cmake-format']
  \ }

let g:ale_fix_on_save = 1
let g:ale_list_window_size = 2
let g:ale_set_quickfix = 1

set clipboard=unnamedplus

let g:ctrlp_follow_symlinks = 1

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'cpp']

" hex editor config
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd -g 1
  au BufWritePost *.bin set nomod | endif
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" remap za (toggle fold) to zo
noremap <silent> zo za


" automatically compile 
autocmd BufWritePost *.md :AsyncRun exec '!pandoc-eisvogel '.shellescape('%').' '.shellescape('%:r').'.pdf'<CR>
autocmd FileType markdown nnoremap <F4> :w <bar> silent exec '!pandoc-eisvogel '.shellescape('%').' '.shellescape('%:r').'.pdf --listings'<CR>


" coc.nvim config {{{

let g:coc_enable_locationlist = 0
let g:coc_global_extensions = ['coc-git', 'coc-clangd', 'coc-snippets']


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


function! s:show_documentation_tooltip()
    call CocActionAsync('doHover')
endfunction

"nmap <alt><enter> <Plug>(coc-codeaction-line)
nnoremap <silent> <C-h> :call <SID>show_documentation_tooltip()<cr>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" Alt+Enter opens menu for codeaction
nmap <silent> <a-cr>  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" }}}


" python config {{{

"autocmd filetype python nnoremap <F4> :w <bar> exec '!python3 '.shellescape('%')<CR>

" }}}


" C style languages config {{{

" clang-format extension options
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable

let g:clang_format#code_style = "llvm"
let g:clang_format#style_options = {
             \ "AccessModifierOffset" : -4,
             \ "AllowShortIfStatementsOnASingleLine" : "true",
             \ "AlwaysBreakTemplateDeclarations" : "true",
             \ "BreakBeforeBraces" : "Stroustrup",
             \ "IndentWidth" : 4,
             \ "ColumnLimit" : 120,
             \ "Standard" : "c++20" }

au FileType cpp nmap <silent> <leader>f :ClangFormat<cr>
au FileType cpp nmap <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>
au FileType c nmap <silent> <leader>f :ClangFormat<cr>
au FileType c nmap <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>

" autocmd filetype c nnoremap <F4> :w <bar> exec '!clang '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType cpp nnoremap <F5> :w <bar> exec '!clang++ -std=c++20 -v '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
command! -nargs=+ -complete=file T
    \ tab new | setlocal nonumber nolist noswapfile bufhidden=wipe |
    \ call termopen([<f-args>]) |
    \ startinsert
"clang++ -std=c++17 % -o %:r && ./%:r<CR>
autocmd FileType cpp nnoremap <silent> <buffer> <F4> :call <SID>compile_run_cpp()<CR>

function s:create_term_buf(_type, size) abort
    set splitbelow
    set splitright
    if a:_type ==# 'v'
        vnew
    else
        new
    endif
    execute 'resize ' . a:size
endfunction

function! s:compile_run_cpp() abort
    let src_path = expand('%:p:~')
    let src_noext = expand('%:p:~:r')
    " Build flags
    let _flag = '-std=c++2a'

    if executable('clang++')
        let prog = 'clang++'
    elseif executable('g++')
        let prog = 'g++'
    else
        echoerr 'No compiler found!'
    endif
    call s:create_term_buf('h', 15)
    execute printf('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext)
    "startinsert
    execute '$'
endfunction

" }}}
