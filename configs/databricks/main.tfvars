# Databricks Workspace Configuration
databricks_workspace_name = "my-databricks-workspace"
databricks_location = "eastus"  # Azure region
databricks_sku = "premium"      # premium or standard
databricks_managed_resource_group_name = "databricks-managed-rg"

# Network Configuration
databricks_virtual_network_id = ""  # Optional: VNet ID if using custom network
databricks_private_subnet_name = "" # Optional: Private subnet name
databricks_public_subnet_name = ""  # Optional: Public subnet name

# Cluster Configuration
databricks_cluster_name = "default-cluster"
databricks_cluster_node_type = "Standard_DS3_v2"
databricks_cluster_min_workers = 1
databricks_cluster_max_workers = 4
databricks_cluster_autotermination_minutes = 60

# Tags
databricks_tags = {
  Environment = "production"
  Project     = "data-analytics"
  ManagedBy   = "terraform"
  Owner       = "data-team"
  CostCenter  = "data-platform"
} 