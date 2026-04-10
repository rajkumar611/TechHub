LLM + Tool = AI Agent
Types of Agent:
1. Simple Reflex Agent Ex: Sensor based upon entry, lights switch off/on
2. Model based Reflex Agent which has its own memory, like Cleaning robot, Alexa, Siri
3. Goal based Agent, like Drone delivery, Google map based destination
4. Utility based Agent - thinks about various alternatives and gives the best, like self driving cars
5. Learning agent - Keeps learning continuously

9:47 AM

Validated framework and connected agent taxonomy to interview preparation
Validated framework and connected agent taxonomy to interview preparation
Excellent framework. This is the classic AI agent taxonomy, and it directly maps to what you need to understand for your Build Lead interview.

Mapping to your Claude Code + SDLC context:
Agent Type	Example in SDLC	Claude Code Role
Simple Reflex	Linter that auto-formats code	Basic tool (not really an agent)
Model-based Reflex	Unit test generator with code context	Claude Code with conversation memory
Goal-based	"Build a REST API for user authentication"	Claude Code with explicit objectives & planning
Utility-based	Refactor code choosing between multiple patterns	Claude Code comparing alternatives (Extended Thinking)
Learning Agent	System that improves test coverage over iterations	Multi-agent system that learns from failures
Key insight for Build Lead:
Most enterprise SDLC workflows need Goal-based + Utility-based agents orchestrated together:

Goal agent: "Generate microservice for order processing"
Utility agent: "Review 3 architectural patterns and choose best"
Reflex agent: "Run security scan and flag vulnerabilities"
Learning agent: "Improve deployment time based on past pipeline metrics"
Connection to Bala's advice (critical for interview):
When he said "Agentic AI workflow" + "Governance & Guardrails", he's asking you to think about:

Which agent type should handle each phase of SDLC? (code gen → testing → deployment → monitoring)
What guardrails prevent each type from breaking? (Learning agents can drift if unsupervised; Utility agents need cost controls)
Human checkpoints – Which agent types need human approval before proceeding?
Your interview angle:
Frame your Claude Code multi-agent demo around this taxonomy:

Show Claude as a Goal-based agent planning the solution
Show it as Utility-based comparing architectural options
Show governance checkpoints (humans approve before applying changes)
Discuss how a Learning agent layer could improve iteration cycles
This demonstrates you understand both the technical orchestration and the governance layer—exactly what a Build Lead needs.