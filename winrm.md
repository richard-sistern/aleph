# Windows Remote Management

## Commands


### Current Configuration
winrm get winrm/config

winrm enumerate winrm/config/listener

### Testing

```powershell
# HTTPS Listener
Test-NetConnection <FQDN> -port 5985

# HTTPS Listener
Test-NetConnection <FQDN> -port 5986
```
