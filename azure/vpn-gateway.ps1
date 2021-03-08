# Azure VPN Gateway

# Create a RouteBased VPN gateway
# Upload the public key for a root certificate for authentication purposes
# Generate a client certificate from the root certificate, and then install the client certificate on each client computer that will connect to the virtual network for authentication purposes
# Create VPN client configuration files, which contain the necessary information for the client to connect to the virtual network

# Setup
Connect-AzAccount

# Variables
$VNetName = "VNetData"
$FESubName = "FrontEnd"
$BESubName = "Backend"
$GWSubName = "GatewaySubnet"
$VNetPrefix1 = "192.168.0.0/16"
$VNetPrefix2 = "10.254.0.0/16"
$FESubPrefix = "192.168.1.0/24"
$BESubPrefix = "10.254.1.0/24"
$GWSubPrefix = "192.168.200.0/26"
$VPNClientAddressPool = "172.16.201.0/24"
$ResourceGroup = "VpnGatewayDemo"
$Location = "East US"
$GWName = "VNetDataGW"
$GWIPName = "VNetDataGWPIP"
$GWIPconfName = "gwipconf"

# Configure a virtual network
New-AzResourceGroup -Name $ResourceGroup -Location $Location

# Create subnet configurations 
$fesub = New-AzVirtualNetworkSubnetConfig -Name $FESubName -AddressPrefix $FESubPrefix
$besub = New-AzVirtualNetworkSubnetConfig -Name $BESubName -AddressPrefix $BESubPrefix
$gwsub = New-AzVirtualNetworkSubnetConfig -Name $GWSubName -AddressPrefix $GWSubPrefix

# Create virtual network with above subnet values and a static DNS server
New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroup -Location $Location -AddressPrefix $VNetPrefix1, $VNetPrefix2 -Subnet $fesub, $besub, $gwsub -DnsServer 10.2.1.3

# Load created network into variables
$vnet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroup
$subnet = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet

# Request a dynamically assigned public IP address
$pip = New-AzPublicIpAddress -Name $GWIPName -ResourceGroupName $ResourceGroup -Location $Location -AllocationMethod Dynamic
$ipconf = New-AzVirtualNetworkGatewayIpConfig -Name $GWIPconfName -Subnet $subnet -PublicIpAddress $pip

# Create the VPN gateway
# Note: this can take up to 45 minutes to complete
New-AzVirtualNetworkGateway -Name $GWName -ResourceGroupName $ResourceGroup `
    -Location $Location -IpConfigurations $ipconf -GatewayType Vpn `
    -VpnType RouteBased -EnableBgp $false -GatewaySku VpnGw1 -VpnClientProtocol "IKEv2"

# Add the VPN client address pool
$Gateway = Get-AzVirtualNetworkGateway -ResourceGroupName $ResourceGroup -Name $GWName
Set-AzVirtualNetworkGateway -VirtualNetworkGateway $Gateway -VpnClientAddressPool $VPNClientAddressPool

# Generate a client certificate

# Create a self-signed root certificate
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
    -Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 -KeyLength 2048 `
    -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

# Generate a client certificate signed by the above
New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature `
    -Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 -KeyLength 2048 `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")

# Export the public key
<# 
    1.  Run certmgr from PowerShell to open the Certificate Manager.
    2.  Go to Personal > Certificates.
    3.  Right-click the P2SRootCert certificate in the list, and select All tasks > Export.
    4.  In the Certificate Export Wizard, select Next.
    5.  Ensure that No, do not export the private key is selected, and then select Next.
    6.  On the Export File Format page, ensure that Base-64 encoded X.509 (.CER) is selected, and then select Next.
    7.  In the File to Export page, under File name, navigate to a location you'll remember, and save the file as P2SRootCert.cer, and then select Next.
    8.  On the Completing the Certificate Export Wizard page, select Finish.
    9.  On the Certificate Export Wizard message box, select OK.
#>

# Upload the root certificate
$P2SRootCertName = "P2SRootCert.cer"

$filePathForCert = "<cert-path>\P2SRootCert.cer"
$cert = new-object System.Security.Cryptography.X509Certificates.X509Certificate2($filePathForCert)
$CertBase64 = [system.convert]::ToBase64String($cert.RawData)
$p2srootcert = New-AzVpnClientRootCertificate -Name $P2SRootCertName -PublicCertData $CertBase64

Add-AzVpnClientRootCertificate -VpnClientRootCertificateName $P2SRootCertName -VirtualNetworkGatewayname $GWName -ResourceGroupName $ResourceGroup -PublicCertData $CertBase64

# Configure the native VPN client

$profile = New-AzVpnClientConfiguration -ResourceGroupName $ResourceGroup -Name $GWName -AuthenticationMethod "EapTls"
$profile.VPNProfileSASUrl

# Download and install the VPN settings from the URL provided above and verify with
# IPCONFIG /All
# Check the PPP vNetData dapater is in the VPNClient Address pool range of 192.16.201.0/24