variable "snowflake_account" {
  description = "Snowflake account identifier"
  type        = string
}

variable "snowflake_region" {
  description = "Snowflake region"
  type        = string
  default     = "us-east-1"
}

variable "snowflake_environment" {
  description = "Environment name (e.g., production, development)"
  type        = string
  default     = "production"
}

variable "snowflake_database_name" {
  description = "Name of the Snowflake database"
  type        = string
}

variable "snowflake_database_comment" {
  description = "Comment for the Snowflake database"
  type        = string
}

variable "snowflake_warehouse_name" {
  description = "Name of the Snowflake warehouse"
  type        = string
}

variable "snowflake_warehouse_size" {
  description = "Size of the Snowflake warehouse"
  type        = string
  default     = "XSMALL"
}

variable "snowflake_warehouse_auto_suspend" {
  description = "Auto-suspend time in seconds"
  type        = number
  default     = 60
}

variable "snowflake_warehouse_auto_resume" {
  description = "Whether to auto-resume the warehouse"
  type        = bool
  default     = true
}

variable "snowflake_role_name" {
  description = "Name of the Snowflake role"
  type        = string
}

variable "snowflake_role_comment" {
  description = "Comment for the Snowflake role"
  type        = string
}

variable "snowflake_user_name" {
  description = "Name of the Snowflake user"
  type        = string
}

variable "snowflake_user_password" {
  description = "Password for the Snowflake user"
  type        = string
  sensitive   = true
}

variable "snowflake_user_email" {
  description = "Email address for the Snowflake user"
  type        = string
}

variable "snowflake_tags" {
  description = "Tags to be applied to Snowflake resources"
  type        = map(string)
  default     = {}
}

# Additional variables for Snowflake resources
variable "snowflake_schemas" {
  description = "List of schemas to create in the database"
  type        = list(string)
  default     = ["PUBLIC", "RAW", "TRANSFORMED"]
}

variable "snowflake_file_formats" {
  description = "File formats to create in the database"
  type        = map(object({
    format_type = string
    options     = map(string)
  }))
  default = {
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
  }
}

variable "snowflake_storage_integrations" {
  description = "Storage integrations for external storage"
  type        = map(object({
    storage_provider = string
    storage_allowed_locations = list(string)
    storage_blocked_locations = list(string)
  }))
  default = {}
} 