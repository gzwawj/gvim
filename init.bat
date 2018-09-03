@echo off
:: 创建文件目录

cd ..\
set dirPath= %cd%

:: md vimfiles\bundle
:: git clone --depth 1 https://github.com/gzwawj/vim-config.git vimfiles/bundle/vim-config
:: git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git vimfiles/bundle/vim-config

(echo filetype off
echo set nocompatible
echo set rtp+=E:/download/google/cmder/vendor/Vim/vimfiles/bundle/Vundle.vim
echo "call vundle#begin('E:/download/google/cmder/vendor/Vim/vimfiles/bundle/')"
)>>a.txt
echo %str%
echo %dirPath%