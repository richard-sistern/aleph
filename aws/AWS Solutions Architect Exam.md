# AWS: Solutions Architect Exam

*Architect and deploy secure and robust solutions on AWS*

[AWS exam resources](https://aws.amazon.com/certification/certified-solutions-architect-associate/)

Re-certification is every 3 years.  A **discount** is available in the benefits section of the certification site.

## Exam Overview

### Question Domains

- Design resilient architectures
- Design high performing architectures
- Design secure applications and architectures
- Design cost optimised architectures

### Considerations

- Expect 'single AZ' will never be a right answer
- Use of AWS managed services should always be preferred
- Fault tolerant and high availability are not the same thing
- Expect that everything will fail at some point and design accordingly 
- Using caching strategies to improve performance
- If data in unstructured S3 is generally the storage solution
- IAM roles are easier and safer than keys and passwords
- Monitor metrics across the system
- Provide alerts for anomalous consideration

## Services and Concepts

### General

AMI IDs are different in each region as stored in regional S3 buckets. 

#### Scaling

Can have for multiple resources or EC2 specific

**Vertical:** Small to Large

**Horizontal**: 1 to x

### EC2 Instance Store

Some can have `ephemeral` volumes for buffer, scratch type data.

### Elastic Block Store (EBS)

Attaches in same availability zone.  `Persistent` storage independent of instances.  Several types

- General purpose SSD (gp2)
- Provisioned IOPS SSD (io1)
- Throughput optimised HDD (st1)
- Cold HDD (sc1)

By default EBS can't be attached to more than one EC2 instance.  Automatically replicated within an availability zone

Amazon EBS FAQs: https://aws.amazon.com/ebs/faqs/

Whitepaper – AWS Storage Services Overview: https://d0.awsstatic.com/whitepapers/Storage/AWS Storage Services Whitepaper-v9.pdf

SPL Lab – Introduction to Amazon Elastic Block Store: https://amazon.qwiklabs.com/catalog?keywords=Introduction+to+Amazon+Elastic+Block+Store+(EBS)&format[]=any&level[]=any&duration[]=any&price[]=any&modality[]=any&language[]=any

Amazon EC2 Instance Store: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html



### Simple Queue Service (SQS) 

Helps to decouple services.

Web Server > ELB > Logging Service [1, 2, 3] > Dynamo DB

### Elastic Load Balancing (ELB)

- Network load balancer (OSI layer 4).  Suitable for TCP packets and high performance applications
- Application load balancer (OSI layer 7).  Suitable for HTTP/HTTPS and supports TLS

Elastic Load Balancing Documentation: https://aws.amazon.com/documentation/elastic-load-balancing/

Amazon SQS FAQs: https://aws.amazon.com/sqs/faqs/

Elastic Load Balancing FAQs: https://aws.amazon.com/elasticloadbalancing/faqs/

Amazon EC2 FAQs: https://aws.amazon.com/ec2/faqs/

Amazon Route 53 Documentation: https://aws.amazon.com/documentation/route53/

### Elastic File System (EFS)

Shared storage with elastic capacity.  Create and mount EFS in VPC, can spread across availability zones to numerous EC2 instances.  Recommended to access file system from a mount target in the same availability zone.

### Simple Storage Services (S3)

Encryption at rest (SSE-S3, SSE-KMS, SSE-C)

Encryption in transit (TLS)

Allows versioning, has immutable objects.  Doesn't span across regions

**Access Control**

- Object ACL
- Bucket ACL
- Bucket policies
- IAM policies

**Costs**

- GBs per month
- Transfer out of region
- PUT, COPY, POST, LIST, and GET requests

**Free**

- Transfer into S3
- Transfer out from S3 to another service in region

**Storage Classes**

- General Purpose (standard)
- Infrequently Accessed Data (Standard-infrequent access)

Lifecycle Policies

Allows you to delete or move objects based on age.

### Glacier

Data backup and archive storage.

### Fault Tolerance

Loosely couple service tiers, for example:

Web Servers [1 ,2 ,3] > Load Balancer > Application Servers [1, 2, 3]

[AWS Well Architected Framework](https://aws.amazon.com/architecture/well-architected/)

### CloudFormation

Service for deploying and managing AWS resources in a consistent and reproducible manner.  Infrastructure as Code.

- Template (definition of resources to create in JSON)
- Stack (collection of AWS resources)

Use mappings to specify base AMI ID if working across regions.

### Lambda

Fully managed compute service to run stateless code.

Use CloudWatch Logs to view output of print statements.



### RDS (SQL)

Can have read replicas for enhanced performance. 

Host primary and standby in different availability zones.

Supports complex transactions and a medium-to-high query/write rate

### Dynamo DB (NoSQL)

Has provisioned throughput



### CloudFront

Hosts static and dynamic content at edge locations.

### ElastiCache

Sits in front of read heavy services like RDS, DyamoDB and MongoDB.

Also supports Memcached and Redis

### CloudWatch

Monitoring service which can trigger alarms to start an auto-scaling event.

Example Metrics

- CPU %
- Read throughput
- Write throughput

### Security

**Shared Responsibility Model**

Customers are responsible for security `in` the cloud

AWS are responsible for the security `of` the cloud

**Identity and Access Management (IAM)**

Least privilege management of users, groups, roles

**Key Management Service (KMS)**

Multi-tenant

Managed keys and can host customer key data

Can be used to encrypt EBS volumes

**Cloud HSM**

Single-tenant

Hardware based key management.  Can only be managed by the customer

### Virtual Private Cloud (VPC)

Design network architecture in the cloud, covers:

- Security
- Network isolation
- Management of IP addresses
- Internet accessibility (subnet)
- Routing

Security group is associated with an elastic network interface and only support allow rules.  Stateful (if allowed in then allowed out)

Network ACLs are associated with a subnet and supports allow and deny rules.  Stateless (have to allow both in and out)





