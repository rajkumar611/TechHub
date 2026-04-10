ReSharper, dotCover, dotPeek, and dotMemory together form the JetBrains .NET developer tools suite, providing code analysis, test coverage, decompilation, and memory profiling capabilities.

All four tools are:
- Built by JetBrains
- Designed specifically for .NET developers
- Installed as Visual Studio extensions or standalone tools
- Focused on code quality, debugging, diagnostics, and developer productivity


ReSharper
ReSharper is a Visual Studio productivity extension that provides advanced code analysis, refactoring, navigation, and code generation.
It improves developer efficiency by detecting code smells, suggesting fixes, and enforcing coding standards across .NET projects.

🟣 dotCover
dotCover is a .NET code coverage tool that measures how much of your code is executed by unit tests.
It integrates with Visual Studio and CI pipelines to show coverage percentages, highlight uncovered lines, and enforce coverage thresholds.
dotCover is a code coverage tool that integrates with Azure DevOps pipelines to measure and enforce test coverage.

🟡 dotPeek
dotPeek is a .NET decompiler that converts compiled DLLs and EXEs back into readable C# code.
It is used to inspect third‑party libraries, debug without source code, and explore assemblies when source is unavailable.
dotPeek is a .NET decompiler that takes compiled binaries (DLLs/EXEs) and reconstructs them back into readable C# code.
It lets you explore classes, methods, IL, metadata, and dependencies even when the original source code is not available.
So yes — it decompiles binaries and lets you read the C# code, but with important clarity:
✔ dotPeek works on compiled assemblies
✔ dotPeek runs outside your application
✔ dotPeek reconstructs source code, not just metadata
✔ dotPeek is used for reverse engineering, debugging, and understanding third‑party libraries

dotPeek decompiles binaries into readable C# code, while Reflection inspects metadata at runtime.

.NET Reflection — 2–4 lines (built‑in runtime feature)
Reflection is a built‑in .NET runtime API that inspects metadata of types, methods, properties, attributes, and assemblies at runtime.
It allows dynamic invocation, type discovery, late binding, and inspection of objects while the application is running.
Reflection works inside your application and does not show actual source code — only metadata.

.NET Reflector — 2–4 lines (external decompiler tool)
.NET Reflector is a third‑party decompiler that converts compiled .NET assemblies (DLLs/EXEs) back into readable C#, VB.NET, or IL code.
It is used for reverse engineering, debugging without source code, and exploring third‑party libraries.
Reflector works outside your application and reconstructs source code, not runtime metadata.




🟢 dotMemory
dotMemory is a .NET memory profiler that analyzes memory usage, detects leaks, and shows object retention paths.
It helps diagnose high memory consumption, GC pressure, and object lifetime issues in .NET applications.

🧠 One‑liner summary
ReSharper improves code quality, dotCover measures test coverage, dotPeek decompiles assemblies, and dotMemory analyzes memory usage.


