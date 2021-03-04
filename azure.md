# Azure

## PowerShell

### Basics 

#### Install the Az Module 

Ensure the latest version of PowerShellGet is installed

`Install-Module -Name PowerShellGet -Force`

Install the Azure module for current user

```powershell
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}
```

Alternatively, install for all users from an elevated shell

```powershell
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope AllUsers
}
```

Taken from the [Install Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-5.6.0) instructions from Microsoft.  There is also an [offline installer](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps-msi?view=azps-5.6.0) available for PowerShell 5.1.

It's also possible to connect using [CloudShell](https://shell.azure.com/powershell).  Please note, there is a small [cost](https://azure.microsoft.com/en-gb/pricing/details/cloud-shell/) associated with this.

#### Establish a Connection

When in doubt, use `Connect-AzAccount` as described in this [article](https://adamtheautomator.com/connect-azaccount/).



