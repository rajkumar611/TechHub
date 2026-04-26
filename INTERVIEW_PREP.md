# Interview Prep — Tech Hub Project Q&A

---

## Overview

**Q: What is this project?**

Tech Hub is a personal technology learning site hosted at [rajkumar611.github.io/TechHub](https://rajkumar611.github.io/TechHub). It's a static documentation site where I publish structured notes on topics I learn — covering AI, .NET, cloud, APIs, architecture, frontend, and more.

---

## Why It Was Built

**Q: Why did you build this?**

I built it to turn my learning notes into a searchable, well-structured reference site rather than keeping them scattered in text files. It also gave me hands-on experience with static site generation, CI/CD pipelines, and GitHub Actions — all things I actively work with professionally.

**Q: What problem does it solve?**

I had a growing collection of `.txt` notes in OneDrive that were hard to navigate and search. Tech Hub converts them into a neatly categorised, searchable website with full-text search, syntax-highlighted code blocks, and a clean Material Design UI.

---

## Technology Stack

**Q: What technologies did you use?**

| Layer | Technology |
|---|---|
| Static site generator | [MkDocs](https://www.mkdocs.org/) with the [Material theme](https://squidfunk.github.io/mkdocs-material/) |
| Content format | Markdown (`.md`) |
| Hosting | GitHub Pages |
| CI/CD | GitHub Actions |
| Scripting / automation | PowerShell (`update-nav.ps1`), Batch (`sync.bat`) |
| Version control | Git / GitHub |

**Q: Why MkDocs over alternatives like Jekyll or Hugo?**

MkDocs is Python-based with minimal config, and the Material theme gives a polished result out of the box — sticky navigation, tabs, search with highlighting, dark mode, and code copy buttons — all without writing any frontend code. It was the fastest path from markdown files to a professional-looking docs site.

---

## Architecture & Workflow

**Q: How does the publishing pipeline work end to end?**

1. Notes are written as `.txt` files in a local OneDrive folder
2. `sync.bat` copies them to `docs/` as `.md` files and commits + pushes to GitHub
3. `update-nav.ps1` registers any new files into the `nav:` section of `mkdocs.yml` automatically, categorising by filename keywords and sorting entries alphabetically
4. The push triggers a GitHub Actions workflow (`deploy.yml`) on an Ubuntu runner
5. The runner installs `mkdocs-material` and runs `mkdocs gh-deploy --force`, which builds the site and pushes the compiled HTML to the `gh-pages` branch
6. GitHub Pages serves the site from that branch

**Q: What does the GitHub Actions workflow do exactly?**

It checks out the repo, sets up Python 3, installs `mkdocs-material`, configures git identity, and runs `mkdocs gh-deploy --force --remote-branch gh-pages`. Every push to `master` triggers this automatically — no manual deployment step needed.

---

## Automation

**Q: How did you automate the navigation registration?**

I wrote `update-nav.ps1`, a PowerShell script that:
- Scans `docs/` for `.md` files not yet registered in `mkdocs.yml`
- Categorises each file by keyword-matching its name against a rule table (e.g. a file with "Azure" goes under "Cloud & DevOps")
- Inserts the new entries into the correct category block and sorts them alphabetically
- Writes the updated `mkdocs.yml`

This means I never have to manually edit `mkdocs.yml` when adding new content.

**Q: What categories does the site use?**

| Category | Topics |
|---|---|
| AI & Modern Tech | LLMs, RAG, MCP, AI agents, prompt engineering |
| APIs & Web | REST, GraphQL, gRPC, OAuth, middleware |
| Architecture | Design patterns, microservices, SOLID, CQRS |
| Cloud & DevOps | Azure, Docker, Kubernetes, Terraform, CI/CD |
| Data & Storage | SQL, Redis, MongoDB, CosmosDB, ORMs |
| Frontend | React, Angular, TypeScript, Node.js |
| .NET & C# | Async/await, Entity Framework, Blazor, LINQ |
| Tools & Platforms | Git, GitHub, Dynatrace, JetBrains, Logging |
| General | Miscellaneous notes |

---

## CI/CD & Deployment

**Q: How is continuous deployment set up?**

The GitHub Actions workflow triggers on every push to `master`. There is no manual deployment — the act of pushing is the deployment trigger. The runner builds the static site and pushes the output to the `gh-pages` branch, which GitHub Pages picks up automatically.

**Q: How do you manage the GitHub Pages deployment?**

The workflow uses `mkdocs gh-deploy --force`, which builds the site locally on the runner and pushes only the compiled HTML/CSS/JS to the `gh-pages` branch. The source markdown and config stay on `master` — the two branches have completely different content.

---

## Design Decisions

**Q: Why keep all docs at the root of `docs/` rather than subdirectories?**

MkDocs nav configuration is simpler with a flat structure, and since the categorisation is driven entirely by the `nav:` section in `mkdocs.yml` (not the folder structure), there is no need for subdirectories. The `update-nav.ps1` script handles logical grouping automatically.

**Q: Why PowerShell for the automation script?**

The project runs on Windows, and PowerShell is the native scripting environment. It has strong support for regex, file I/O, and YAML-like text manipulation, making it well-suited for parsing and updating `mkdocs.yml`.

**Q: What would you improve if you were to scale this?**

- Add tags or search filters within categories
- Automate the full sync + nav update + commit into a single idempotent script
- Add a pre-commit hook to validate that all `docs/*.md` files are registered in `nav:` before allowing a push
- Consider a headless CMS if collaborative editing were needed
