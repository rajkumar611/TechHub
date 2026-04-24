# Tech-Blog (Tech Hub) — Project Guide

## What This Project Is

A personal tech learning site hosted at **https://rajkumar611.github.io/TechHub**, built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/). Markdown files are authored in a separate OneDrive "Learnings" folder, synced here, and automatically published to GitHub Pages via GitHub Actions.

## Repository Layout

```
Tech-Blog/
├── docs/                  # All markdown content (served by MkDocs)
│   ├── index.md           # Homepage — auto-updated by sync.bat with last-synced timestamp
│   └── *.md               # One file per topic (all at root level)
├── overrides/             # Custom MkDocs Material theme overrides
├── .github/
│   └── workflows/
│       └── deploy.yml     # CI: runs `mkdocs gh-deploy` on every push to master
├── mkdocs.yml             # Site config + full navigation definition
├── sync.bat               # Sync script: copies from OneDrive Learnings → docs/
└── requirements.txt       # Python deps: mkdocs-material
```

## How Publishing Works

1. **Author** — Write `.txt` files in `C:\Users\QBE\OneDrive\Desktop\Learnings`
2. **Sync** — Run `sync.bat`; it copies all `.txt` → `.md` into `docs/`, updates `index.md` timestamp, then `git add / commit / push`
3. **Deploy** — The push triggers `deploy.yml` on GitHub Actions (Ubuntu runner), which installs `mkdocs-material` and runs `mkdocs gh-deploy --force` to the `gh-pages` branch
4. **View** — GitHub Pages serves the compiled HTML site

## Critical Rule: mkdocs.yml nav Must Be Updated Manually

**sync.bat does NOT touch mkdocs.yml.** MkDocs only renders pages that are explicitly listed in the `nav:` section. A file in `docs/` that is absent from `nav:` will never appear on the site.

**Every time sync.bat adds a new file, you must also add a corresponding entry to the `nav:` section in `mkdocs.yml`.**

### Nav Entry Format

```yaml
nav:
  - Category Name:
    - Display Title: Exact Filename.md   # filename is relative to docs/
```

### Categories Currently in Use

| Category | Topic Area |
|---|---|
| AI & Modern Tech | AI, LLMs, MCP, RAG, agents |
| APIs & Web | REST, GraphQL, gRPC, middleware |
| Architecture | Design patterns, microservices |
| Cloud & DevOps | Azure, containers, Terraform, CI/CD |
| Data & Storage | Databases, ORMs |
| Frontend | React, Angular, Node, TypeScript |
| General | Miscellaneous notes |
| .NET & C# | C# language and .NET framework topics |
| Tools & Platforms | Dev tools, monitoring, security tools |

## Common Task: Add a New File to the Site

1. Confirm the file was synced to `docs/` (check it exists)
2. Open `mkdocs.yml`
3. Find the appropriate category under `nav:`
4. Add a line: `    - Display Title: Exact Filename.md`
5. Keep entries alphabetically sorted within each category
6. Commit and push — GitHub Actions will rebuild the site automatically

## Files Intentionally Excluded from the Site

- `docs/My/` — personal notes (also git-ignored via `.gitignore`)
- `docs/My/Bala Questions/` — interview prep (also git-ignored)

## Claude Behaviour Rules

- **Never run `git commit` or `git push` without explicit user instruction.** Even if a script fails mid-way or changes are pending, always ask first.
- **Never run `sync.bat` without explicit user instruction.**
- When asked to execute `sync.bat`, run the script as-is and report what happened — do not manually repeat or substitute any of its steps.

## Deployment

- **Trigger:** Any push to `master` branch
- **Runner:** Ubuntu (GitHub-hosted)
- **Command:** `mkdocs gh-deploy --force --remote-branch gh-pages`
- **Live URL:** https://rajkumar611.github.io/TechHub
