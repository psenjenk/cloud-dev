# Snowflake Account Configuration
snowflake_account = ""  # Required: Your Snowflake account identifier
snowflake_region = "us-east-1"  # Snowflake region
snowflake_environment = "production"

# Database Configuration
snowflake_database_name = "my_database"
snowflake_database_comment = "Main database for data analytics"

# Warehouse Configuration
snowflake_warehouse_name = "my_warehouse"
snowflake_warehouse_size = "XSMALL"  # XSMALL, SMALL, MEDIUM, LARGE, XLARGE, XXLARGE, etc.
snowflake_warehouse_auto_suspend = 60  # Auto-suspend after 60 seconds of inactivity
snowflake_warehouse_auto_resume = true

# Role Configuration
snowflake_role_name = "my_role"
snowflake_role_comment = "Role for data analytics team"

# User Configuration
snowflake_user_name = "my_user"
snowflake_user_password = ""  # Required: Set securely
snowflake_user_email = ""    # Required: User's email address

# Schema Configuration
snowflake_schemas = ["PUBLIC", "RAW", "TRANSFORMED", "ANALYTICS"]

# File Format Configuration
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

# Tags
snowflake_tags = {
  Environment = "production"
  Project     = "data-analytics"
  ManagedBy   = "terraform"
  Owner       = "data-team"
  CostCenter  = "data-platform"
} 