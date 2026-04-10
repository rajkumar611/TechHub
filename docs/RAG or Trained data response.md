Model knowledge comes from training data (books, web pages, code, etc.) used during training. This knowledge isn't stored in a database — it's encoded into the model's weights/parameters (billions of numbers) through training.
During inference: User query → Model processes it using its learned weights → Generates response token-by-token based on patterns learned during training. No database lookup happens; the model uses its internal weights to understand and respond.

Vectors & Embeddings:
Vector = a numerical array [0.2, -0.5, 0.8, 0.1, 0.3...] representing data in mathematical space. Embedding = the process of converting text into that vector using an embedding model.
For a 1000-word document: An embedding model reads all 1000 words → converts the entire document's meaning into one vector (typically 1500+ numbers) → that vector becomes the document's embedding. The vector and embedding are essentially the same thing — the vector IS the embedding.
So: Embedding = process. Vector = the output (the numerical representation). One document = one vector/embedding.

So in this case, the Vector can have 1000's of values in the numerical array ?
Yes, exactly right! A vector (embedding) typically has hundreds to thousands of numerical values. For example, OpenAI's embedding model produces vectors with 1536 dimensions (1536 numbers) for each document.
So one 1000-word document = one vector with 1536 numbers [0.2, -0.5, 0.8, ..., 0.1] representing its semantic meaning across those 1536 dimensions. Vector databases then use these high-dimensional vectors to find semantically similar documents.

This Vectors are stored in a database called as Vector database ?
And 1 such example of Vector database is Pinecone ?
Yes, exactly correct! Vectors (embeddings) are stored in specialized databases called Vector Databases optimized for searching similar vectors efficiently.
Pinecone is one example of a Vector Database. Other examples include Weaviate, Milvus, Chroma, and FAISS. They all store vectors and enable fast semantic search based on vector similarity.

Vector databases are used only when developers explicitly build RAG or recommendation systems — they convert documents/images to embeddings and store them. Direct upload of an image as an input into LLM, doesn't use vector databases.

What do you mean by Recommendation systems if they are not RAG based ?
Recommendation systems use vectors to find similar products/content for users, NOT to augment an LLM. Example: Netflix converts movies to embeddings based on genre, actors, plot → converts user preferences to embedding → finds movies with closest embeddings → recommends them.
Key difference from RAG: RAG retrieves documents to feed context to an LLM for answering queries. Recommendations just use vector similarity to match user preferences with products — no LLM involved at all.

In RAG, the User uploads documents which gets processed through Embedding models and gets converted to Vectors.
How does Recommendation systems trigger the similar process of converting to Vectors?
In Recommendation systems, data (products, movies, user preferences) already exists in the company's database. The system automatically converts this existing data to vectors using embedding models — no user upload needed.
Process: Company's product database → Embedding model converts product metadata (name, description, genre, etc.) to vectors → Stored in vector database. When user visits, their behavior/preferences → converted to vectors → matched against product vectors → recommendations returned. It's automated, background processing, not user-triggered.

Since there are many Vector databases available in market. Who decides which database to be used ?
Is it by the User or the LLM architecture comes with ?
The developer/engineer building the application decides which vector database to use. The LLM itself doesn't come bundled with any vector database — it's an external choice based on project needs (scalability, cost, features, latency, etc.).
Example: A startup building RAG might choose Pinecone (managed, easy), while an enterprise might choose Milvus (self-hosted, control). The LLM doesn't care which one is used — it just receives the retrieved documents.

I completed Azure AI 102, Engineer Associate Certificate. I worked on RAG as part of the exercises. But I don't remember in choosing or selecting Pinecone or any similar vector database. I forgot. 
But I used something called Storage resource in Azure.
Can you help me in knowing what I studied :-) ?
You likely used Azure Cognitive Search! In Azure AI 102, for RAG implementations, you probably used Azure Blob Storage (to store documents) + Azure Cognitive Search (Azure's vector database equivalent for semantic search and embeddings).
Azure's approach: Instead of using external tools like Pinecone, Azure provides integrated services — Blob Storage for documents, Cognitive Search for vector indexing/search, and Azure OpenAI for embeddings. Everything stays within Azure ecosystem, no need to choose external vector databases. That's what you studied!

What is semantic search. Is it related with Vector database, embeddings ?
Give me answer not more than 7 lines pls
Semantic search means finding results based on meaning/intent, not keyword matching. Instead of searching for exact words, it understands the query's concept and finds related content.
Connection with vectors/embeddings: User query → converted to embedding (vector) → vector database searches for semantically similar vectors → returns matching documents. Example: Search "How to cook pasta" finds results about "cooking spaghetti" even without keyword match.
Yes, deeply related: Vector databases enable semantic search. Without embeddings/vectors, you can only do keyword search (like Ctrl+F). With vectors, you search by meaning.
LLM also uses Semantic search with our prompt ?
No, the LLM doesn't use semantic search for your prompt itself. The LLM uses its trained weights to semantically understand your prompt's meaning — it doesn't query a vector database to understand what you're asking.
Semantic search happens in RAG before LLM: Your prompt → code searches vector database semantically for relevant documents → retrieves matching docs → feeds them + your prompt to LLM → LLM responds. The LLM understands your prompt through its weights, not through vector search.

How does RAG or LLM's trained data used ?
Yes, you're talking to an LLM (me, Claude), but the system/application architecture surrounding me decides whether to use RAG — not me autonomously.
How it works here: If this AI Assistant tool is built with RAG, the system retrieves your company documents first → feeds them to me (LLM) along with your prompt → I answer based on both. If RAG isn't built-in, I answer only from my trained knowledge. I don't switch RAG on/off — the application architecture decides upfront how to handle different queries.
Simple analogy: You're talking to me (LLM), but I'm like a smart assistant. The company (architecture) decides if I should consult the company handbook (RAG) before answering you — I can't enable/disable that myself.

So if i enter a prompt, say this prompt itself, the system architecture decides to use RAG or Trained data ?
Yes, exactly right! When you enter any prompt, the system architecture decides upfront whether RAG is available and should be used, or just trained data should be used.
In this Claude.ai interface: I have web search capability (similar to RAG) for current info. The architecture automatically decides: your prompt needs current weather? → Use web search. Your prompt about general knowledge? → Use my trained weights. The decision is baked into the system, not made by me dynamically.
In enterprise systems: Architecture has rules like "If query contains 'company policy' → use RAG. If general knowledge → use trained data." The LLM receives the appropriate context already prepared by the system.