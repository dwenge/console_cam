@echo off

set SCRIPTS_DIR=.\build_scripts\
set INPUT_DIR=.\bin\
set OUTPUT_DIR=.\build\
set TARGET_FILE=console_cam

set INPUT_FILENAME=%INPUT_DIR%%TARGET_FILE%.dart
set OUTPUT_FILENAME=%OUTPUT_DIR%%TARGET_FILE%.exe

echo Input file: %INPUT_FILENAME%
echo Output file: %OUTPUT_FILENAME%

set target_rule=%1
if [%target_rule%]==[] set target_rule=compile
set script_file=%SCRIPTS_DIR%%target_rule%.bat

call :separator
if not exist %script_file% echo Script "%target_rule%" not found. & goto :END
echo Start script "%target_rule%"
call :separator
call %script_file%
call :separator

echo Done.
exit /b

:SEPARATOR
    echo ----------------------------------------
    goto :EOF

:END
