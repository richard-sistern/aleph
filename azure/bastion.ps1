# https://docs.microsoft.com/en-gb/learn/modules/connect-vm-with-azure-bastion/3-how-does-azure-bastion-work

# Create an Azure Bastion subnet

$subnetName = "AzureBastionSubnet"
$virtualNetwork = MyVirtualNetwork
$addressPrefix = "10.0.2.0/24"
$subnet = New-AzVirtualNetworkSubnetConfig `
-Name $subnetName `
-AddressPrefix $addressPrefix `

# Add to existing virtual network
Add-AzVirtualNetworkSubnetConfig `
-Name $subnetName `
-VirtualNetwork $virtualNetwork `
-AddressPrefix $addressprefix

# Create a public IP address for Azure Bastion
$publicip = New-AzPublicIpAddress `
-ResourceGroupName "myBastionRG" `
-name "myPublicIP" `
-location "westus2" `
-AllocationMethod Static `
-Sku Standard

# Create the Bastion Resource
$bastion = New-AzBastion `
-ResourceGroupName "myBastionRG" `
-Name "myBastion" `
-PublicIpAddress $publicip `
-VirtualNetwork $virtualNetwork
