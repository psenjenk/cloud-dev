output "aws_instance_id" {
  description = "ID of the created AWS instance"
  value       = aws_instance.example.id
}

output "aws_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.example.id
}

output "azure_vm_id" {
  description = "ID of the created Azure VM"
  value       = azurerm_virtual_machine.example.id
}

output "azure_resource_group" {
  description = "Name of the created Azure resource group"
  value       = azurerm_resource_group.example.name
}

output "gcp_instance_id" {
  description = "ID of the created GCP instance"
  value       = google_compute_instance.example.id
}

output "gcp_bucket_name" {
  description = "Name of the created GCP storage bucket"
  value       = google_storage_bucket.example.name
} 