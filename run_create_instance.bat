cd /d %~dp0

terraform.exe init
terraform.exe apply

del /f /q terraform.tfstate
del /f /q terraform.tfstate.backup

pause