DLL Hell/GAC - In the VB6/COM days, DLLs were dumped into System32 and overwritten by installers, so apps constantly broke — that was classic DLL Hell.
.NET Framework solved it using the GAC: strong‑named, versioned, machine‑wide assemblies that could live side‑by‑side.
But the GAC made deployment complex, required admin rights, and wasn’t cross‑platform.
.NET Core removed the GAC entirely and solved DLL Hell differently: every app carries its own DLLs, fully isolated and side‑by‑side, so nothing global gets overwritten.

COM was Microsoft’s pre‑.NET component model. COM DLLs lived in System32 and were shared by all apps, with no versioning. Installing one app could overwrite a DLL used by another — that’s why the COM era is associated with DLL Hell.