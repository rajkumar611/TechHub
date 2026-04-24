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
echo Step 2: Ensuring index.md exists (safety check)...
if not exist "C:\Users\QBE\Downloads\Tech-Blog\docs\index.md" (
  (
    echo ---
    echo hide:
    echo   - toc
    echo ---
    echo.
    echo # Tech Hub
    echo.
    echo Personal technology learning notes covering APIs, Cloud, Architecture, AI, .NET, and more.
    echo.
    echo ^> **Last updated: (pending^)**
    echo.
    echo ---
    echo.
    echo ^| Category ^| Topics ^|
    echo ^|---|---^|
    echo ^| **APIs ^& Web** ^| API Gateway, REST, Middleware, SignalR, gRPC, nginx ^|
    echo ^| **Cloud ^& DevOps** ^| Azure, Docker, Kubernetes, Terraform, CI/CD ^|
    echo ^| **Architecture** ^| Design Patterns, Microservices, DDD ^|
    echo ^| **AI ^& Modern Tech** ^| AI Agents, RAG, LLM, MCP Servers, Vector Embeddings ^|
    echo ^| **.NET ^& C#** ^| Entity Framework, Async/Await, Blazor, Hangfire ^|
    echo ^| **Tools ^& Platforms** ^| Git, Dynatrace, Monitoring, JetBrains ^|
    echo.
    echo ---
    echo.
    echo *Use the navigation tabs above or the search bar to find any topic.*
  ) > "C:\Users\QBE\Downloads\Tech-Blog\docs\index.md"
  echo   index.md was missing - recreated automatically.
) else (
  echo   index.md OK.
)

echo.
echo Step 3: Stamping last-updated time (New Zealand Time)...
powershell -Command "$nz=[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow,'New Zealand Standard Time'); $ts=$nz.ToString('h:mm tt, d MMMM yyyy'); $f='C:\Users\QBE\Downloads\Tech-Blog\docs\index.md'; (Get-Content $f) -replace '^\*Last updated:.*\*$', ('*Last updated: '+$ts+' (New Zealand Time)*') | Set-Content $f; Write-Host ('  Timestamp set to: '+$ts)"

echo.
echo Step 4: Registering new files in mkdocs.yml nav...
powershell -ExecutionPolicy Bypass -File "%~dp0update-nav.ps1"

echo.
echo Step 5: Committing to Git...
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
