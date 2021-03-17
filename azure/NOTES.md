# Notes on Azure

## Tools

### Network Watcher
Can be used to map and troubleshoot networks within Azure

Network Watcher > Topology

## Commands

### PsPing

Tests ping connectivity through an endpoint

```bash
psping -n 100 -i 0 -q -h <ip address>:<port>
```

### Netstat

Run the `netstat -an` command to verify a port is listening

### TcPing

Similar to ping, execpt that it operates over a TCP connection rather than ICMP.

```bash
tcping <ip address> <port>
```
