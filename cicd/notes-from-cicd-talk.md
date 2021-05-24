# Practical Tips and Tricks for CI/CD success

Notes from a talk by @zmarkan from CircleCI

## Continuous Integration (CI)

*The practice of merging all developers working copies to a shared code repository*

- Code
- Shared Code Repo
- CI/CD Runtime
- Test
- Scan for Vulnerabilities
- Build Image

## Continuous Deployment (CD)

*The practice of automatedly deploying new software releases to target environments*

- Build Image
- Production Kubernetes
- Active Users

## Speed

*Go fast, but not too fast.  Payload is the **signal***

- Time to run the CI/CD pipeline
- Time to recover from a failing build
- Time to ship a feature
- Time to onboard a new team member

### Running your pipelines faster

- Use rightsized resources (scale up/out)
- Utilise cache (reuse previous dependencies)
- Run jobs and tests in parallel (subsets of tests)
- Pick what runs when (perhaps run full test suite on main)

### Recovering from failures

- Insight into what happening with your builds
- Log everything
- Easy access to logs and build artefacts (push to an external server)
- Debug your builds as they fail

## Cost Factors

- How much does CI/CD cost you?
- Cost of the tools + cost of setup
- Cost of not automating
- Cost of work wasted dealing with under optimised tools

## Security and Risk management

- Keeping credentials safe (out of source control, inject as environment variables)
- Automating security scanning
- Privileged access & splitting responsibilities (least privilege)

## Beyond CI/CD

- Integration with external services (analytics)
- Getting out of the tool and into the ecosystem (ChatOps)
- Build/Deploy information - where you need it? (Issue tracking, monitoring tool)
- Who needs to know about it?

## People (TeamOps)

- CI/CD is a team responsibility
- Spread the knowledge to avoid bottlenecks
- CI/CD configuration as onboarding aid

## Revert

- Broken deploys **will** happen
- Enable fast recovery and reversion
- Favour small changes over large releases
- Plan, prepare and practise