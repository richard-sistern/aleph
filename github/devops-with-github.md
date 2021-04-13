# DevOps with GitHub

*Notes from Azure training day*

"The union of people, process and products to enable continuous delivery of value to your end users" - Donovan Brown

Three pillars:

- People
- Process
- Product

**Process**

1. Plan
2. Develop
3. Deliver
4. Operate

Link with Teams via GitHub for Teams, also an Enterprise version.

**Further Reading**

aka.ms/all-things-devops

aka.ms/getting-started-devops

Main trunk development with feature flags with Kanban swim lane for PR's.  Short-lived feature branches.  Workflow based on GitHub actions.

Fail fast then course correct.

**CI**

- Your changes work with other changes
- Your code still builds
- You tests still run

*Code linting happens here*

**CD**

- You have work that will deploy
- Including infrastructure and dependencies
- Everything you need to deploy

**Deployment Slots**

Allows testing of new releases with traffic redirection.  Also covers phased migration, A/B deployment.

**Handling Secrets**

GitHub Secrets, repository specific and set  in `Settings \ Secrets`.  Azure Key Vault provides a central place to manage secrets.git

**Security and Compliance**

- Dependency insights
- Vulnerability Management
- CodeQL

Setup a `Security Policy` in GitHub with Dependabot and code scanning.

Dockerfile, set commands to run as `USER 1000`.  Some applications will require additional permissions. 

**Automation**

Azure Logic App with Teams integration for ChatOps

