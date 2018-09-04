@echo off

:: 创建配置文件
del /f /q vimrc\_vimrc
echo filetype off >>vimrc\_vimrc
echo set nocompatible >>vimrc\_vimrc
echo set rtp+=vimfiles/bundle/Vundle.vim >>vimrc\_vimrc
echo call vundle#begin('vimfiles/bundle/')>>vimrc\_vimrc
:: 引入插件文件
type plugin\plugin.txt>>vimrc\_vimrc

:: 拷贝文件
copy vimrc\_vimrc ..\

:: 切换目录和创建目录
cd ..\
md vimfiles\bundle

:: git获取插件管理
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git vimfiles/bundle/Vundle.vim

:: 拷贝目录
XCOPY vim-config vimfiles\bundle\vim-config\ /S /H /Y /Q

pause>nul

:: 删除vim-config目录
::del