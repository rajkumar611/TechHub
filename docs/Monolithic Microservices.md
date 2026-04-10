Monolithic assemblies
Monolithic assembly = One big DLL
Microservices = Many small independent services
A DLL inside a host can become a microservice.
Case 1: DLL alone
OrderService.dll
- Cannot run
- Cannot listen on port
- Cannot accept requests
- Cannot be deployed alone
❌ Not a microservice
Case 2: DLL hosted by Kestrel
dotnet OrderService.dll
- Runs as a process
- Exposes /api/orders
- Can be deployed independently
- Can scale independently
✔ This is a microservice
A DLL becomes a microservice only when it is hosted as an independently running application with its own API endpoint. The DLL alone is not a microservice — the hosted application is.
A microservice is a small, independently running application that owns a single business capability and can be deployed, scaled, and versioned without affecting other services.
A microservice can have multiple services (operations/endpoints/classes) as long as they all belong to the same business capability.
Endpoint = URL + HTTP method that performs an operation.
A .cs file defines endpoints, but it is NOT a microservice.
A microservice is the entire running application hosting those endpoints.

NuGet packages were introduced in .NET Framework 4.0, not .NET 5.
✔ .NET Core and .NET 5+ do NOT use the GAC.
✔ Multiple versions of .NET Core and .NET 5+ can be installed side‑by‑side.
✔ DLLs are loaded from the application’s own folder, not from the GAC.
✔ Because of this, DLL Hell is eliminated in modern .NET.
