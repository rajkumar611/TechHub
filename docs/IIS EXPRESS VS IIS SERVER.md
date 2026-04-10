IIS EXPRESS VS IIS SERVER

QUICK COMPARISON:
=================

IIS Express:
- Process: iisexpress.exe
- Purpose: Local development
- Runs on: Your machine (localhost)
- Port: localhost:5000
- User: Your Windows account
- Features: Basic HTTP hosting
- Debugging: Full support (breakpoints, inspect variables)
- Performance: Adequate for testing
- Lifespan: Runs while you're debugging (F5), stops when you stop

IIS Server:
- Process: w3wp.exe
- Purpose: Production web server
- Runs on: Windows Server in production
- Port: 0.0.0.0:80, 443 (public)
- User: Service account (IIS AppPool\DefaultAppPool or NETWORK SERVICE)
- Features: Full enterprise features (load balancing, SSL, app pools, recycling)
- Debugging: No debugger attach
- Performance: Optimized for production load
- Lifespan: Runs continuously, restarts on app pool recycle schedule

---

PROCESS DETAILS:

IIS EXPRESS - iisexpress.exe
----------------------------

When you run an ASP.NET Core app from Visual Studio:
1. You press F5
2. Visual Studio builds your project
3. Visual Studio launches iisexpress.exe
4. iisexpress listens on localhost:5000 (or random port)
5. Your browser opens http://localhost:5000
6. You can test locally
7. You hit a breakpoint, inspect variables
8. You stop debugging, iisexpress.exe closes

Task Manager view:
- Name: iisexpress.exe
- PID: varies (e.g., 2468)
- User: Raj (your Windows user)
- Memory: ~85 MB
- CPU: 2%


IIS SERVER - w3wp.exe
---------------------

When you deploy to Windows Server with IIS:
1. Code is deployed to C:\inetpub\sites\appname
2. IIS Application Pool is created (e.g., DefaultAppPool)
3. w3wp.exe process starts (managed by IIS)
4. w3wp.exe listens on 0.0.0.0:80 and 0.0.0.0:443
5. User makes HTTPS request to https://qbe-claims.com
6. Request hits IIS Server
7. IIS routes to appropriate application pool
8. w3wp.exe process handles request
9. Your C# code executes
10. Response sent to user
11. w3wp.exe logs request to IIS logs
12. w3wp.exe remains running for next request

Task Manager view (multiple instances):
- Name: w3wp.exe
- PID: 4521, 4522, 4523 (multiple for load balancing)
- User: IIS AppPool\DefaultAppPool (service account)
- Memory: ~245 MB each
- CPU: 4-6% each

---

KEY DIFFERENCES:

Startup:
- IIS Express: Starts fresh each time you press F5 (slower first load)
- IIS Server: Already running, assemblies cached in memory (fast)

Errors:
- IIS Express: Show full stack trace in browser (helpful for debugging)
- IIS Server: Show generic error page (don't expose details to users), log to Event Viewer

Configuration:
- IIS Express: Simple .config file
- IIS Server: IIS Manager GUI with complex settings (app pool identity, recycling schedule, SSL certs, etc.)

Users:
- IIS Express: Single user (you)
- IIS Server: Multiple concurrent users (production traffic)

Debugging:
- IIS Express: Attach debugger, set breakpoints, inspect variables
- IIS Server: Cannot debug (production environment)

App Pool Recycling:
- IIS Express: No recycling (simple)
- IIS Server: Scheduled recycling every 24 hours (clears memory, resets state)

---

PRODUCTION SCENARIO (QBE INSURANCE):

Windows Server 2019 (Production)

IIS Manager shows:
- Application Pool: QBEInsurance.AppPool
  - .NET Runtime: v4.0
  - Pipeline: Integrated
  - Identity: QBE\svc-iis (service account)
  - Recycling: Every 24 hours at 2 AM
  - Max Worker Processes: 1 (or 2+ for load balancing)

- Site: qbe-claims.com
  - Bindings: https://qbe-claims.com (port 443), http://qbe-claims.com (port 80)
  - Physical Path: C:\inetpub\sites\qbe-claims
  - Application Pool: QBEInsurance.AppPool
  - SSL Certificate: GlobalSign

When user navigates to https://qbe-claims.com:
1. Browser makes HTTPS request (port 443)
2. IIS validates SSL certificate
3. IIS routes to QBEInsurance.AppPool
4. w3wp.exe process (already running, no startup delay)
5. Your C# code executes
6. Query database
7. Return response to user
8. IIS logs request
9. w3wp.exe remains running for next user request

w3wp.exe keeps running:
- Handles next request immediately (no startup delay)
- Uses cached assemblies in memory (fast)
- Maintains connection pool to database (efficient)

---

DEVELOPMENT SCENARIO (YOUR MACHINE):

Visual Studio 2022 on your laptop

Step 1: Press F5
Step 2: Visual Studio compiles project
Step 3: Visual Studio launches iisexpress.exe localhost:5000
Step 4: Browser opens http://localhost:5000
Step 5: You test the app
Step 6: You hit a breakpoint in code
Step 7: Visual Studio pauses execution
Step 8: You inspect variables, call stack, etc.
Step 9: You fix the bug, edit code
Step 10: You press F5 again to restart
Step 11: iisexpress.exe restarts with new code
Step 12: You test again
Step 13: When done, stop debugging
Step 14: iisexpress.exe closes
Step 15: localhost:5000 no longer available

This cycle is fast for development because:
- iisexpress is lightweight
- No complex configuration
- Full debugging support
- You can restart instantly

---

YOUR QBE EXPERIENCE:

Development:
- Open Visual Studio
- Press F5
- iisexpress.exe starts on localhost:5000
- Test locally with full debugging
- Stop debugging, iisexpress closes

Production:
- Code deployed to Windows Server
- IIS Server running with w3wp.exe
- Application Pool: QBEInsurance.AppPool
- w3wp.exe handles real user traffic 24/7
- No breakpoints, no debugging
- Logs go to Event Viewer or Application Insights
- If crash, restart app pool or server

---

FOR ACCENTURE INTERVIEW:

"At QBE, I used IIS Express locally with Visual Studio for development—quick feedback loops, full debugging support. For production deployments, we used IIS Server with w3wp.exe processes in application pools, handling real user traffic with enterprise features like app pool recycling, load balancing, and SSL certificates. For Accenture projects with Azure, we'd deploy to Azure App Service, which is essentially managed IIS—same concepts, but Microsoft handles the infrastructure."

---

SUMMARY TABLE (ASCII):

Aspect              | IIS Express      | IIS Server
====================|==================|====================
Process Name        | iisexpress.exe   | w3wp.exe
Purpose             | Development      | Production
Runs on             | Your machine     | Windows Server
Port                | localhost:5000   | 0.0.0.0:80, 443
User                | Your account     | Service account
Debugging           | Yes              | No
Performance         | Adequate         | Optimized
Lifespan            | While debugging  | Continuous
Memory              | ~85 MB           | ~245 MB+
Instances           | 1                | Multiple
Configuration       | Simple .config   | IIS Manager GUI
Error Display       | Full stack trace | Generic page
Logging             | Console/Debug    | Event Viewer
State Management    | Simple           | Complex (pools)

---

END