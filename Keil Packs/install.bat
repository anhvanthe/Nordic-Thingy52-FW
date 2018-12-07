@echo off
setlocal EnableDelayedExpansion

echo Please wait. Searching for Keil PackUnzip.exe...

:reg_search
    reg query HKEY_CLASSES_ROOT\PACKFILE\Shell\open\command
    if ERRORLEVEL 1 goto:reg_search_failed

    for /f "tokens=3" %%a in ('reg query HKEY_CLASSES_ROOT\PACKFILE\Shell\open\command') do set "PACK_UNZIP=%%a"

:install
    echo.
    echo * Selected Keil PackUnzip.exe location: %PACK_UNZIP% *

    echo.
    echo * Installing all Packs... *
    for /r "%cd%" %%f in (*.pack) do (
        echo Installing... "%%f"
        %PACK_UNZIP% "%%f" --embedded 2>NUL
    )

    echo.
    echo * Installation done *

    goto:success

:reg_search_failed
    echo.
    echo "PackUnzip.exe was not found in the registry."
    echo.
    echo * Installation failed *
    pause

:success
