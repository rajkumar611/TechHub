General concept (just adding in this txt file):
- Agent = software
- Machine = host
- Creating an agent = installing software

An Agent is simply a software worker installed on a machine that performs automated tasks on behalf of a larger system such as Azure, TeamCity, Azure DevOps, monitoring platforms, migration tools, or security services. It is not the machine itself, but a program running on that machine, usually as a background service, that connects to a central server, receives jobs or instructions, executes them locally, and reports results back. Depending on the platform, an agent may run CI/CD pipelines (TeamCity, Azure DevOps), collect logs and metrics (Azure Monitor Agent), map dependencies (Dependency Agent), enable hybrid connectivity (Azure Arc Agent), perform security scanning (Defender/CrowdStrike agents), or gather migration data (Azure Migrate Agent). Multiple agents can run on the same machine because each is just a separate piece of software with its own configuration, and certificates are often installed on the machine so these agents can authenticate securely to cloud services. In short, an agent is a task‑executing software component, not hardware, and it enables cloud platforms and automation systems to interact with, monitor, or control a machine.

===============================================================================================================

What is DevOps?
“DevOps is a cultural and technical approach that integrates development and operations through automation, CI/CD, and collaboration to deliver software faster and more reliably.”

What is Azure DevOps?
“Azure DevOps is Microsoft’s cloud platform offering integrated tools—Boards, Repos, Pipelines, Test Plans, and Artifacts—to implement DevOps practices across the entire software lifecycle.”

What is DevSecOps ?
DevSecOps is a methodology and cultural shift where security is integrated into every stage of the DevOps lifecycle—starting from planning, coding, building, testing, deployment, and runtime.
Yes — it extends DevOps by embedding security tools, automation, and practices directly into the pipeline so security becomes everyone’s responsibility, not a last‑minute gate.


Is there something called “Azure DevSecOps”?
Not as a product name. There is Azure DevOps, but there is no official Microsoft product called “Azure DevSecOps.”
However, you can implement DevSecOps using Azure DevOps + Azure security services + third‑party tools.
So in practice, companies do talk about “Azure DevSecOps,” but it means DevSecOps implemented on Azure, not a separate product.
DevSecOps → Azure DevSecOps (concept, not product)
- DevSecOps = methodology where security is integrated into DevOps
- Azure DevSecOps = DevSecOps implemented using Azure tools like:
- Azure DevOps Pipelines
- Azure Key Vault
- Microsoft Defender for Cloud
- GitHub Advanced Security (if using GitHub)
- Azure Policy
- Azure Container Registry - scanning
- Azure Monitor / Defender for Cloud Apps
- Third‑party tools (Snyk, SonarQube, Checkmarx, Trivy, Checkov)
So the correct answer is:
There is no product called Azure DevSecOps, but you can implement DevSecOps practices using Azure DevOps and Azure security services.

- Azure DevSecOps = DevSecOps implemented using Azure tools like:
- Azure DevOps Pipelines
- Azure Key Vault
- Microsoft Defender for Cloud
- GitHub Advanced Security (if using GitHub)
- Azure Policy
- Azure Container Registry scanning
- Azure Monitor / Defender for Cloud Apps
- Third‑party tools (Snyk, SonarQube, Checkmarx, Trivy, Checkov)
So the correct answer is:
There is no product called Azure DevSecOps, but you can implement DevSecOps practices using Azure DevOps and Azure security services.



SAST is Static Application Security Testing — it scans source code without running it to detect security vulnerabilities early in the development lifecycle. It’s a core DevSecOps practice used during coding and build stages.
Examples of SAST Tools
- SonarQube
- Checkmarx
- Fortify
- Veracode SAST
- GitHub CodeQL


DAST is Dynamic Application Security Testing — it tests a running application from the outside to find vulnerabilities like SQL injection, XSS, and authentication issues. Unlike SAST, it doesn’t need source code and runs later in the DevSecOps pipeline.
 Examples of DAST Tools
- OWASP ZAP
- Burp Suite
- Acunetix
- Netsparker
- IBM AppScan

SCA is Software Composition Analysis — it scans all open‑source libraries and dependencies in your application to detect known vulnerabilities, outdated packages, and license risks. It complements SAST and DAST by securing the third‑party code your app relies on.
No single tool can find all vulnerabilities.
So SAST, DAST, and SCA complement each other by covering different parts of the security landscape
 Examples of SCA Tools
- Snyk
- WhiteSource / Mend
- Dependabot (GitHub)
- OWASP Dependency-Check
- JFrog Xray
WhiteSource and Mend are the same company. WhiteSource rebranded to Mend in 2022 after expanding from SCA into a full application security platform including SAST, supply chain security, and automated remediation.

IaC Scanning = Security scanning of Infrastructure‑as‑Code templates (Terraform, Bicep, ARM, CloudFormation) to detect misconfigurations before deployment.
If SAST checks your code
and SCA checks your libraries,
IaC scanning checks your cloud infrastructure definitions.

🧠 Why IaC Scanning Exists
Cloud breaches often happen due to:
- Open security groups
- Publicly exposed storage accounts
- Weak IAM roles
- Unencrypted disks
- Misconfigured Kubernetes clusters
IaC scanning catches these before they reach Azure/AWS/GCP.

🛠️ What IaC Scanning Looks For
- Open ports (0.0.0.0/0)
- Missing encryption
- Missing logging
- Privileged IAM roles
- Publicly accessible resources
- Non‑compliant configurations

🔧 Common IaC Scanning Tools
- Checkov
- Terraform Sentinel
- Azure Policy
- Kics
- OPA (Open Policy Agent)

🎯 Interview‑Ready One‑Liner
“IaC scanning analyzes Terraform/Bicep/ARM templates for security misconfigurations before deployment, ensuring cloud infrastructure is secure by design.”

Runtime Security = Monitoring and protecting applications, containers, and cloud resources while they are running in production.
If DAST tests your app before release,
runtime security protects it after release.

🧠 Why Runtime Security Matters
Even after secure coding and scanning:
- New vulnerabilities appear
- Zero‑days emerge
- Misconfigurations slip through
- Attackers try to exploit running systems
Runtime security provides real‑time detection and protection.

🛠️ What Runtime Security Monitors
- Suspicious container behavior
- Unexpected network connections
- Privilege escalation
- File system changes
- Anomalous API calls
- Malware execution
- Policy violations

🔧 Common Runtime Security Tools
- Falco (Kubernetes runtime security)
- Microsoft Defender for Cloud
- Datadog Security
- Dynatrace Application Security
- Aqua Security
- Palo Alto Prisma Cloud

🎯 Interview‑Ready One‑Liner
“Runtime security protects applications and cloud workloads in production by detecting anomalies, attacks, and misconfigurations in real time.”


Code	SAST
Build	SCA
Test	DAST
Deploy	Iac Scanning
Run	Run Security