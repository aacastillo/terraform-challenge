## Architecture Diagram
![img.png](../images/initial-requirement.png)

## Requirements
- Build a Github Action CD pipeline that deploys that deploys modular Terraform code to Azure  cloud
- The Terraform code should provision a new network and a bastion host in that network that can be SSH’d into. Only allow the bastion host to access [PayPal.com](http://PayPal.com), and no other internet connection.
- The Terraform code should also provision one more instance that can only be access by the Bastion host