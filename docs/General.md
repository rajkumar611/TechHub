Go is a fast, simple, compiled language created by Google, designed for building scalable, concurrent systems using lightweight goroutines.

Go does have a runtime, but unlike JVM or CLR, it is small, lightweight, and compiled directly into the final binary. You don’t install it separately — it ships with your program.

======================================================================================

Graph API is a Microsoft enterprise standard — when clients ask "how do we integrate Office 365 with our custom system?" the answer is usually "Graph API".
Graph API = the single gateway to the entire Microsoft 365 ecosystem.

======================================================================================

OAuth is a process / protocol. OAuth issues tokens. Very often, the token issued is a JWT
OAuth is the process for granting access; JWT is a common token format used as the access token produced by OAuth.
OAuth can issue different tokens formats, JWT is the most common, but OAuth can issue opaque tokens (random strings), some systems don't let clients
inspect the token contents

======================================================================================

MERN stack
Mongodb - For database which uses JavaScript syntax in the shell to interact with db. The documents are stored in Json format
Express JS - Framework used to build API using Javascript
React JS - Library used to build frontend
Node JS - runtime used to execute javascript in server

The MERN stack is a full‑stack JavaScript framework consisting of MongoDB for the database, Express.js for building backend APIs, React.js for building the frontend UI, and Node.js as the server runtime. MongoDB stores data in JSON‑like documents and provides a JavaScript‑style shell, Express builds APIs using JavaScript, React builds the UI, and Node executes JavaScript on the server.

========================================================================================

Django is NOT an ORM. Django is a web framework.
Django includes an ORM called Django ORM (the database layer built into Django).
The Correct Analogy:
C# / .NETPythonWeb FrameworkASP.NET CoreDjangoORMEntity Framework (EF)Django ORM
So:

Entity Framework (ORM) = Django ORM (ORM)
ASP.NET Core (web framework) includes Entity Framework (optional)
Django (web framework) includes Django ORM (built-in, always available)

Key Difference:
ASP.NET Core + Entity Framework:
You can use ASP.NET Core WITHOUT Entity Framework.
You can use Entity Framework in console apps, APIs, anywhere in .NET.
Django + Django ORM:
Django comes with its ORM built-in.
Django ORM is tightly integrated into Django.
You can technically use other ORMs with Django (SQLAlchemy, etc.), but Django ORM is the standard.
Simple Answer:

Entity Framework = ORM for C#/.NET
Django ORM = ORM for Python (built into Django framework)
Django = Web framework that includes an ORM

If someone says "Django for Python like EF for C#," they're referring to Django ORM, not Django itself.

Entity Framework is NOT built into .NET or .NET Core like Django ORM is built into Django.

========================================================================================
