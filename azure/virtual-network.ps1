# Create an Azure virtual network

# Sign into Azure
Connect-AzAccount

# Create a resource group
$Location="EastUS"
New-AzResourceGroup -Name vm-networks -Location $Location

# Create a subnet and virtual network
$Subnet=New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
New-AzVirtualNetwork -Name myVnet -ResourceGroupName vm-networks -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

# Create two virtual machines
# Port 3389 (RDP) is opened by default when a Windows VM is created

#Create the first virtual machine (dataProcStage1)
 New-AzVm `
 -ResourceGroupName "vm-networks" `
 -Name "dataProcStage1" `
 -VirtualNetworkName "myVnet" `
 -SubnetName "default" `
 -image "Win2016Datacenter" `
 -Size "Standard_DS2_v2"

 # Return the public IP
 Get-AzPublicIpAddress -Name dataProcStage1

# Create a second virtual machine (dataProcStage2)
 New-AzVm `
 -ResourceGroupName "vm-networks" `
 -Name "dataProcStage2" `
 -VirtualNetworkName "myVnet" `
 -SubnetName "default" `
 -image "Win2016Datacenter" `
 -Size "Standard_DS2_v2"

# Disassociate the public IP from the second virtual machine (dataProcStage2)

$nic = Get-AzNetworkInterface -Name dataProcStage2 -ResourceGroup vm-networks
$nic.IpConfigurations.publicipaddress.id = $null
Set-AzNetworkInterface -NetworkInterface $nic

# Connect to the first VM using RDP
mstsc /v:publicIpAddress

# Try to ping the second VM
# Note: this will fail as the default firewall configuration prevents ping response
ping dataProcStage2 -4

# Connect to the second VM using RDP
# Hop onto dataProcStage2 via dataProcStage2
# Enable the File and Printer Sharing (Echo Request - ICMPv4-In) Inbound Rule

ping dataProcStage2 -4

# Cleanup
Remove-AzResourceGroup -Name vm-networks