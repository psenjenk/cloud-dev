# Cloud Deployment Guide for Developers

## About

This repository contains a comprehensive guide and automation scripts for deploying cloud infrastructure across multiple cloud providers (AWS, Azure, and GCP). It serves as a practical reference for developers who need to work with different cloud platforms, offering both CLI-based and Infrastructure-as-Code (Terraform) approaches.

Key features:
- Multi-cloud deployment guides
- Infrastructure as Code examples using Terraform
- Docker containerization support
- Step-by-step CLI instructions
- Best practices for cloud resource management
- Data platform infrastructure (Databricks and Snowflake)

This guide provides practical steps for deploying resources on AWS, Azure, and GCP using both CLI commands and Terraform.

## Data Platform Infrastructure

### Overview

The repository includes Terraform configurations for deploying and managing a data platform infrastructure using Azure Databricks and Snowflake.

### Configuration Structure

The data platform configuration is organized into the following structure:

```
configs/
├── main.tfvars                    # Main configuration file with common settings
├── databricks/
│   ├── main.tfvars               # Databricks-specific configuration
│   └── variables.tf              # Databricks variable definitions
└── snowflake/
    ├── main.tfvars               # Snowflake-specific configuration
    └── variables.tf              # Snowflake variable definitions
```

#### Core Configuration Files

- `configs/main.tfvars`: Main configuration file containing common variables and references to Databricks and Snowflake configurations
- `configs/databricks/main.tfvars`: Databricks-specific configuration including workspace, network, and cluster settings
- `configs/snowflake/main.tfvars`: Snowflake-specific configuration including database, warehouse, and user settings

### Prerequisites for Data Platform

- Terraform >= 1.0.0
- Azure CLI (for Databricks deployment)
- Snowflake account and credentials
- Azure subscription with appropriate permissions

### Configuration Components

#### Databricks Configuration

The Databricks configuration includes:

- Workspace settings (name, location, SKU)
- Network configuration (optional VNet integration)
- Cluster configuration
  - Node types
  - Worker counts
  - Auto-termination settings
- Resource group management

#### Snowflake Configuration

The Snowflake configuration includes:

- Account and region settings
- Database configuration
- Warehouse settings
  - Size and scaling options
  - Auto-suspend/resume settings
- Role and user management
- Schema configuration
- File format definitions
- Storage integrations (S3, Azure)

### Usage for Data Platform

1. Clone this repository
2. Update the configuration files with your specific values:
   ```bash
   cp configs/main.tfvars configs/main.tfvars.example
   # Edit configs/main.tfvars with your values
   ```

3. Required values to set:
   - `snowflake_account`: Your Snowflake account identifier
   - `snowflake_user_password`: Secure password for the Snowflake user
   - `snowflake_user_email`: Email address for the Snowflake user
   - Storage integration paths in `snowflake_storage_integrations`

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Review the planned changes:
   ```bash
   terraform plan -var-file="configs/main.tfvars"
   ```

6. Apply the configuration:
   ```bash
   terraform apply -var-file="configs/main.tfvars"
   ```

### Security Considerations for Data Platform

1. Sensitive Values:
   - Never commit sensitive values directly in the configuration files
   - Use environment variables or a secrets management solution for sensitive data
   - Consider using Azure Key Vault or similar for credential management

2. Network Security:
   - Configure VNet integration for Databricks when required
   - Set appropriate IP restrictions for Snowflake access
   - Use private endpoints where possible

3. Access Control:
   - Follow the principle of least privilege for Snowflake roles
   - Implement appropriate RBAC for Databricks workspace
   - Use managed identities where possible

### Resource Naming Convention

Resources follow the following naming convention:
- Databricks: `{project_name}-{environment}-{resource_type}`
- Snowflake: `{project_name}_{environment}_{resource_type}`

### File Formats

Pre-configured file formats include:
- CSV: Standard CSV format with header skipping
- JSON: JSON format with array stripping
- Parquet: Optimized for columnar storage

### Storage Integrations

Pre-configured storage integrations for:
- Amazon S3
- Azure Blob Storage

Update the storage paths in `snowflake_storage_integrations` with your actual bucket/container paths.

### Maintenance

1. Regular Updates:
   - Review and update cluster configurations based on usage patterns
   - Monitor warehouse sizes and adjust as needed
   - Update file formats as new data types are introduced

2. Cost Optimization:
   - Monitor Databricks cluster usage and adjust auto-termination settings
   - Review Snowflake warehouse sizes and auto-suspend settings
   - Clean up unused resources regularly

### Troubleshooting

Common issues and solutions:

1. Databricks:
   - VNet integration issues: Check subnet configurations
   - Cluster startup failures: Verify node types and quotas
   - Permission issues: Review RBAC assignments

2. Snowflake:
   - Connection issues: Verify account identifier and credentials
   - Storage integration failures: Check IAM roles and permissions
   - Warehouse suspension: Review auto-suspend settings

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 