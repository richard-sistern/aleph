



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

### Containers

Docker and Kubernetes are integrated into vSphere 7.0:

- vSphere with Kubernetes - built into ESXi
- TENSU (TKG) - runs in virtual machines