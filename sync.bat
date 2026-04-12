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
powershell -Command "$f='C:\Users\QBE\Downloads\Tech-Blog\docs\index.md'; if(-not(Test-Path $f)){ $content=@'
---
hide:
  - toc
---

# Tech Hub

Personal technology learning notes covering APIs, Cloud, Architecture, AI, .NET, and more.

> **Last updated: (pending)**

---

| Category | Topics |
|---|---|
| **APIs & Web** | API Gateway, REST, Middleware, SignalR, gRPC, nginx |
| **Cloud & DevOps** | Azure, Docker, Kubernetes, Terraform, CI/CD |
| **Architecture** | Design Patterns, Microservices, DDD |
| **AI & Modern Tech** | AI Agents, RAG, LLM, MCP Servers, Vector Embeddings |
| **.NET & C#** | Entity Framework, Async/Await, Blazor, Hangfire |
| **Tools & Platforms** | Git, Dynatrace, Monitoring, JetBrains |

---

*Use the navigation tabs above or the search bar to find any topic.*
'@; Set-Content $f $content; Write-Host '  index.md was missing - recreated automatically.' } else { Write-Host '  index.md OK.' }"

echo.
echo Step 3: Stamping last-updated time (New Zealand Time)...
powershell -Command "$nz=[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow,'New Zealand Standard Time'); $ts=$nz.ToString('h:mm tt, d MMMM yyyy'); $f='C:\Users\QBE\Downloads\Tech-Blog\docs\index.md'; (Get-Content $f) -replace '^> \*\*Last updated:.*$', ('> **Last updated: '+$ts+' (New Zealand Time)**') | Set-Content $f; Write-Host ('  Timestamp set to: '+$ts)"

echo.
echo Step 4: Committing to Git...
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
