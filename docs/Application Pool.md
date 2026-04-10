Application Pool
     ↓
Worker Process (w3wp.exe)
     ↓
.NET Runtime (CLR/CoreCLR)
     ↓
ThreadPool
     ↓
Threads (OS threads)

An IIS can have multiple App Pools
.Net Runtime requests OS to create threads.
And these threads can be maintained inside a threadpool.

Example:
- App Pool A → .NET Framework 4.8
- App Pool B → .NET Core
- App Pool C → Classic pipeline
- More App Pools → more worker processes → more parallelism

An Application Pool in IIS is a logical container that isolates web applications by running them in their own worker process (w3wp.exe). The main advantages are isolation, security, independent configuration, independent recycling, and better performance. If one app crashes or leaks memory, other apps in different App Pools remain unaffected.

Client Request
      ↓
      IIS
      ↓
Application Pool
      ↓
Worker Process (w3wp.exe)
      ↓
.NET Runtime (CLR/CoreCLR)
      ↓
ThreadPool
      ↓
Thread executes request
      ↓
Response returned

An App Pool can have one or multiple worker processes. Multiple worker processes are called a Web Garden, but it’s rarely used because it breaks session, cache, and increases memory usage. In the normal model, a request flows from IIS to the App Pool, then to a single worker process (w3wp.exe), and inside that process a ThreadPool thread executes the request. Async operations release the thread while waiting, improving scalability.

IIS does not have a hard limit on the number of Application Pools.
You can create hundreds or even thousands, depending on server resources.

In Web Garden / Web Farm discussions, “Server” means the machine (Windows Server OS).
Not IIS.
Not the App Pool.
Not the website.
Server = the physical or virtual machine running Windows Server OS.
Examples:
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- Azure VM running Windows Server
- On‑prem VM running Windows Server
IIS is just software installed on that server.

Windows Server (the machine)
   └── IIS (the web server software)
         └── Application Pools
               └── Worker Processes (w3wp.exe)

Web Garden — multiple worker processes on ONE Windows Server
Windows Server (single machine)
   └── IIS
         └── App Pool
               ├── w3wp.exe (1)
               ├── w3wp.exe (2)
               └── w3wp.exe (3)


- One machine
- One IIS
- One App Pool
- Multiple worker processes

🌾 Web Farm — multiple Windows Servers, each running IIS
Load Balancer
   ├── Windows Server 1
   │      └── IIS → App Pool → w3wp.exe
   ├── Windows Server 2
   │      └── IIS → App Pool → w3wp.exe
   └── Windows Server 3
          └── IIS → App Pool → w3wp.exe

- Multiple machines
- Each machine has IIS installed
- Each IIS has its own App Pool
- Each App Pool has its own worker process

🎯 Interview‑ready one‑liner
In Web Garden, multiple worker processes run on the same Windows Server.
In Web Farm, multiple Windows Servers each run IIS hosting the same app behind a load balancer.


 Why this distinction matters
Because:
- Web Garden = scale UP (use more CPU cores on one machine)
- Web Farm = scale OUT (add more machines for load + redundancy)
And in real enterprise production, Web Farms are the standard, not Web Gardens.

Web Gardens are useful only when your app is stateless, CPU‑bound, and can safely run multiple isolated worker processes on the same server. Otherwise, they cause more problems than they solve.

w3wp.exe is installed once, but IIS launches multiple instances — one per App Pool.
Each instance loads its own .NET runtime version, so diw3wp.exe is installed once, but IIS launches multiple instances — one per App Pool.
Each instance loads its own .NET runtime version, so different apps can run different .NET versions simultaneously.