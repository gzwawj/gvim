"====================================================================
"						判断操作系统/终端
"====================================================================
"--------------------------------------------------------------------
"		判断操作系统是windows还是linux
"--------------------------------------------------------------------
let g:iswindows=0
let g:islinux=0
if(has("win32") || has("win64") || has("win95") || has("16"))
	let g:iswindows=1
else
	let g:islinux=1
endif

"--------------------------------------------------------------------
"		判断是终端还是gvim
"--------------------------------------------------------------------
if has("gui_running")
	let g:isGUI=1
else
	let g:isGUI=0
endif

"====================================================================
"						软件的默认设置
"====================================================================
"--------------------------------------------------------------------
"		windows gvim 默认设置
"--------------------------------------------------------------------
if(g:iswindows && g:isGUI)
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function MyDiff()
	  let opt = '-a --binary '
	  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	  let arg1 = v:fname_in
	  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	  let arg2 = v:fname_new
	  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	  let arg3 = v:fname_out
	  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	  if $VIMRUNTIME =~ ' '
	    if &sh =~ '\<cmd'
	      if empty(&shellxquote)
	        let l:shxq_sav = ''
	        set shellxquote&
	      endif
	      let cmd = '"' . $VIMRUNTIME . '\diff"'
	    else
	      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
	    endif
	  else
	    let cmd = $VIMRUNTIME . '\diff'
	  endif
	  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	  if exists('l:shxq_sav')
	    let &shellxquote=l:shxq_sav
	  endif
	endfunction
endif

"--------------------------------------------------------------------
"		linux gvim/vim 默认设置 （有修改）
"--------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配
 
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
 
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
 
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
 
        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用
 
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

"====================================================================
"						用户自定义设置
"====================================================================
"--------------------------------------------------------------------
"		Vundle 插件管理工具配置
"   :BundleList -列举出列表中(.vimrc中)配置的所有插件
"   :BundleInstall -安装列表中全部插件
"   :BundleInstall! -更新列表中全部插件
"   :BundleSearch foo -查找foo插件
"   :BundleSearch! foo -刷新foo插件缓存
"   :BundleClean -清除列表中没有的插件
"   :BundleClean! -清除列表中没有的插件
"--------------------------------------------------------------------

filetype off
set nocompatible
set rtp+=E:/download/google/cmder/vendor/Vim/vimfiles/bundle/Vundle.vim
call vundle#begin('E:/download/google/cmder/vendor/Vim/vimfiles/bundle/')

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'   "主题
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'    "文件树
Plugin 'Xuyuanp/nerdtree-git-plugin'    "文件树git状态
Plugin 'fholgado/minibufexpl.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'mattn/emmet-vim'
Plugin 'isRuslan/vim-es6' "es6
Plugin 'vimchina/vimcdoc'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive' "git集成
Plugin 'shawncplus/php.vim' "php
Plugin 'AD7six/vim-activity-log'

call vundle#end()

"--------------------------------------------------------------------
"		编码配置
"--------------------------------------------------------------------
"设置gvim内部的编码，默认不更改"
set encoding=utf-8

"设置当前文件编码，可以更发改，如：gbk"
set fileencoding=utf-8

"设置支持打开的文件编码"
set fileencodings=utf-8,gbk,cp936,ucs-bom,latin-1

"文件格式，默认 ffs=dos,unix"
"设置新文件的EOL格式，可以更改，如：dos（windows系统常用）"
set fileformat=unix

"给出文件的EOL格式类型"
set fileformats=unix,dos,mac

if(g:iswindows && g:isGUI)
	"解决菜单乱码"
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim

	"解决consle输出乱码"
	language messages zh_CN.utf-8
endif
"查看当前文件的编码
"set fenc 
"vim中转换编码
":set fenc=utf8
"--------------------------------------------------------------------
"		编写文件时的配置
"--------------------------------------------------------------------
"启用文件类型侦测"
filetype on

"针对不同的文件类型加载对应的插件"
filetype plugin on

"启用缩进"
filetype plugin indent on

"启用智能对齐方式"
set smartindent

"备份设置"
set nobackup
set noswapfile
set undodir=D:/.undodir

"将tab键转换为空格"
set expandtab

"设置tab键的宽度，可以更改，如：宽度为2"
set tabstop=4

"换行是自动缩进宽度，可更改"
set shiftwidth=4

"设置自动折行
set wrap
"set nowrap

"指定按一次backspace就删除shiftwidth宽度"
set smarttab

"启用折叠"
"set foldenable
"set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldcolumn=0            " 设置折叠区域的宽度
"setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码
"set foldclose=all          " 设置为自动关闭折叠 

"indent折叠方式"
set foldmethod=indent

"marker折叠方式"
"set foldmenthod=marker

"当文件在外部被修改，自动更新该文件"
set autoread

"索搜逐字高亮"
set hlsearch
set incsearch

"行内替换"
set gdefault

"代码补全"
set complete=.,w,b,k,t,i
set completeopt=preview,menu

"保证语法高亮"
if has("syntax")
	syntax on
endif
"--------------------------------------------------------------------
"		界面设置
"--------------------------------------------------------------------
"显示行号"
set number

"启用状态栏信息"
set laststatus=2

"设置命令行的高度，默认为1"
set cmdheight=2

"背景色"
set background=dark

"高亮当前行"
set cursorline
"set cursorcolumn
hi Cursorline cterm=NONE ctermbg=DarkGrey ctermfg=NONE guibg=NONE guifg=NONE
"hi Cursorcolumn cterm=NONE ctermbg=DarkGrey ctermfg=NONE guibg=NONE guifg=NONE

"设置字体"
set guifont=Consolas:h12:cANSI 

"设置不自动换行"
set nowrap

"去掉欢迎界面"
set shortmess=atI

"状态行显示的内容"
function! File_size(f)
    let l:size = getfsize(expand(a:f))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.' bytes'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'k'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'm'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
    endif
endfunction
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}:%{&fenc!=''?&fenc:&enc}]\ [SIZE=%{File_size(@%)}\]\ [TYPE=%Y]\ [COL=%l,ROW=%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 

"设置gvim窗口初始位置和大小"
if g:isGUI
	"窗口启动时自动最大化"
	"au GUIEnter * simalt ~x

	"指定窗口出现的位置，坐标原点在屏幕左上角"
	winpos 500 80

	"指定窗口大小，lines为高度，columns为宽度"
	set lines=40 columns=120

endif

"设置代码配色方案"
if g:isGUI
	"gvim配色方案"
	colorscheme solarized "Tomorrow-Night-Eighties
else
	"终端配色方案"
	"colorscheme solarized "Tomorrow-Night-Eighties
endif

"显示/隐藏菜单栏、工具栏、滚动条，可用ctrl+f11切换"
if g:isGUI
	set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"====================================================================
"						插件设置
"====================================================================
"--------------------------------------------------------------------
"		MarkdownPreview设置
"--------------------------------------------------------------------
if g:isGUI

else
    let g:mkdp_path_to_chrome = 'C:\Users\guo5z\AppData\Local\Google\Chrome\Application\chrome.exe'
    let g:mkdp_auto_close = 1
    let g:mkdp_auto_start = 1
    nmap <F7> <Plugin>MarkdownPreview
    nmap <F8> <Plugin>StopMarkdownPreview
endif


"--------------------------------------------------------------------
"		NERDTree设置
"--------------------------------------------------------------------
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>

"--------------------------------------------------------------------
"       emmet-vim设置
"--------------------------------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
let g:user_emmet_leader_key='<C-l>'
"--------------------------------------------------------------------
"       vim-javascript设置
"--------------------------------------------------------------------
let g:javascript_plugin_jsdoc=1

"--------------------------------------------------------------------
"       AD7six/vim-activity-log设置
"--------------------------------------------------------------------
let g:activity_log_location="E:/test.log"

" let g:tablify_raw_delimiter="|"



