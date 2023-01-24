
# Azure Terraform modules

To show sensative values, use:

terraform output <name_of_value>

Example - terraform output host



## azure-ubuntu-vm
Deploys a vanilla Ubuntu VM

## aks-cluster
Creates a 2 node AKS cluster on Azure, with a dns name and load balancer.
You will need to create a service principal before user.

az ad sp create-for-rbac

Add appId and password to terraform.tfvars


## aks-nginx-httpbin
Deploys httpbin application to the AKS cluster.

## aks-nginx-lua
Deploys httpbin application to the cluster.
Adds the Salt Lua injection at the ingress controller level.

## aks-nginx-lua-per-ingress
Deploys 2 httpbin applications to the cluster. (httpbinA and httpbinB)
Adds the Salt Lua injection at the ingress level of httpbinA.

