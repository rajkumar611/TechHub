==================================================================
          SLM vs LLM — How Models Are Classified
==================================================================

PRIMARY BASIS: NUMBER OF PARAMETERS
------------------------------------------------------------------
Parameters = internal weights learned during training
More parameters = more knowledge = bigger model
No official cutoff — industry uses these ranges loosely!
------------------------------------------------------------------

SIZE CLASSIFICATION

  SLM  (Small)     Under 7B     Phi-3 Mini, Gemma 2B, LLaMA 1B
  Medium (grey)    7B - 30B     Mistral 7B, LLaMA 3 8B
  LLM  (Large)     30B - 100B   LLaMA 3 70B, Mixtral 8x7B
  Frontier         100B+        GPT-4, Claude 3, Gemini Ultra


==================================================================
OTHER FACTORS THAT MATTER
==================================================================

1. HARDWARE REQUIREMENT
------------------------------------------------------------------
  Factor                   SLM              LLM
  ......................   ..............   ..............
  Runs on laptop           YES              Usually NO
  Needs GPU                Optional         Required
  RAM needed               4 - 8 GB         40 - 80+ GB


2. WHERE IT RUNS
------------------------------------------------------------------
  Factor                   SLM              LLM
  ......................   ..............   ..............
  Runs locally (Ollama)    YES              Rarely
  Needs cloud              Optional         Usually YES
  Edge devices / phone     Some             NO


3. CAPABILITY
------------------------------------------------------------------
  Factor                   SLM              LLM
  ......................   ..............   ..............
  General knowledge        Limited          Broad
  Complex reasoning        Basic            Strong
  Multi-language           Limited          Strong
  Coding                   Basic            Advanced
  Specific tasks           Excellent        Excellent


==================================================================
WHY THE LINE IS BLURRY
==================================================================

  A 7B model TODAY can outperform a 70B model from 2 years ago
  because training data and architecture keep improving.

  Phi-3 Mini (3.8B)  ->  SLM that beats many older LLMs
  Mistral 7B         ->  Boundary case, called both SLM and LLM
  Gemma 2B           ->  Runs on a phone, surprisingly capable


==================================================================
SIMPLE ANALOGY
==================================================================

  SLM  ->  Smart junior employee
           Fast, efficient, great at specific tasks
           Works on a laptop

  LLM  ->  Senior expert with a vast library
           Knows everything broadly
           Needs a big office (data center or cloud)


==================================================================
KEY TAKEAWAY
==================================================================

  SLM   Fewer params under 7B
        Runs locally, fast, cheap, task specific

  LLM   Many params 30B and above
        Needs cloud or GPU, powerful, general purpose

  Classification is a rough industry convention
  based on parameter count and where it can run
  It is NOT an official standard!

==================================================================