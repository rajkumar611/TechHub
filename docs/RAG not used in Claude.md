=====================================================
        CLAUDE vs ChatGPT - KEY CONCEPTS
=====================================================


1. WHAT IS A CONTEXT WINDOW ?
-----------------------------------------------------
  A temporary, in-memory space that holds everything
  in your current conversation.

  It includes :
    - Your uploaded documents
    - Your questions
    - Claude's previous answers
    - System instructions

  Think of it like a DESK WORKSPACE :
    - Everything on the desk is instantly readable
    - Once you leave (session ends), desk is cleared
    - Nothing is saved permanently


2. CLAUDE - NO EMBEDDING API
-----------------------------------------------------
  Anthropic does NOT provide an Embedding API.

  Why Claude doesn't need RAG for doc uploads :

    You upload a document
           |
    Entire document loaded into Context Window
           |
    Your question + full document sent to Claude
           |
    Claude reads and answers directly

  No Chunking
  No Embedding
  No Vector DB
  No Retriever

  Reason : Claude has a HUGE context window
             Claude  --> 200,000 tokens (~150K words)
             GPT-4   --> 128,000 tokens (smaller)


3. ChatGPT and MS Copilot - USES RAG
-----------------------------------------------------
  Both use RAG internally when you upload a document.

  You upload a document
         |
  Document is split into Chunks
         |
  Chunks converted to Vectors
  using OpenAI Embedding API       <-- ChatGPT
  using Azure OpenAI Embedding API <-- MS Copilot
         |
  Vectors stored in temporary Vector DB
         |
  You ask a question
         |
  Question converted to Vector
         |
  Similarity Search in Vector DB
         |
  Relevant Chunks retrieved
         |
  Chunks + Question sent to GPT-4
         |
  Response to User

  Reason : Smaller context window,
           cannot fit entire document at once.


4. QUICK COMPARISON
-----------------------------------------------------

  Feature              Claude        ChatGPT / Copilot
  -----------------    ----------    -----------------
  Embedding API        Not available OpenAI Embedding
  Context Window       200K tokens   128K tokens
  Doc Upload approach  Full doc in   RAG internally
                       context window
  Chunking needed      No            Yes
  Vector DB needed     No            Yes (temporary)
  Session persistent   No            No


5. BOTTOM LINE
-----------------------------------------------------
  Claude   --> Large context window
           --> No RAG needed for doc uploads
           --> No Embedding API available

  ChatGPT  --> Smaller context window
  Copilot  --> RAG used internally
           --> OpenAI Embedding API used
           --> Chunks + Vectors + Retriever

  For PRODUCTION apps (many docs, many users)
  --> Always use RAG regardless of which LLM
  --> Context window is temporary, not scalable

=====================================================