@echo off
cd "c:\Users\megha\Downloads\shl\shl-audio-scoring-challenge"

echo ========================================
echo SHL GitHub Push - Final Step
echo ========================================
echo.
echo Repository: https://github.com/Meghanakotte/shl-grammar-scoring-engine
echo.
echo Make sure you've created this repository on GitHub (PUBLIC)
echo.
pause

echo.
echo Pushing to GitHub...
echo You may be asked for authentication:
echo - Username: Meghanakotte
echo - Password: Use a Personal Access Token from https://github.com/settings/tokens
echo.

git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Code pushed to GitHub
    echo ========================================
    echo.
    echo Your submission URL:
    echo https://github.com/Meghanakotte/shl-grammar-scoring-engine
    echo.
    echo Copy this URL and submit it in the SHL Assessment Form
    echo.
) else (
    echo.
    echo ========================================
    echo Push failed!
    echo ========================================
    echo.
    echo Possible issues:
    echo 1. Repository doesn't exist - Create it at https://github.com/new
    echo    Name: shl-grammar-scoring-engine
    echo    Visibility: PUBLIC
    echo.
    echo 2. Authentication failed - Use Personal Access Token
    echo    Get token at: https://github.com/settings/tokens
    echo.
)

echo.
echo Opening your GitHub profile...
start https://github.com/Meghanakotte/shl-grammar-scoring-engine

pause
