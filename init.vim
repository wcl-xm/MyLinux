" 设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" 显示行号
set nu
set rnu

"自动折行
set wrap

set tabstop=4
" 设置自动缩进长度为4空格
set shiftwidth=4
" 继承前一行的缩进方式，适用于多行注释
set autoindent

"启动时隐去援助提示
set shortmess=atI

"语法高亮
syntax on

"高亮当前行
set cursorline

"智能缩进
set smartindent
"搜索忽略大小写
set ignorecase
"智能大小写
set smartcase

"高亮查找匹配
set hlsearch
"自动中心
set incsearch

"去除vi的一致性
set nocompatible

"插件管理
call plug#begin()
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kevinhwang91/rnvimr'
Plug 'connorholyday/vim-snazzy'
"Plug 'kien/rainbow_parentheses.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/andys8/vscode-jest-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"主题
colorscheme snazzy
"设置背景为透明，存在显示bug,通过修改源文件暂时解决
let g:SnazzyTransparent = 1
"使用light主题
let g:lightline = {'colorscheme': 'snazzy'}

"airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'

"custom map
let mapleader=" " 
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source ~/.config/nvim/init.vim<CR>
map tu :tabe<CR>
map tp :bprev<CR>
map tn :bnext<CR>
noremap n nzz
noremap N Nzz
noremap <LEADER>v :nohlsearch<CR>
nnoremap <LEADER>r :RnvimrToggle<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

"function and shell :
"从上次编辑的位置打开
if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0


"'kevinhwang91/rnvimr' config
"不使用默认ranger配置
let g:rnvimr_vanilla = 0
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1
" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
" Disable a border for floating window
let g:rnvimr_draw_border = 1
" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1
" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 100
" Draw border with both
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine
" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]


"Coc config
"coc插件自动安装
let g:coc_global_extensions = ['coc-json', 'coc-git','coc-markdownlint','coc-markdown-preview-enhanced','coc-pyright','coc-clangd','coc-sh','coc-snippets','coc-marketplace','coc-emoji','coc-markmap','coc-vimlsp']

"将行号左侧区域融合
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use key-C to open coc config
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
call SetupCommandAbbrs('C', 'CocConfig')

" completion

"map tab to completion select next and preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"	
"跳到报错位置
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"跳转到函数定义位置
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" markdown config
" Create markmap from the whole file
nmap <Leader>m <Plug>(coc-markmap-create)
" Create markmap from the selected lines
vmap <Leader>m <Plug>(coc-markmap-create-v)	
