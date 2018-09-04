@echo off
::设置路径变量
set dirPath=%cd%

:: 切换目录和创建目录
cd ..\
md vimfiles\bundle

:: 创建配置文件
del /f /q %dirPath%\vimrc\_vimrc
echo filetype off >>%dirPath%\vimrc\_vimrc
echo set nocompatible >>%dirPath%\vimrc\_vimrc
echo set rtp+=%cd%\vimfiles\bundle\Vundle.vim >>%dirPath%\vimrc\_vimrc
echo call vundle#begin('%cd%\vimfiles\bundle\')>>%dirPath%\vimrc\_vimrc
:: 引入插件文件
type %dirPath%\plugin\plugin.txt>>%dirPath%\vimrc\_vimrc

:: 拷贝文件
copy %dirPath%\vimrc\_vimrc %cd%

:: git获取插件管理
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git vimfiles/bundle/Vundle.vim

:: 拷贝目录
XCOPY vim-config vimfiles\bundle\vim-config\ /S /H /Y /Q

pause>nul

:: 删除vim-config目录
rd /s /Q vim-config