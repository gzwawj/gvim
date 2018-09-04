# vim通用配置与插件配置
---

```vimrc
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

inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O
"设置跳出自动补全的括号
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
" 将tab键绑定为跳出括号
inoremap <TAB> <c-r>=SkipPair()<CR>
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
```
