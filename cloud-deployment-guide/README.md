# Cloud Deployment Guide for Developers

This guide provides practical steps for deploying resources on AWS, Azure, and GCP using both CLI commands and Terraform.

## Prerequisites

- AWS CLI, Azure CLI, and Google Cloud SDK installed
- Terraform installed
- Accounts and credentials for each cloud provider
- Basic understanding of cloud concepts

## AWS Deployment

### CLI Commands

1. Configure AWS CLI:
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Enter your default region (e.g., us-east-1)
# Enter your output format (json)
```

2. Create an EC2 instance:
```bash
# Create a key pair
aws ec2 create-key-pair --key-name my-key-pair --query 'KeyMaterial' --output text > my-key-pair.pem

# Launch EC2 instance
aws ec2 run-instances \
    --image-id ami-0c7217cdde317cfec \
    --instance-type t2.micro \
    --key-name my-key-pair \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=my-instance}]'
```

3. Create S3 bucket:
```bash
aws s3api create-bucket \
    --bucket my-unique-bucket-name \
    --region us-east-1
```

## Azure Deployment

### CLI Commands

1. Login to Azure:
```bash
az login
```

2. Create a resource group:
```bash
az group create --name myResourceGroup --location eastus
```

3. Create a VM:
```bash
az vm create \
    --resource-group myResourceGroup \
    --name myVM \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys
```

4. Create storage account:
```bash
az storage account create \
    --name mystorageaccount \
    --resource-group myResourceGroup \
    --location eastus \
    --sku Standard_LRS
```

## Google Cloud Platform (GCP) Deployment

### CLI Commands

1. Initialize GCP:
```bash
gcloud init
```

2. Create a VM instance:
```bash
gcloud compute instances create my-instance \
    --zone=us-central1-a \
    --machine-type=e2-micro \
    --image-family=ubuntu-2004-lts \
    --image-project=ubuntu-os-cloud
```

3. Create a storage bucket:
```bash
gsutil mb gs://my-unique-bucket-name
```

## Terraform Deployment

Create a new directory for Terraform files and create the following files:

### main.tf
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Azure Provider
provider "azurerm" {
  features {}
}

# GCP Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# AWS Resources
resource "aws_instance" "example" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-aws-instance"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
}

# Azure Resources
resource "azurerm_resource_group" "example" {
  name     = "terraform-resource-group"
  location = "eastus"
}

resource "azurerm_virtual_machine" "example" {
  name                  = "terraform-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size              = "Standard_D1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

# GCP Resources
resource "google_compute_instance" "example" {
  name         = "terraform-gcp-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
}

resource "google_storage_bucket" "example" {
  name          = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
  location      = "US"
  force_destroy = true
}

# Random ID for unique bucket names
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
```

### variables.tf
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "azure_location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}
```

### outputs.tf
```hcl
output "aws_instance_id" {
  value = aws_instance.example.id
}

output "azure_vm_id" {
  value = azurerm_virtual_machine.example.id
}

output "gcp_instance_id" {
  value = google_compute_instance.example.id
}
```

## Using Terraform

1. Initialize Terraform:
```bash
terraform init
```

2. Review the plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. Destroy resources:
```bash
terraform destroy
```

## AWS CloudFormation Deployment

Create a new file `template.yaml` for AWS CloudFormation:

```yaml
AWSTemplateFormatVersion: '2010-09-01'
Description: 'Basic infrastructure template for EC2 and S3'

Parameters:
  EnvironmentName:
    Description: Environment name
    Type: String
    Default: dev

Resources:
  # EC2 Instance
  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: t2.micro
      ImageId: ami-0c7217cdde317cfec
      Tags:
        - Key: Name
          Value: !Sub ${EnvironmentName}-instance

  # S3 Bucket
  MyS3Bucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: !Sub ${EnvironmentName}-bucket-${AWS::AccountId}
      VersioningConfiguration:
        Status: Enabled

Outputs:
  InstanceId:
    Description: ID of the created EC2 instance
    Value: !Ref MyEC2Instance
  BucketName:
    Description: Name of the created S3 bucket
    Value: !Ref MyS3Bucket
```

Deploy using AWS CLI:
```bash
# Create a stack
aws cloudformation create-stack \
    --stack-name my-stack \
    --template-body file://template.yaml \
    --parameters ParameterKey=EnvironmentName,ParameterValue=dev

# Monitor stack creation
aws cloudformation describe-stacks --stack-name my-stack

# Delete stack
aws cloudformation delete-stack --stack-name my-stack
```

## Azure Bicep Deployment

Create a new file `main.bicep` for Azure Bicep:

```bicep
param location string = resourceGroup().location
param environmentName string = 'dev'

// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${environmentName}-rg'
  location: location
  tags: {
    Environment: environmentName
  }
}

// Virtual Machine
resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: '${environmentName}-vm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '16.04-LTS'
        version: 'latest'
      }
    }
    osProfile: {
      computerName: '${environmentName}-vm'
      adminUsername: 'azureuser'
      adminPassword: 'ChangeMe123!' // Use Key Vault in production
    }
  }
}

// Storage Account
resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${environmentName}storage${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output vmId string = vm.id
output storageAccountName string = storage.name
```

Deploy using Azure CLI:
```bash
# Create a resource group
az group create --name dev-rg --location eastus

# Deploy Bicep template
az deployment group create \
    --resource-group dev-rg \
    --template-file main.bicep \
    --parameters environmentName=dev

# Delete resources
az group delete --name dev-rg --yes
```

## Google Cloud Deployment Manager

Create a new file `config.yaml` for Google Cloud Deployment Manager:

```yaml
imports:
  - path: vm.jinja
  - path: storage.jinja

resources:
  - name: my-vm
    type: vm.jinja
    properties:
      zone: us-central1-a
      machineType: e2-micro
      image: ubuntu-os-cloud/ubuntu-2004-lts

  - name: my-bucket
    type: storage.jinja
    properties:
      location: US
      storageClass: STANDARD
```

Create `vm.jinja`:
```jinja2
resources:
- name: {{ env['name'] }}
  type: compute.v1.instance
  properties:
    zone: {{ properties['zone'] }}
    machineType: zones/{{ properties['zone'] }}/machineTypes/{{ properties['machineType'] }}
    disks:
    - deviceName: boot
      type: PERSISTENT
      boot: true
      autoDelete: true
      initializeParams:
        sourceImage: global/images/{{ properties['image'] }}
    networkInterfaces:
    - network: global/networks/default
```

Create `storage.jinja`:
```jinja2
resources:
- name: {{ env['name'] }}
  type: storage.v1.bucket
  properties:
    location: {{ properties['location'] }}
    storageClass: {{ properties['storageClass'] }}
```

Deploy using gcloud CLI:
```bash
# Create deployment
gcloud deployment-manager deployments create my-deployment \
    --config config.yaml

# List deployments
gcloud deployment-manager deployments list

# Delete deployment
gcloud deployment-manager deployments delete my-deployment
```

## Important Notes

- Always review the plan before applying Terraform changes
- Keep your credentials secure and never commit them to version control
- Use variables for sensitive information
- Consider using a state file backend for team collaboration
- Clean up resources when not in use to avoid unnecessary costs

## Additional Resources

- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
- [Google Cloud SDK Documentation](https://cloud.google.com/sdk/docs)
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS CloudFormation Documentation](https://docs.aws.amazon.com/cloudformation/)
- [Azure Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Google Cloud Deployment Manager Documentation](https://cloud.google.com/deployment-manager/docs) 