REST API Examples (GET, POST, PUT, DELETE)
Resource: Customer
REST = resource‑based, so the URL uses nouns, not verbs.

✅ 1. GET — Retrieve a customer
[ApiController]
[Route("customers")]
public class CustomersController : ControllerBase
{
    [HttpGet("{id}")]
    public IActionResult GetCustomer(int id)
    {
        return Ok(new { Id = id, Name = "Raj" });
    }
}

URL: GET /customers/5


✅ 2. POST — Create a new customer
[HttpPost]
public IActionResult CreateCustomer([FromBody] Customer customer)
{
    // save logic
    return CreatedAtAction(nameof(GetCustomer), new { id = customer.Id }, customer);
}


URL: POST /customers

Json:
{
  "id": 5,
  "name": "Raj"
}

3. PUT — Update an existing customer
[HttpPut("{id}")]
public IActionResult UpdateCustomer(int id, [FromBody] Customer customer)
{
    // update logic
    return Ok(customer);
}


URL:
PUT /customers/5

4. DELETE — Delete a customer
[HttpDelete("{id}")]
public IActionResult DeleteCustomer(int id)
{
    // delete logic
    return NoContent();
}

DELETE /customers/5

Full Controller (All 4 REST verbs together)

[ApiController]
[Route("customers")]
public class CustomersController : ControllerBase
{
    [HttpGet("{id}")]
    public IActionResult GetCustomer(int id)
        => Ok(new { Id = id, Name = "Raj" });

    [HttpPost]
    public IActionResult CreateCustomer([FromBody] Customer customer)
        => CreatedAtAction(nameof(GetCustomer), new { id = customer.Id }, customer);

    [HttpPut("{id}")]
    public IActionResult UpdateCustomer(int id, [FromBody] Customer customer)
        => Ok(customer);

    [HttpDelete("{id}")]
    public IActionResult DeleteCustomer(int id)
        => NoContent();
}

======================================================================================================

What is RPC (Remote Procedure Call)?
RPC is an API style where:
• 	The URL represents the operation name
• 	The client is calling a function on the server
• 	The API is method‑based, not resource‑based
• 	The server exposes operations, not REST resources
RPC is used in:
• 	WCF (classic RPC/SOAP)
• 	SOAP
• 	gRPC
• 	XML‑RPC
- Web API (if you design URLs as method names)

⭐ The key rule of RPC
✔ The URL must represent the operation name
✔ The C# method name may or may not match
✔ RPC is defined by the URL, not the C# method name
This is the part you wanted clarified.

⭐ RPC Examples in C# (Mixed: Some matching, some not)
Below is a single controller showing:
- Some RPC URLs match the method name
- Some RPC URLs do NOT match the method name
This makes the concept crystal clear.

⭐ Full RPC Controller (Mixed Examples)
[ApiController]
public class CustomerRpcController : ControllerBase
{
    // 1️⃣ URL matches method name (RPC)
    [HttpGet("GetCustomerDetails")]
    public IActionResult GetCustomerDetails(int id)
    {
        return Ok(new { Id = id, Name = "Raj" });
    }

    // 2️⃣ URL does NOT match method name (still RPC)
    [HttpPost("CreateCustomer")]
    public IActionResult AddNewCustomer([FromBody] Customer customer)
    {
        return Ok("Customer created");
    }

    // 3️⃣ URL matches method name (RPC)
    [HttpPut("UpdateCustomerDetails")]
    public IActionResult UpdateCustomerDetails([FromBody] Customer customer)
    {
        return Ok("Customer updated");
    }

    // 4️⃣ URL does NOT match method name (still RPC)
    [HttpDelete("DeleteCustomer")]
    public IActionResult RemoveCustomer(int id)
    {
        return Ok("Customer deleted");
    }
}



⭐ Why all 4 are RPC
✔ Because the URL is the operation name
- /GetCustomerDetails
- /CreateCustomer
- /UpdateCustomerDetails
- /DeleteCustomer
✔ The C# method name does NOT matter
- Some match
- Some don’t
- RPC is still RPC
✔ The client is calling a function, not a resource
This is the defining characteristic.

✔ All are RPC
✔ Because the URL is the operation name
✔ Method name matching is optional

⭐ Ultra‑simple memory trick
- REST = nouns
/customers/5
- RPC = operation names
/GetCustomerDetails
- Custom Action = verbs (actions)
/billing/recalculate

===================================================================================================

Custom Action Examples (URL = business action)
✔ URL is a business verb phrase
✔ URL is lowercase, hyphenated
✔ URL does NOT look like a C# method
✔ Client is triggering a business operation

[ApiController]
public class BillingController : ControllerBase
{
    // Matches method name (still Custom Action)
    [HttpPost("billing/recalculate")]
    public IActionResult Recalculate() => Ok(...);

    // Does NOT match method name (still Custom Action)
    [HttpPost("billing/run-end-of-day")]
    public IActionResult RunEndOfDayProcess() => Ok(...);

    // Matches method name (still Custom Action)
    [HttpPost("billing/apply-discount")]
    public IActionResult ApplyDiscount() => Ok(...);

    // Does NOT match method name (still Custom Action)
    [HttpPost("billing/retry-failed-payments")]
    public IActionResult RetryFailedPayments() => Ok(...);
}

All 4 are Custom Action because:
- URLs are business actions, not method names
- URLs use kebab-case
- URLs do NOT look like C# method names
- URLs represent operations, not functions

The FINAL, PERFECT CLASSIFICATION RULE
🔵 RPC
- URL looks like a method name
- URL is PascalCase
- URL is a function
- URL = “call this method”
- Example: /GetCustomerDetails
🟢 Custom Action
- URL looks like a business action
- URL is lowercase/kebab-case
- URL is a verb phrase
- URL = “perform this operation”
- Example: /billing/recalculate

⭐ The simplest way to remember
RPC = technical method
Custom Action = business action

===================================================================

 everything we’ve been discussing so far is about the different styles of calling web services.
And you’ve now mastered the three big ones:
⭐ 1. REST
- Resource‑based
- URLs are nouns
- Uses HTTP verbs meaningfully
- Example: /customers/5
⭐ 2. RPC
- Method‑based
- URLs are function names
- Client is literally calling a method
- Example: /GetCustomerDetails
⭐ 3. Custom Action
- Action‑based
- URLs are business verbs
- Not tied to method names
- Example: /billing/recalculate
These three are different API styles, not different technologies.

Why this matters
Because Web API can implement all three styles:
- It can behave like REST
- It can behave like RPC
- It can behave like Custom Action
Web API is just a framework — the style depends on how YOU design the URLs.

⭐ The big picture (the one‑liner)
REST = nouns
RPC = method names
Custom Action = business verbs

That’s the whole universe of Web Service calling styles.


These are 3 different styles, where Microservies is not a style, it is an architecture.
Microservices do NOT define:
- Whether you use REST
- Whether you use RPC
- Whether you use Custom Actions

A microservice can expose:
- REST endpoints
- RPC endpoints
- Custom Action endpoints
- Or a mix of all three
Microservices do not force any particular API style.

Microservices = how you structure your system.
REST/RPC/Custom Action = how you design your endpoints.
