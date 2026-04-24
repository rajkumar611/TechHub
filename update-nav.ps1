param(
    [string]$YML  = "$PSScriptRoot\mkdocs.yml",
    [string]$DOCS = "$PSScriptRoot\docs"
)

# Category rules — first matching rule wins (keyword check is case-insensitive)
$rules = @(
    [pscustomobject]@{ Category = 'AI & Modern Tech';   Keywords = 'LLM,SLM,RAG,MCP,Agent,Claude,Langchain,GPT,Perplexity,Prompt Injection,Open Claw,ChatGPT,Embedding,Mistral,Gemini,Ollama,AI' }
    [pscustomobject]@{ Category = 'APIs & Web';          Keywords = 'API Gateway,REST,RPC,gRPC,WCF,SignalR,Middleware,Nginx,nGinx,Kestrel,Webhook,GraphQL,OAuth' }
    [pscustomobject]@{ Category = 'Architecture';        Keywords = 'Design Pattern,DLL,GAC,COM,Modular,Monolithic,Microservice,Latency,Architecture,SOLID,CQRS' }
    [pscustomobject]@{ Category = 'Cloud & DevOps';      Keywords = 'Azure,Akamai,Docker,Kubernetes,Container,Terraform,Bicep,ARM Template,DevOps,DevSecOps,Application Pool,CI/CD,Pipeline,Deployment' }
    [pscustomobject]@{ Category = 'Data & Storage';      Keywords = 'SQL,Prisma,Redis,MongoDB,CosmosDB,Database,Storage,Cache' }
    [pscustomobject]@{ Category = 'Frontend';            Keywords = 'Angular,Vue,React,NodeJS,Node.js,TypeScript,JavaScript,CSS,HTML' }
    [pscustomobject]@{ Category = '.NET & C#';           Keywords = 'Async,Await,Multithreading,Blazor,Entity Framework,Hangfire,Serialization,Deserialization,Roselyn,Roslyn,LINQ,.NET,CSharp' }
    [pscustomobject]@{ Category = 'Tools & Platforms';   Keywords = 'GitHub,Git,Dynatrace,Error Log,Hardware,JetBrains,Sublime,Cursor,YAML,Cyberark,Sharegate,Monitoring,Logging' }
    [pscustomobject]@{ Category = 'General';             Keywords = '' }
)

function Get-Category($filename) {
    foreach ($rule in $rules) {
        if ($rule.Keywords -eq '') { return $rule.Category }
        foreach ($kw in ($rule.Keywords -split ',')) {
            if ($filename -imatch [regex]::Escape($kw.Trim())) {
                return $rule.Category
            }
        }
    }
    return 'General'
}

function Get-EntryTitle($line) {
    if ($line -match '^\s+-\s+(.+?)\s*:') { return $Matches[1] }
    return $line
}

# Parse already-registered filenames from nav section
$ymlLines = Get-Content $YML
$registered = $ymlLines |
    Where-Object { $_ -match '^\s+-\s+.+:\s+(.+\.md)\s*$' } |
    ForEach-Object { $Matches[1].Trim() }

# Find new .md files (root of docs only, skip index.md)
$newFiles = Get-ChildItem -Path $DOCS -Filter '*.md' -File |
    Where-Object { $_.Name -ne 'index.md' -and $registered -notcontains $_.Name }

if ($newFiles.Count -eq 0) {
    Write-Host "  nav: nothing new to register."
    exit 0
}

# Build a lookup: category -> list of new entries to add
$pending = @{}
foreach ($file in $newFiles) {
    $category = Get-Category $file.BaseName
    $entry    = "    - $($file.BaseName): $($file.Name)"
    if (-not $pending.ContainsKey($category)) { $pending[$category] = @() }
    $pending[$category] += $entry
    Write-Host "  Queued [$category]: $($file.BaseName)"
}

# Rebuild yml: for each category block, merge new entries then sort alphabetically
$output = @()
$i = 0
while ($i -lt $ymlLines.Count) {
    $line = $ymlLines[$i]

    # Category header: exactly 2-space indent, ends with colon, no filename
    if ($line -match '^  - (.+):$') {
        $catName = $Matches[1]
        $output += $line
        $i++

        # Collect all existing entries for this category (4-space indent)
        $entries = @()
        while ($i -lt $ymlLines.Count -and $ymlLines[$i] -match '^    - ') {
            $entries += $ymlLines[$i]
            $i++
        }

        # Merge any new entries for this category
        if ($pending.ContainsKey($catName)) {
            $entries += $pending[$catName]
        }

        # Sort entries alphabetically by display title (case-insensitive)
        $output += $entries | Sort-Object { Get-EntryTitle $_ }
    }
    else {
        $output += $line
        $i++
    }
}

$output | Set-Content $YML -Encoding UTF8
Write-Host "  mkdocs.yml updated (entries sorted alphabetically)."
