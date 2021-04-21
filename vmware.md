



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

### Networking

**Policy Levels**

Standard switch: default policies for all ports

Port group: effective polices which override the default policy

**Policies**

- Promiscuous mode: allow a virtual switch or port group to forward all traffic regardless of destination
- MAC address changes: accept or reject `inbound` traffic when the MAC address is altered by the guest
- Forged transmits: accept or reject `outbound` traffic when the MAC address is altered by the guest

*All set to reject by default*

**Load Balancing**

- Originating Virtual Port ID: map VM outbound traffic to specific physical NIC based on the originating virtual port ID.  Random assignment
- Source MAC Hash: map the outbound traffic for each VM to a specific physical NIC.  Assignment based on hash, therefore does a better job than random assignment but requires a bit more CPU
- Source and Destination IP Hash: a NIC for each outbound packet is selected based on the source and destination IP addresses.  Requires 802.3ad link aggregation protocol on physical switch

**Handling Failure**

The VMkernal can use `link status` or `beaconing` (or both) to detect a network failure

### Storage

Datastores should preferably have a 1:1 mapping to LUNs.  Possible for a datastore to be spread across multiple LUNs but not recommended

### VMotion

**Requirements**

- Shared storage
- Shared VMkernal ports
- No connection to mounted local virtual (ISO) device