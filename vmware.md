



## Introduction

*Notes from the VMware vSphere: Install, Configure, Manage 7.0 course*



Skyline - support (health, advisor) technology, included with vSphere

### Recommended Ratios

|      | Virtual | Physical |
| ---- | ------- | -------- |
| CPU  | 10      | 1        |
|      | 2       | 1        |

*Best practice to not exceed the above*

### Automation

- PowerCLI
- ESXCLI

### Installation

Can use [Rufus](https://rufus.ie/en/) to generate a bootable ESXi USB from ISO

vSphere vCenter exposes a management interface on TCP:5480

### Containers

Docker and Kubernetes are integrated into vSphere 7.0:

- vSphere with Kubernetes - built into ESXi
- TENSU (TKG) - runs in virtual machines

### Security

Unlike Active Directory, roles and permissions apply in `union` rather than least privilege.  For example, all + none = all permissions.  

However, like Active Directory, object precedence still applies.  This includes user objects. For example, permissions applied to user take precedence over any group membership.

### Backup

Backup via the vCenter Server Appliance Management Interface.

Use vCenter Server HA to create replica vCenter servers

