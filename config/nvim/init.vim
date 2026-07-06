call plug#begin('~/.vim/plugged')

Plug 'amitds1997/remote-nvim.nvim', {'tag': '*'}

"remote.nvim dependencies

Plug 'MunifTanjim/nui.nvim', {'tag': '*'}

"end of remote.nvim dependencies

Plug 'lewis6991/gitsigns.nvim', {'tag': '*'}

Plug 'preservim/nerdtree'

Plug 'junegunn/limelight.vim'

Plug 'junegunn/goyo.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ryanoasis/vim-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': 'v0.10.0'}

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '*' }

Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

Plug 'nvim-tree/nvim-web-devicons', {'tag' : '*'}

Plug 'nvim-lua/plenary.nvim', {'tag' : '*'}

Plug 'nvim-pack/nvim-spectre'

Plug 'folke/trouble.nvim', {'tag' : '*'}

call plug#end()

lua << EOF
require("remote-nvim").setup()
EOF

lua << EOF
require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
EOF

lua << EOF
require('nvim-treesitter').setup({
  ensure_installed = { "lua", "vim", "yaml", "python", "html", "css", "json", "bash" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
EOF

lua << EOF
require('gitsigns').setup{
  current_line_blame = true
}
EOF

lua << EOF
require('telescope').setup({
  defaults = {
    preview = {
      treesitter = true
    }
  }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fG', function()
  local pattern = vim.fn.input("Pattern (e.g., 'src/' or '!tests/'): ")
  builtin.live_grep({
    additional_args = function()
      return { "--glob", pattern }
    end
  })
end)
EOF

autocmd!
set splitbelow
set nocompatible
set number
syntax enable
set fileencoding=utf-8
set encoding=utf-8
set title
set mouse=a
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set expandtab
set cmdheight=1
set laststatus=2
set scrolloff=10
set shell=bash

colorscheme NeoSolarized
hi Normal guibg=none
hi Foreground guibg=#ffffff

if has('nvim')
	set inccommand=split
endif

set nosc noru nosm

set lazyredraw
set ignorecase
set smarttab
set ai
set si
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set nowrap
set path+=**
set wildignore+=*/node_modules/*
set cursorline
set termguicolors
set winblend=0
set wildoptions=pum
set pumblend=5
let g:neosolarized_termtrans=1
runtime ./colors/NeoSolarized.vim

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" =========================
" Custom Vim Functions
" =========================

" Limelight color settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = '#777777'


"Goyo Settings
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  hi! Normal ctermbg=NONE guibg=NONE 
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


"NERDTree setup

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"NERDTree follows directory changes
let g:NERDTreeChDirMode = 2

"KeyBind for NERDTree
"nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"KeyBind for TAGbar
nmap <F8> :TagbarToggle<CR>

"Tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-n> :tabnew<CR>

"Telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>

"Spectre keybindings
nnoremap <leader>S <cmd>lua require("spectre").toggle()<CR>
nnoremap <leader>sw <cmd>lua require("spectre").open_visual({select_word=true})<CR>
vnoremap <leader>sw <esc><cmd>lua require("spectre").open_visual()<CR>
nnoremap <leader>sp <cmd>lua require("spectre").open_file_search({select_word=true})<CR>


let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

let g:coc_global_extensions = [
  \ 'coc-json',
  \  'coc-prettier'
  \ ]



autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


nnoremap <silent> K :call CocAction('doHover')<CR>


"function! s:show_hover_doc()
"  call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction


"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

nmap <leader>do <Plug>(coc-codeaction)

nmap <leader>rn <Plug>(coc-rename)

" Accept completion with Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Navigate suggestions with Tab/Shift-Tab
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

