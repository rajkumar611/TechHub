@echo off
echo ========================================
echo   Tech Hub - Sync Learnings to Blog
echo ========================================

set LEARNINGS=C:\Users\QBE\OneDrive\Desktop\Learnings
set DOCS=C:\Users\QBE\Downloads\Tech-Blog\docs

echo.
echo Step 1: Copying files from Learnings folder...

REM Copy all .txt files and rename to .md
for %%f in ("%LEARNINGS%\*.txt") do (
    echo   Copying: %%~nf
    copy /Y "%%f" "%DOCS%\%%~nf.md" >nul
)

echo.
echo Step 2: Committing to Git...
cd /d "C:\Users\QBE\Downloads\Tech-Blog"
git add docs\*.md
git commit -m "sync: update from Learnings folder"
git push

echo.
echo ========================================
echo   Done! Blog will update in ~2 minutes
echo   https://rajkumar611.github.io/TechHub
echo ========================================
pause
