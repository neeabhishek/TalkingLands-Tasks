Task: You are tasked with provisioning a basic web application stack in AWS using Terraform.

Requirement: 
1. Deploy an EC2 instance running an Nginx server.
2. Use a security group to allow HTTP (port 80) and SSH (port 22) access.
3. The Nginx server should display a custom webpage with the text: "Deployed via Terraform."
4. Use variables to make the configuration reusable for different environments (e.g., dev, prod)

Terraform Docs:
1.https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attribute-reference
2.https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
3.https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
4.https://developer.hashicorp.com/terraform/language/resources/provisioners/file#file-provisioner
5.https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
6.https://developer.hashicorp.com/terraform/language/resources/provisioners/connection