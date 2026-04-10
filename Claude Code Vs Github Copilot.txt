Give me differences between Claude Code Vs Github Copilot. My friend told me to explore Claude Code. I told, I already use Github Copilot as part of my day-to-day work in Office and this Github Copilot is part of my Visual Studio 2022 and I use it for my c# .net development.
I never used Claude Code. Explain me in detail but easy to understand. Not more than 10 to 15 lines.

GitHub Copilot (what you use): IDE-integrated tool that provides real-time code suggestions as you type in VS 2022. You write code → Copilot suggests completions → you accept/reject. It's an inline assistant helping you write code faster.
Claude Code: Standalone command-line tool that's more agentic — you delegate entire coding tasks to Claude (e.g., "Refactor this file," "Debug this error," "Add unit tests"). Claude can read files, write code, execute commands, run tests, and iterate. It's task-oriented, not inline suggestions.
Key difference: Copilot = you drive, it suggests. Claude Code = you delegate, it executes. Copilot works inside VS 2022; Claude Code works from terminal. For complex tasks/refactoring, Claude Code might be better. For day-to-day coding, Copilot inline suggestions are faster. They complement each other — use both!

Github copilot is also generating me the code, new or fresh files and it can create a project, add tests for me.
You're absolutely right! GitHub Copilot (especially through chat in VS 2022) can generate new files, create projects, and add tests. My distinction wasn't entirely accurate.
Real differences: Both can generate code, files, tests. But Claude Code runs from terminal/CLI (not IDE-bound), uses Claude's LLM (potentially different/newer model), integrates with MCP servers for extensibility (GitHub Copilot doesn't), and provides agentic workflow (execute, test, iterate in one flow). Copilot is tightly integrated in VS 2022; Claude Code is standalone CLI tool.
Bottom line: If you're happy with Copilot in VS 2022, stick with it. Claude Code is useful if you want terminal-based workflow, MCP integrations, or prefer Claude's model over Copilot's.

In Github Copilot, we can select Claude's model
You're correct, and I appreciate the correction! If GitHub Copilot now allows selecting Claude's model as an option, then the distinction I made is even less clear-cut. You can already use Claude within Copilot through model selection.
In that case: The main differences now are workflow-based: Claude Code (terminal/CLI) offers agentic workflow with MCP server integrations for connecting to external tools/services, while GitHub Copilot (IDE-integrated) is optimized for inline coding in VS 2022. If both can use Claude's model and generate code/tests, the choice depends on whether you prefer IDE integration or terminal-based agentic task delegation.

Terminal based integration or CLI means through Command prompt ?
Yes, exactly! CLI (Command Line Interface) = Terminal/Command Prompt. When I say "terminal-based," I mean you run Claude Code from Command Prompt (Windows), PowerShell, or Terminal (Mac/Linux) by typing commands like claude code <task>.
Contrast: GitHub Copilot is GUI-based (graphical interface inside VS 2022 where you click/type). Claude Code is CLI-based (you type commands in terminal). Both are valid workflows — just different interfaces.