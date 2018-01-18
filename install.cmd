@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\d-vim
IF NOT EXIST "%APP_PATH%" (
    call git clone -b 3.0 https://github.com/manjuist/d-vim.git "%APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating d-vim
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\.vimrc.plugins" "%APP_PATH%\.vimrc.plugins"
call mklink /J "%HOME%\.vim" "%APP_PATH%\"
call mklink /J "%HOME%\vimfiles" "%APP_PATH%\"

IF NOT EXIST "%APP_PATH%\colors" (
    call mkdir "%APP_PATH%\colors"
)

IF NOT EXIST "%APP_PATH%\autoload" (
    call mkdir "%APP_PATH%\autoload"
)

IF NOT EXIST "%APP_PATH%\plugged" (
    call mkdir "%APP_PATH%\plugged"
)

IF NOT EXIST "%HOME%/.vim/plugged/vim-plug" (
    call git clone https://github.com/junegunn/vim-plug.git "%HOME%/.vim/plugged/vim-plug"
) ELSE (
  call cd "%HOME%/.vim/plugged/vim-plug"
  call git pull
  call cd %HOME%
)

call cp "%HOME%/.vim/plguged/vim-plug/plug.vim" "%HOME%/vimfiles/autoload/plug.vim"

call vim +PlugInstall! +PlugClean +qall

call cp "%HOME%/.vim/plguged/vim-distinguished/colors/distinguished.vim" "%HOME%/vimfiles/colors/distinguished.vim"
call cp "%HOME%/.vim/plguged/molokai/colors/molokai.vim" "%HOME%/vimfiles/colors/molokai.vim"
