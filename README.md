# vim-
```bat
@echo off
for /f "tokens=*" %%f in (common) do (
    echo %%f
)

echo qwe>>../demo.txt
del /f /q /s common
```