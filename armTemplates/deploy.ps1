
[cmdletbinding()] 
Param (



    [string]$resourceGroup= "nfsfusetest",

    [string]$location =  "westeurope",

    [string]$workspacename = "mritest1"





)

# Password length
$length = 20
 
# Characters
$chars = (48..57) + (65..90) + (97..122) + 36 + 33
 
# Generate 5 passwords
for ($i = 1; $i -le 5; $i++) {
	[string]$Password = $null
	$chars | Get-Random -Count $length | %{ $Password += [char]$_ }
	
	# Print them out on the monitor

}

& az group create --name $resourceGroup --location $location

$root = $PSScriptRoot + "/"
$templateFile = "$($root)./azuredeploy.json"
$templateParameterFile  = "$($root)./azuredeploy.parameters.json"
$paswd = ConvertTo-SecureString $Password -AsPlainText -Force


 New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup  -TemplateFile $templateFile -TemplateParameterFile $templateParameterFile -Verbose -workspaceName $workspacename -adminPasswordOrKey $paswd

Write-Host "Password = $($paswd)"
