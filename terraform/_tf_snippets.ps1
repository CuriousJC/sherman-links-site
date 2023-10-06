<#  INITIALIZE SO WE CAN CONNECT TO OUR CLOUD-STORAGE STATE#>
terraform init #init the environment -- this must be done from the terraform/env directory because each has it's own providers.tf connection and state file in Azure
terraform plan -var-file "aws.tfvars" #generate a plan of what needs to happen
terraform apply -var-file "aws.tfvars" #compare desired state to current real state
terraform destroy -var-file "aws.tfvars" #compare desired state to current real state