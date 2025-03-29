variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "databricks_location" {
  description = "Azure region where the Databricks workspace will be created"
  type        = string
}

variable "databricks_sku" {
  description = "SKU of the Databricks workspace (premium or standard)"
  type        = string
  default     = "premium"
}

variable "databricks_managed_resource_group_name" {
  description = "Name of the managed resource group for Databricks"
  type        = string
}

variable "databricks_virtual_network_id" {
  description = "ID of the virtual network for Databricks (optional)"
  type        = string
  default     = ""
}

variable "databricks_private_subnet_name" {
  description = "Name of the private subnet for Databricks (optional)"
  type        = string
  default     = ""
}

variable "databricks_public_subnet_name" {
  description = "Name of the public subnet for Databricks (optional)"
  type        = string
  default     = ""
}

variable "databricks_tags" {
  description = "Tags to be applied to all Databricks resources"
  type        = map(string)
  default     = {}
}

# Additional variables for cluster configuration
variable "databricks_cluster_name" {
  description = "Name of the default Databricks cluster"
  type        = string
  default     = "default-cluster"
}

variable "databricks_cluster_node_type" {
  description = "Node type for the Databricks cluster"
  type        = string
  default     = "Standard_DS3_v2"
}

variable "databricks_cluster_min_workers" {
  description = "Minimum number of workers for the cluster"
  type        = number
  default     = 1
}

variable "databricks_cluster_max_workers" {
  description = "Maximum number of workers for the cluster"
  type        = number
  default     = 4
}

variable "databricks_cluster_autotermination_minutes" {
  description = "Minutes after which the cluster will auto-terminate"
  type        = number
  default     = 60
} 