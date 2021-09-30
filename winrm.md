# Windows Remote Management

## Commands


### Current Configuration

#### WINRM

winrm get winrm/config

winrm enumerate winrm/config/listener

#### Firewall

```powershell
Get-NetFirewallRule -DisplayGroup "Windows Remote Management"
```

### Testing

```powershell
# HTTPS Listener
Test-NetConnection <FQDN> -port 5985

# HTTPS Listener
Test-NetConnection <FQDN> -port 5986
```
