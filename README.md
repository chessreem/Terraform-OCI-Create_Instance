# Terraform-OCI-Create_Instance
Create a new OCI Instance, either from a new Boot Volume, or clone from an existing one.

# Benefits
- Create new Instance in a matter of seconds, instead of the long error-prone process of clicking in the OCI Concole.
- Option of just creating new Instances without Terraform managing them (using the batch script, deletes Terraform history).

# Usage
1. Download Terraform.exe to the root folder
2. Create OCI API key for user with permissions
3. Put the key in root folder
4. Assign the variables, preferably in a terraform.tfvars file
5. Run run_create_instance.bat
6. Follow the instructions on the cmd screen
