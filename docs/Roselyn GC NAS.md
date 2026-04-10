GC Improvements - Garbage Collector - Improvements in each .Net release

Roslyn Compiler - Converts c# to IL and it is runtime agnostic. Both the runtime engine, CLR (till 4.8) and CoreCLR can execute the code.
- Old compiler was a closed black box
- Couldn’t support modern tooling
- Couldn’t support analyzers, refactoring, live diagnostics
- Couldn’t evolve fast enough for new C# features
- Roslyn made the compiler open, extensible, and IDE-friendly

NAS - Network Attached Storage