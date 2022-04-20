function! s:common_setting()
  set termguicolors
  set tgc
  set nocompatible
  set hidden
  syntax on
  set t_ZH=[3m
  set t_ZR=[23m
  set nu
  set cst
  let g:floaterm_winblend=20
  let g:floaterm_background='white'
  "let g:gutentags_cache_dir='/home/hutan/data/workspace/tags'
  set path=python,power/**/*,export,simulation,timing/**/*,common,parser,edau/**/*,./,layout_effects/**,power_intent/**/*,scenario/**/*,emir_reports/pym,layout/**/*,seascape/**/*
  set ai
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
  set backspace=indent,eol,start
  set background=light
  colo lightone
  set numberwidth=8
  set laststatus=2
  set hlsearch
  set incsearch
  set foldmethod=manual
  set completeopt=noinsert,menuone,noselect
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set completeopt=menu,menuone
  set guicursor=n-v-c-sm:block,i-ci-ve:ver90,r-cr-o:hor20
  hi Comment gui=italic cterm=italic
endfunction

call plug#begin('~hutan/.config/nvim/plugged')
"Plug 'gosukiwi/vim-atom-dark'
Plug 'yegappan/taglist'
"Plug 'vim-scripts/c.vim'
"Plug 'funorpain/vim-cpplint'
Plug 'vim-airline/vim-airline'
Plug 'tsingyixy77/vim-airline-themes'
Plug 'thaerkh/vim-indentguides'
"Plug 'Yggdroot/indentLine'
"Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'vim-scripts/Tagbar'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'vim-scripts/AutoComplPop'
Plug 'ackyshake/VimCompletesMe'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'dyng/ctrlsf.vim'
Plug 'edkolev/tmuxline.vim'
"Plug 'simplyzhao/cscope_maps.vim'
Plug 'tsingyixy77/vim-one'
Plug 'vim-scripts/huiquan_plugin'
call plug#end()
filetype plugin indent on

function! s:open_tag_file()
  if exists("t:load_tag") > 0
    return
  endif
  let ff = findfile('TAGS', '.;')
  let length = strlen(ff)
  if length > 0
    execute "ex " ff
    execute "set ro"
    let t:load_tag = 1
    execute "bp"
  endif
endfunction

function! s:highlight_cpp()
  hi sc_templates guifg=#0abbbb gui=italic
  hi ns_name guifg=#0abbbb gui=bold,italic
  hi class_name guifg=#228888 gui=bold,italic
  hi ns_class_name guifg=#228888 gui=bold,italic
  hi scPointer guifg=#66aa66 gui=bold
  hi static_function guifg=#789abc gui=italic
  hi cSelf guifg=#0abbbb gui=italic
  hi cStructure guifg=#2fcccc gui=italic
  hi cppStructure guifg=#2fcccc gui=italic
  hi scType guifg=#0abbbb gui=bold
  hi sc_temp_type guifg=#0abbbb gui=italic
  if &background ==# 'light'
    hi cppDEBUG guifg=#aaaaaa gui=italic cterm=italic
    hi AASSERT guifg=666666 gui=Bold
  else
    hi cppDEBUG guifg=#666666 gui=italic cterm=italic
    hi AASSERT guifg=#666666 gui=Bold
  endif
endfunction
function! s:setup_cpp()
  set ts=2 sw=2 sts=2
  set tags=cctags
  nnoremap <silent><Leader>;; I//<ESC>
  call s:highlight_cpp()
  "call s:open_tag_file()
endfunction

function! s:setup_py()
  set tags=pytags,export_tags,bp_tags
  set ts=4 sts=4 sw=4
  hi pySelf guifg=#0abbbb gui=italic
  if &background ==# 'light'
    hi pythonDEBUG guifg=#aaaaaa gui=italic cterm=italic
    hi AASSERT guifg=666666 gui=Bold
  else
    hi pythonDEBUG guifg=#666666 gui=italic cterm=italic
    hi AASSERT guifg=#666666 gui=Bold
  endif
  nnoremap <silent><Leader>;; I#<ESC>
  "call s:open_tag_file()
endfunction


function! s:add_file_open_hook()
  autocmd BufNewFile,BufRead,BufEnter *.cc,*.h call s:setup_cpp()
  autocmd BufNewFile,BufRead,BufEnter *.py call s:setup_py()
  autocmd BufWrite *.cc,*.py,*.h silent! exe ':%s/\s\+$//<CR>'
endfunction

function! s:setup_plugin_config()
  "let g:acp_behaviorKeywordCommand ="<c-x><c-u>"
  let g:tagbar_left=1
  let g:tagbar_width=30
  let g:tagbar_autopreview=1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_powerline_fonts = 1
  let g:airline_theme="random"
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  "let g:airline_left_sep = ''
  "let g:airline_right_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#exclude_preview = 1
  let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  let g:airline#extensions#tabline#buffers_label = ''
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#whitespace#symbol = '!'
  let g:airline#extensions#tagbar#enabled = 1
  let g:indentguides_spacechar = '│'
  let g:indent_blankline_char = '│'
  let g:indentguides_ignorelist = ['text', 'vim', 'diff', 'run_stats', 'golden']
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:clipboard = {
	\   'name': 'myClipboard',
	\   'copy': {
	\      '+': 'tmux load-buffer -',
	\      '*': 'tmux load-buffer -',
	\    },
	\   'paste': {
	\      '+': 'tmux save-buffer -',
	\      '*': 'tmux save-buffer -',
	\   },
	\   'cache_enabled': 1,
	\ }
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_tab_guides = 0
  " OmniCppComplete
  let OmniCpp_NamespaceSearch = 1
  let OmniCpp_GlobalScopeSearch = 1
  let OmniCpp_ShowAccess = 1
  let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
  let OmniCpp_MayCompleteDot = 1 " autocomplete after .
  let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
  let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
  let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
endfunction

function! s:set_conceal_color()
	if &background ==# 'light'
		let g:indentguides_conceal_color='guifg=#dedede'
		hi LineNr gui=italic guifg=#dedede
	    "    hi Conceal guifg=#dedede
	else
		let g:indentguides_conceal_color='guifg=#555555'
		hi LineNr gui=italic guifg=#454545
	    "    hi Conceal guifg=#232323
	endif
endfunction

function! s:map_key()
  nnoremap <Leader>ww :IndentGuidesToggle<CR>
  nnoremap qq :xa<CR>
  nnoremap <silent><Leader>yy "+yy
  nnoremap <silent><Leader>pp "+p
  nnoremap .h :e %:r.h<CR>
  nnoremap .cc :ex %:r.cc<CR>
  nnoremap tt :FloatermToggle<CR>
  nnoremap <Leader>ff :find 
  nnoremap <C-S> <ESC>/
  nnoremap n :bn<CR>
  nnoremap <Leader>bb :%s/\s\+$//
endfunction

au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else |exe "norm $"| endif | endif
call s:common_setting()
call s:add_file_open_hook()
call s:setup_plugin_config()
call s:set_conceal_color()
call s:map_key()
"call s:save_last_place()
let g:indentguides_spacechar = '┆'
"autocmd BufReadPost * exe "normal! g`\""
"  \ if line("'\"") > 1 && line("'\"") <= line("$") |
"  \   exe "normal! g`\"" |
"  \ endif
