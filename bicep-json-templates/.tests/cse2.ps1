
#for VM custom script extension script deployment - lesson 073

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools
# Download web files
Invoke-WebRequest https://raw.githubusercontent.com/w-plw/cloud-deployment/refs/heads/main/bicep-json-templates/.tests/index.html -OutFile C:\inetpub\wwwroot\index.htm

# Download Azure CLI
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindowsx64 -OutFile AzureCLI.msi

# Install Azure CLI
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Download Azure PowerShell
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindowsx64 -OutFile AzureCLI.msi

# Install Azure PowerShell
Install-Module -Name Az -Repository PSGallery -Force
