@echo off
SET /A down=0
SET /A up=0
color 1a
TITLE proverka svyazi

:proverka
:: сервер 1
SET /A down+=1
echo check connect
TIMEOUT /T 1
%SystemRoot%\system32\ping.exe -n 2 192.168.9.136 | find "TTL=" > nul
if %ERRORLEVEL% EQU 0; echo UP %up% && SET /A up+=1 && goto proverka
if %ERRORLEVEL% EQU 1; echo down %down% && SET /A down+=1 && goto checkdown

:checkdown
if "%down%" GEQ "3" (
    shutdown /s
)
goto proverka
:: Конец проверки 
TIMEOUT /T 5
cls
goto proverka