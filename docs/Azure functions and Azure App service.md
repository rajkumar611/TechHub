Azure functions:
Developer writes locally → Compiles → Publishes to Azure
                                            ↓
                                   Azure picks runtime
                                            ↓
                                   Waits for trigger
                                            ↓
                    Trigger fires (from main app or event) → Function executes
Why it's "Serverless": You don't manage servers, scaling, or maintenance. Azure does everything. You just write small, focused functions for specific tasks. Perfect for backend operations, integrations, and event-driven work.

Main app can be written in 1 language, the Azure functions can be written in other language.

I thought Azure functions will always be called by our main app, then what is that event which can also call Azure functions ?
Type 1: Called by Your Main App (Direct)
Your main application explicitly calls the Azure Function via HTTP:
Main App → "Hey Azure Function, process this!" → Function executes
Type 2: Triggered by Events (Automatic)
Events in Azure itself trigger the function without your main app doing anything:
Examples:

File uploaded → Blob Storage automatically triggers the function (no main app involved)
Timer fires → Midnight hits, function runs automatically (no main app involved)
Message in queue → Message arrives, function processes it (no main app involved)

Real scenario:
Customer uploads invoice to Azure Storage
                    ↓
        (No one called the function explicitly)
                    ↓
        Azure Storage event → Automatically triggers function
                    ↓
        Function extracts text from invoice
Your main app doesn't need to know or care. The function just responds to events happening within Azure infrastructure.
So Azure Functions are useful when:

Your main app needs to call small operations (HTTP trigger)
You need background tasks that happen automatically (Timer, Blob, Queue triggers)

That's what makes them powerful — they can work independently of your main app, reacting to Azure events automatically.

Azure app service:
Azure App Service is a fully managed platform to host and run web applications, APIs, and mobile backends in the cloud. Unlike Azure Functions, it runs continuously 24/7 (not on-demand). Azure handles the server, operating system, runtime, security patches, and scaling — you just deploy your code. You pay a fixed hourly rate based on the tier you choose, regardless of usage.