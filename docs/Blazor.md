Blazor WebAssembly uses MSAL to authenticate users against Azure AD through the login.microsoftonline.com endpoints. MSAL handles login, token caching, and silent token refresh automatically whenever the app requests a token, ensuring the SPA stays authenticated without manual token management.
Browser loads index.html

2. Browser JS engine starts Blazor boot JS

3. Browser WASM engine initializes

4. Browser downloads:

   - dotnet.wasm (runtime)

   - app.wasm (optional AOT)

   - *.dll (IL assemblies)

5. Browser executes WASM code

6. .NET runtime starts

7. Your C# code runs

 

Case 1: Default / Interpreter mode (most common)

Browser executes → WASM

WASM contains → .NET runtime

.NET runtime interprets → IL

 

Case 2: AOT (Ahead‑Of‑Time compiled)

IL → compiled ahead of time → WASM

Browser executes → WASM directly

 

IL is converted to WASM at build time

Browser executes that WASM

IL is not interpreted at runtime

Faster execution, larger download

 

📌 Still: browser executes WASM, not IL

 

The browser only executes WASM.

IL is either interpreted by a WASM‑based .NET runtime or precompiled into WASM.

 

 

Browser

├── JavaScript Engine  ← executes .js

├── WebAssembly Engine ← executes .wasm

│    └── .NET Runtime (WASM)

│         └── Executes / interprets .dll (IL)

├── DOM / CSS Engine

│    └── Updated via render-tree diffs

 

All modern browsers include a WebAssembly engine.

In a Blazor WebAssembly app, the server sends WASM files (including the .NET runtime), DLLs (IL), JavaScript, CSS, and assets.

The browser executes WASM using its WebAssembly engine, runs JavaScript via its JS engine, and the .NET runtime inside WASM interprets or executes the IL assemblies.

Blazor builds a render tree, computes diffs, and updates the existing DOM rather than generating HTML files.

Subsequent interactions update the DOM incrementally, following the SPA model.

Blazor WebAssembly app is a Single Page Application. The server sends only one HTML file (index.html). All Razor pages are actually components that load inside this single page. Routable components act like pages, and non‑routable components act like controls. The entire app — DLLs, WebAssembly runtime, JS, CSS — is downloaded to the browser, and the browser runs the .NET code locally. Only API calls go to the server. Authentication uses AAD tokens stored in the browser, and MSAL handles silent refresh. This is the same SPA model used by React and Angular.
DOM is the browser’s live tree of the page. Blazor uses a virtual DOM to update only what changed, re-renders efficiently, and uses JS interop whenever it needs to touch the real DOM.

