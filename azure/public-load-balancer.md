# Configure a public load balancer

## Deploy the patient portal web application

The following script:

- Creates a virtual network, and network infrastructure
- Create two virtual machines in the virtual network

```bash
git clone https://github.com/MicrosoftDocs/mslearn-improve-app-scalability-resiliency-with-load-balancer.git
cd mslearn-improve-app-scalability-resiliency-with-load-balancer

bash create-high-availability-vm-with-sets.sh learn-a98278c1-0cb1-482b-b463-4eac23ec066d
```

## Create IP addresses

Create a new public IP address

```bash
pwsh

$Location = $(Get-AzureRmResourceGroup -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d).Location

$publicIP = New-AzPublicIpAddress `
  -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d `
  -Location $Location `
  -AllocationMethod "Static" `
  -Name "myPublicIP"
```

Create a front-end IP called `myFrontEnd` which attaches to the `myPublicIP` address

## Create the load balancer

Create a back-end address pool called `myBankEndPool`

```powershell
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"
```

Create a health probe to dynamically add/remove virtual machines based on their response to health checks

```powershell
$probe = New-AzLoadBalancerProbeConfig `
  -Name "myHealthProbe" `
  -Protocol http `
  -Port 80 `
  -IntervalInSeconds 5 `
  -ProbeCount 2 `
  -RequestPath "/"
```

Define how traffic is distributed to the virtual machines

```powershell
$lbrule = New-AzLoadBalancerRuleConfig `
  -Name "myLoadBalancerRule" `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -Probe $probe
```

Create a basic load balancer

```powershell
$lb = New-AzLoadBalancer `
  -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d `
  -Name 'MyLoadBalancer' `
  -Location $Location `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Probe $probe `
  -LoadBalancingRule $lbrule
```

Connect the virtual machines to the bank-end pool

```powershell
$nic1 = Get-AzNetworkInterface -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d -Name "webNic1"
$nic2 = Get-AzNetworkInterface -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d -Name "webNic2"

$nic1.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool
$nic2.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool

Set-AzNetworkInterface -NetworkInterface $nic1 -AsJob
Set-AzNetworkInterface -NetworkInterface $nic2 -AsJob
```

Retrieve the public IP address of the load balancer

```powershell
Write-Host http://$($(Get-AzPublicIPAddress `
  -ResourceGroupName learn-a98278c1-0cb1-482b-b463-4eac23ec066d `
  -Name "myPublicIP").IpAddress)
```

