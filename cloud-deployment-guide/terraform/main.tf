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
  region = var.aws_region
}

# Azure Provider
provider "azurerm" {
  features {}
}

# GCP Provider
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
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
  location = var.azure_location
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
  zone         = "${var.gcp_region}-a"

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