# Environment Configuration
environment = "production"
project_name = "data-analytics"
region = "eastus"

# Common Tags
common_tags = {
  Environment = "production"
  Project     = "data-analytics"
  ManagedBy   = "terraform"
  Owner       = "data-team"
  CostCenter  = "data-platform"
}

# Import Databricks Configuration
databricks_config = {
  workspace_name = "my-databricks-workspace"
  location = "eastus"
  sku = "premium"
  managed_resource_group_name = "databricks-managed-rg"
  cluster_name = "default-cluster"
  cluster_node_type = "Standard_DS3_v2"
  cluster_min_workers = 1
  cluster_max_workers = 4
  cluster_autotermination_minutes = 60
}

# Import Snowflake Configuration
snowflake_config = {
  account = ""  # Required: Your Snowflake account identifier
  region = "us-east-1"
  environment = "production"
  database_name = "my_database"
  warehouse_name = "my_warehouse"
  warehouse_size = "XSMALL"
  warehouse_auto_suspend = 60
  warehouse_auto_resume = true
  role_name = "my_role"
  user_name = "my_user"
  user_password = ""  # Required: Set securely
  user_email = ""    # Required: User's email address
}

# Snowflake Additional Resources
snowflake_schemas = ["PUBLIC", "RAW", "TRANSFORMED", "ANALYTICS"]
snowflake_file_formats = {
  csv = {
    format_type = "CSV"
    options = {
      COMPRESSION = "AUTO"
      FIELD_DELIMITER = ","
      RECORD_DELIMITER = "\n"
      SKIP_HEADER = 1
    }
  }
  json = {
    format_type = "JSON"
    options = {
      COMPRESSION = "AUTO"
      STRIP_OUTER_ARRAY = true
    }
  }
  parquet = {
    format_type = "PARQUET"
    options = {
      COMPRESSION = "AUTO"
      BINARY_AS_TEXT = false
    }
  }
}

# Storage Integration Configuration
snowflake_storage_integrations = {
  s3_integration = {
    storage_provider = "S3"
    storage_allowed_locations = ["s3://my-bucket/"]
    storage_blocked_locations = []
  }
  azure_integration = {
    storage_provider = "AZURE"
    storage_allowed_locations = ["azure://my-container/"]
    storage_blocked_locations = []
  }
} 