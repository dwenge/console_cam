2>nul mkdir %OUTPUT_DIR%
xcopy /y packages\escapi\libraries\escapi.dll %OUTPUT_DIR%
dart compile exe -o %OUTPUT_FILENAME% %INPUT_FILENAME%
