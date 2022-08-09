IF EXIST "%OUTPUT_DIR%" (
    for /F "delims=" %%i in ('dir /b "%OUTPUT_DIR%"') do (
        2>nul rd /s /q "%OUTPUT_DIR%%%i" && echo Directory "%OUTPUT_DIR%%%i" removed || del /s /q "%OUTPUT_DIR%%%i"
    )
)
