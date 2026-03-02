@echo off
echo ========================================
echo SHL GitHub Push Helper
echo ========================================
echo.

set /p username="Enter your GitHub username: "

if "%username%"=="" (
    echo Error: Username cannot be empty
    pause
    exit /b 1
)

echo.
echo Setting up remote repository...
git remote add origin https://github.com/%username%/shl-grammar-scoring-engine.git 2>nul
if errorlevel 1 (
    echo Remote already exists, updating URL...
    git remote set-url origin https://github.com/%username%/shl-grammar-scoring-engine.git
)

echo.
echo Renaming branch to main...
git branch -M main

echo.
echo Pushing to GitHub...
echo (You may be asked for your GitHub credentials)
git push -u origin main

if errorlevel 0 (
    echo.
    echo ========================================
    echo SUCCESS! Your code is now on GitHub
    echo ========================================
    echo.
    echo Your repository URL:
    echo https://github.com/%username%/shl-grammar-scoring-engine
    echo.
    echo NEXT STEP: Submit this URL in the SHL Assessment Form
    echo.
) else (
    echo.
    echo Push failed. Common issues:
    echo 1. Repository doesn't exist on GitHub - create it first at https://github.com/new
    echo 2. Authentication failed - use Personal Access Token as password
    echo 3. Network issue - check your internet connection
    echo.
)

pause
