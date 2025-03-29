# Databricks Workspace Configuration
databricks_workspace_name = "my-databricks-workspace"
databricks_location = "eastus"  # Azure region
databricks_sku = "premium"      # premium or standard
databricks_managed_resource_group_name = "databricks-managed-rg"

# Network Configuration
databricks_virtual_network_id = ""  # Optional: VNet ID if using custom network
databricks_private_subnet_name = "" # Optional: Private subnet name
databricks_public_subnet_name = ""  # Optional: Public subnet name

# Tags
databricks_tags = {
  Environment = "production"
  Project     = "data-analytics"
  ManagedBy   = "terraform"
} 