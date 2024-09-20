
#for VM custom script extension script deployment - lesson 073

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools
# Download web files
Invoke-WebRequest https://raw.githubusercontent.com/w-plw/cloud-deployment/refs/heads/main/.tests/index.html -OutFile C:\inetpub\wwwroot\index.htm




