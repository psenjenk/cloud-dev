# Snowflake Account Configuration
snowflake_account = ""  # Your Snowflake account identifier
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
snowflake_user_password = ""  # Should be set securely, not in plain text
snowflake_user_email = ""    # User's email address

# Tags
snowflake_tags = {
  Environment = "production"
  Project     = "data-analytics"
  ManagedBy   = "terraform"
} 