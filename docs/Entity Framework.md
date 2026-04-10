Entity Framework (EF) is Microsoft’s Object–Relational Mapper (ORM) for .NET that allows developers to work with databases using C# classes and objects instead of manually writing SQL for most operations. It is called “Entity Framework” because it manages entities—C# classes that represent database tables—and provides a full framework of tools for querying, mapping, tracking changes, handling relationships, and managing schema migrations. EF’s core purpose is to let you interact with the database at a higher abstraction level: you write LINQ queries or manipulate C# objects, and EF automatically generates the required SQL behind the scenes, executes it, and maps the results back into objects. Although LINQ is the most common way to query data, EF does not depend on LINQ; it can also execute raw SQL queries, stored procedures, or direct SQL commands when you want full control. EF generates SQL only when you don’t write SQL yourself—for example, when you use LINQ, call SaveChanges(), insert, update, delete, or load relationships—otherwise it simply executes the SQL you provide. EF’s advantages include faster development, strongly typed queries, IntelliSense support, automatic change tracking, cross‑database support (SQL Server, PostgreSQL, MySQL, SQLite, Cosmos DB), clean domain models, and reduced boilerplate SQL. While EF is Microsoft’s ORM, there are several non‑Microsoft ORMs such as Dapper (micro‑ORM focused on performance and manual SQL), NHibernate (powerful, mature ORM), LLBLGen Pro, ServiceStack OrmLite, and Linq2Db. Together, these concepts make EF a flexible ORM that supports both high‑level LINQ‑based querying and low‑level SQL execution, while seamlessly mapping between relational tables and C# objects.

1. EF Core Sample — Basic CRUD with LINQ
This example shows:
- DbContext
- Entity class
- LINQ queries
- Insert, Update, Delete
- EF generating SQL behind the scenes
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public class AppDbContext : DbContext
{
    public DbSet<Customer> Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options.UseSqlite("Data Source=app.db");
    }
}

class Program
{
    static void Main()
    {
        using var db = new AppDbContext();
        db.Database.EnsureCreated();

        // INSERT
        db.Customers.Add(new Customer { Name = "Raj" });
        db.SaveChanges();

        // READ (LINQ)
        var customers = db.Customers.ToList();
        Console.WriteLine("Customers:");
        customers.ForEach(c => Console.WriteLine(c.Name));

        // UPDATE
        var first = db.Customers.First();
        first.Name = "Raj Updated";
        db.SaveChanges();

        // DELETE
        db.Customers.Remove(first);
        db.SaveChanges();
    }
}



🟩 2. EF Core Sample — Using Raw SQL (No LINQ)
This example shows:
- EF executing your SQL
- EF mapping results to C# objects
- No LINQ involved
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public class AppDbContext : DbContext
{
    public DbSet<Customer> Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options.UseSqlite("Data Source=app.db");
    }
}

class Program
{
    static void Main()
    {
        using var db = new AppDbContext();

        // RAW SQL SELECT
        var list = db.Customers
            .FromSqlRaw("SELECT * FROM Customers WHERE Name LIKE 'R%'")
            .ToList();

        foreach (var c in list)
            Console.WriteLine(c.Name);

        // RAW SQL UPDATE
        db.Database.ExecuteSqlRaw("UPDATE Customers SET Name = 'Updated via SQL'");
    }
}



🟧 3. EF Core Sample — Stored Procedure Call
var result = db.Customers
    .FromSqlRaw("EXEC GetActiveCustomers")
    .ToList();


EF maps the result to Customer objects.

🟦 4. EF Core Sample — Mapping Relationships
This shows:
- One‑to‑many relationship
- Navigation properties
- EF generating JOIN SQL
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }

    public List<Order> Orders { get; set; }
}

public class Order
{
    public int Id { get; set; }
    public string Product { get; set; }

    public int CustomerId { get; set; }
    public Customer Customer { get; set; }
}

public class AppDbContext : DbContext
{
    public DbSet<Customer> Customers { get; set; }
    public DbSet<Order> Orders { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options.UseSqlite("Data Source=app.db");
    }
}

class Program
{
    static void Main()
    {
        using var db = new AppDbContext();
        db.Database.EnsureCreated();

        var data = db.Customers
            .Include(c => c.Orders)
            .ToList();

        foreach (var c in data)
        {
            Console.WriteLine($"Customer: {c.Name}");
            foreach (var o in c.Orders)
                Console.WriteLine($"  Order: {o.Product}");
        }
    }
}



🟩 5. EF Core Sample — Change Tracking Demo
using var db = new AppDbContext();

var customer = db.Customers.First();
Console.WriteLine(db.Entry(customer).State); // Unchanged

customer.Name = "Modified Name";
Console.WriteLine(db.Entry(customer).State); // Modified

db.SaveChanges();


EF automatically detects changes.

🟧 6. EF Core Sample — Insert Without LINQ (Only Objects)
using var db = new AppDbContext();

var customer = new Customer { Name = "New Customer" };
db.Add(customer);   // EF tracks the entity
db.SaveChanges();   // EF generates INSERT SQL
