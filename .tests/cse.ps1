
#for VM custom script extension script deployment - lesson 073

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools
# Download web files
Invoke-WebRequest https://storemmzuvzj6fvi3q.blob.core.windows.net/automation/index.html -OutFile C:\inetpub\wwwroot\index.htm




