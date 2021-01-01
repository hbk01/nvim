
" vim-plug {{{

" vim-plug install location
if has("nvim")
    let vim_plug_path = '~/.config/nvim/autoload/plug.vim'
    let plugins_path = '~/.config/nvim/plugins/'
else
    let vim_plug_path = '~/.vim/autoload/plug.vim'
    let plugins_path = '~/.vim/plugins/'
endif

" vim-plug download url.
let plug_down_url = 'https://gitee.com/hbk01/vim-plug/raw/master/plug.vim'

" download vim-plug and source it.
if empty(glob(vim_plug_path))
    execute "!" . "curl" . " -fLo " . vim_plug_path . " --create-dirs " . plug_down_url
endif

" install plugin
if empty(glob(plugins_path))
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(plugins_path)

" 彩虹括号
Plug 'luochen1990/rainbow'

" vim 主题
Plug 'connorholyday/vim-snazzy'

" vim 下方的状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim 注释插件
Plug 'preservim/nerdcommenter'

" vim 文件树插件
Plug 'scrooloose/nerdtree'

" nerdtree 显示git状态插件
Plug 'Xuyuanp/nerdtree-git-plugin'

" 剪切板扩展
Plug 'junegunn/vim-peekaboo'

" 代码补全框架
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" 模糊查找工具
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" fcitx5 auto switch zh_CN and EN
Plug '520Matches/fcitx5.vim'

call plug#end()

" for vim-snazzy
" set cursorline " 高亮当前行没有透明
let g:SnazzyTransparent=1 " for alpha
color snazzy

" for vim-airline
let g:airline_theme = 'luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fromatter = 'default'

" for rainbow
let g:rainbow_active=1

" for nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }, 'java': { 'left': '/**', 'right': '*/'} }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"for NERDTree
" close display []
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  :'x',
            \ 'Staged'    :'+',
            \ 'Untracked' :'-',
            \ 'Renamed'   :'r',
            \ 'Unmerged'  :'═',
            \ 'Deleted'   :'d',
            \ 'Dirty'     :'✗',
            \ 'Ignored'   :'☒',
            \ 'Clean'     :'✔︎',
            \ 'Unknown'   :'?',
            \ }


" for nerdtree
nnoremap tt :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='-'

" for coc {{{
" auto install coc extensions
let g:coc_global_extensions=[
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-css',
            \ 'coc-emmet',
            \ 'coc-git',
            \ 'coc-go',
            \ 'coc-highlight',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-marketplace',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ 'coc-yank']

set hidden
set updatetime=100
set shortmess+=c
set signcolumn=yes

" 按tab 导航补全
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 回车键确认补全，
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" end coc }}}

" }}}

" base settings{{{
syntax on
filetype plugin indent on
set fdm=marker
" set fdm=indent
set wildmenu
set t_Co=256
set nocompatible
set showcmd
set list
set listchars=tab:\|\ ,trail:×
set number
set relativenumber
set scrolloff=5
set ruler
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autochdir
set backupcopy=yes
set ignorecase
set smartcase
set nowrapscan
set incsearch
set hlsearch
set noerrorbells
set novisualbell
set expandtab
set t_vb=
set magic
set autoindent
set smartindent
set backspace=indent,eol,start
set laststatus=2
set mouse=
set spelllang=en,cjk
set helplang=cn
set langmenu=zh_CN.UTF-8
set nospell
"}}}

" map settings{{{

" leader key
let mapleader=" "

" save
noremap S :w<CR>

" close this buffer (don't close window)
noremap E :bd!<CR>

" close this window (don't close buffer)
noremap Q :q<CR>

" source vimrc
noremap <LEADER>R :source $MYVIMRC<CR>

" edit .vimrc file.
nnoremap .vimrc :e $MYVIMRC<CR>

" on insert mode, into calc.
inoremap <C-p> <C-r>=

" quick command
noremap ; :

nnoremap tr :!tr -c 
nnoremap rtr :r !tr -c 

" Enable FZF preview window
let g:fzf_preview_window="right:60%"
" fzf
noremap <LEADER>ff :Files<CR>
noremap <LEADER>fm :Maps<CR>
noremap <LEADER>fb :Buffers<CR>
noremap <LEADER>fh :History<CR>

" next/pre buffer
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap <C-l> :buffers<CR>

" press the Ctrl+g to open lazygit.
nnoremap <C-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>a

" goto last line and set cursorline on screen center.
noremap G Gzz

" quick jump 5 lines.
noremap J 5j
noremap K 5k

" copy & paste with system
" noremap y "+y
" noremap p "+p
" 大写时才与系统剪切板交互
noremap Y "+y
noremap P "+p

" jump to line start and line end
noremap H ^
noremap L $

" clear search highlight
nnoremap <LEADER><CR> :nohlsearch<CR>
" enter vim clear search result
exec "nohlsearch"

" next/pre in search result
noremap n nzz
noremap N Nzz

" redo, undo is 'u'
nnoremap U <C-r>

" auto indent
" nnoremap <C-f> ggVG=

" Compile function
noremap R :call CompileRunGcc()<CR>
func! CompileRunGcc()
    " save file first.
    exec "w"

    " if has makefile, use make.
    if filereadable("./makefile") || filereadable("./Makefile")
        set splitbelow
        :sp
        term make -s
    elseif &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
    elseif &filetype == 'dart'
        exec "CocCommand flutter.run -d ".g:flutter_default_device
        CocCommand flutter.dev.openDevLog
    elseif &filetype == 'javascript'
        set splitbelow
        :sp
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run .
    endif
endfunc
"}}}

" 分屏设置{{{
" sph: 左右分屏
" spj: 上下分屏
noremap sph :vsplit<CR>
noremap spj :split<CR>

" 设置分屏窗口大小
noremap <LEADER>s :res -5<CR>
noremap <LEADER>w :res +5<CR>
noremap <LEADER>d :vertical resize+5<CR>
noremap <LEADER>a :vertical resize-5<CR>

" 在分屏窗口中切换光标位置
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l
" }}}


