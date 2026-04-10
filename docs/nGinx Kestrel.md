Nginx is a high‑performance, cross‑platform web server and reverse proxy that uses an event‑driven, asynchronous, non‑blocking architecture where a small number of worker processes, each running a single-threaded event loop, can efficiently handle tens of thousands of concurrent HTTP connections, making it ideal for modern high‑concurrency workloads such as APIs, microservices, and Kubernetes ingress. It is primarily used as a reverse proxy, load balancer, SSL/TLS terminator, static file server, and edge gateway, sitting in front of backend application servers like Kestrel (.NET), Node.js, Python (Gunicorn/Uvicorn), or Java to provide routing, caching, compression, security filtering, and connection management. Unlike IIS, which is a Windows‑only, thread‑pool‑based application server designed mainly to host ASP.NET Framework apps and relies on one thread per request (unless async APIs are used), Nginx does not tie each request to a thread and instead uses non‑blocking I/O with OS‑level event mechanisms like epoll/kqueue, giving it far superior scalability and lower memory usage under heavy load. Nginx is lightweight, fast to reload, cloud‑native, and widely used in containerized environments, while IIS is heavier, deeply integrated with Windows, and optimized for enterprise authentication, application pools, and .NET hosting rather than high‑concurrency reverse proxy workloads.

Kestrel is the built‑in, cross‑platform, lightweight web server for ASP.NET Core applications. It is the actual HTTP server that processes incoming HTTP requests inside a .NET Core application. Kestrel is optimized for speed, async I/O, and cross‑platform hosting, and it runs inside your application process (dotnet.exe). It is not a full reverse proxy or edge server — it is an application server, meaning it is designed to execute your .NET code, not to handle SSL termination, routing, load balancing, or high‑concurrency edge traffic. In production, Kestrel typically sits behind a reverse proxy like Nginx, IIS, Apache, or Azure Front Door, which handles the front‑door responsibilities while Kestrel focuses on executing your ASP.NET Core logic.

Before .NET Core, ASP.NET apps required IIS.
Kestrel was created to make .NET:
- Cross‑platform
- Cloud‑native
- Container‑friendly
- Lightweight and fast
It is now the default web server for all ASP.NET Core apps.

Kestrel is the built‑in, cross‑platform, lightweight HTTP server used by ASP.NET Core applications, responsible for parsing HTTP requests, executing middleware, and running your .NET code inside the application process using async I/O and the .NET ThreadPool. Unlike Nginx, which is an event‑driven, high‑performance reverse proxy optimized for massive concurrency, SSL termination, routing, and load balancing, Kestrel is not designed to be an edge server and should not directly face the public internet in production. And unlike IIS, which is a Windows‑only, thread‑pool‑based enterprise web server capable of hosting ASP.NET Framework apps and acting as a reverse proxy, Kestrel is a minimal, fast, cloud‑native application server intended to sit behind a reverse proxy such as Nginx, IIS, Apache, or Azure Front Door. In modern architectures, Nginx or IIS handles the front‑door responsibilities (security, routing, certificates, load balancing), while Kestrel focuses purely on executing the ASP.NET Core application logic efficiently.

Your old assumption (1 web server = enough) was correct… for the old .NET world
Before .NET Core, the world looked like this:
Client → IIS → ASP.NET Framework App


- IIS was the only web server
- IIS hosted the runtime, pipeline, request handling, security, static files, everything
- You could deploy and be done
One web server was enough.

⭐ .NET Core changed everything
When Microsoft created .NET Core, they wanted:
- Cross‑platform
- Linux support
- Docker support
- Cloud‑native hosting
- No dependency on Windows
IIS is Windows‑only.
So Microsoft built Kestrel — a lightweight, cross‑platform web server.
Now the architecture became:
Client → Reverse Proxy (IIS/Nginx/Apache) → Kestrel → ASP.NET Core App


This is why you now see two servers.

⭐ Why two servers? Because they do DIFFERENT jobs
🟦 1. Kestrel = Application Server
Kestrel’s job is to:
- Run your ASP.NET Core code
- Execute middleware
- Handle routing
- Process HTTP requests
- Use async I/O
- Be fast and lightweight
But Kestrel is not designed to:
- Terminate SSL
- Load balance
- Handle millions of connections
- Protect against DDoS
- Serve static files efficiently
- Host multiple sites on the same port
- Do URL rewriting, caching, compression, etc.
So Kestrel cannot be the front‑door server.

🟥 2. IIS or Nginx = Front‑Door Reverse Proxy
Their job is to:
- Terminate SSL
- Handle certificates
- Do URL rewriting
- Load balance
- Protect the app
- Serve static files
- Manage connections
- Host multiple sites on port 80/443
- Provide enterprise features
They are edge servers, not application servers.

⭐ So why do we need both?
Because:
- Kestrel is excellent at running .NET code
- IIS/Nginx are excellent at handling the internet
They complement each other.

⭐ The modern architecture is NOT two web servers doing the same job
It is:
Front‑door server (IIS/Nginx)
→ handles the internet, security, routing, certificates
Application server (Kestrel)
→ runs your .NET Core code
They are not duplicates.
They are two layers with different responsibilities.

⭐ One‑Line Summary
IIS used to be enough because it hosted everything.
In .NET Core, Kestrel runs your app, and IIS/Nginx protect it — so you need both.

In modern ASP.NET Core architecture, Kestrel is the lightweight, cross‑platform application server built into .NET Core that runs inside the application process and is responsible for parsing HTTP requests, executing middleware, and running your .NET code using async I/O, but it is not designed to face the public internet because it lacks critical edge‑server capabilities such as SSL termination, URL rewriting, caching, compression, load balancing, multi‑site hosting on ports 80/443, DDoS protection, and advanced connection management. To handle these front‑door responsibilities, a reverse proxy such as Nginx or IIS is placed in front of Kestrel; Nginx is an event‑driven, asynchronous, non‑blocking reverse proxy optimized for massive concurrency, high‑performance routing, SSL offloading, and cloud‑native environments like containers and Kubernetes, while IIS is a Windows‑only, thread‑pool‑based enterprise web server designed primarily to host ASP.NET Framework apps but also capable of acting as a reverse proxy for ASP.NET Core. In production, the reverse proxy (Nginx or IIS) becomes the internet‑facing gateway that manages certificates, security, routing, and connection handling, while Kestrel focuses purely on executing application logic efficiently, resulting in a layered architecture where Nginx or IIS serves as the hardened edge server and Kestrel serves as the fast, lightweight application engine behind it.
