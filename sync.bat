@echo off
echo ========================================
echo   Tech Hub - Sync Learnings to Blog
echo ========================================

set LEARNINGS=C:\Users\QBE\OneDrive\Desktop\Learnings
set DOCS=C:\Users\QBE\Downloads\Tech-Blog\docs

echo.
echo Step 1: Copying files from Learnings folder...

REM Copy all .txt files recursively (including subfolders) and rename to .md
powershell -Command "$l='%LEARNINGS%'; $d='%DOCS%'; Get-ChildItem -Path $l -Recurse -Filter '*.txt' | ForEach-Object { $rel=$_.FullName.Substring($l.Length+1); $dest=Join-Path $d ($rel -replace '\.txt$','.md'); $dir=Split-Path $dest; if(-not(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force | Out-Null}; Copy-Item $_.FullName $dest -Force; Write-Host ('  Copying: '+$rel) }"

echo.
echo Step 2: Committing to Git...
cd /d "C:\Users\QBE\Downloads\Tech-Blog"
git add -A
git commit -m "sync: update from Learnings folder"
git push

echo.
echo ========================================
echo   Done! Blog will update in ~2 minutes
echo   https://rajkumar611.github.io/TechHub
echo ========================================
pause
