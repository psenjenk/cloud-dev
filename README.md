# Cloud Deployment Guide for Developers

## About

This repository provides a comprehensive toolkit for deploying and managing cloud infrastructure across multiple cloud providers (AWS, Azure, and GCP) with a focus on data platform infrastructure. It combines Infrastructure as Code (Terraform) with CLI-based approaches to offer flexibility in deployment methods.

## Project Structure

```
.
├── cloud-providers/           # Cloud provider specific configurations
│   ├── aws/                  # AWS specific resources and configurations
│   ├── azure/                # Azure specific resources and configurations
│   └── gcp/                  # GCP specific resources and configurations
├── configs/                  # Main configuration directory
│   ├── databricks/          # Databricks specific configurations
│   ├── snowflake/           # Snowflake specific configurations
│   ├── main.tfvars          # Main configuration file
│   ├── databricks.tfvars    # Databricks variables
│   └── snowflake.tfvars     # Snowflake variables
├── terraform/               # Core Terraform configurations
├── Dockerfile              # Container definition
├── docker-compose.yml      # Container orchestration
└── settings.json          # Project settings
```

## Features

- **Multi-Cloud Support**
  - AWS infrastructure deployment
  - Azure resource management
  - GCP service configuration

- **Data Platform Infrastructure**
  - Azure Databricks workspace deployment
  - Snowflake account and resource management
  - Integrated data storage solutions

- **Infrastructure as Code**
  - Terraform-based deployments
  - Modular configuration structure
  - Version-controlled infrastructure

- **Containerization**
  - Docker support
  - Containerized deployment options
  - Development environment consistency

## Prerequisites

- Terraform >= 1.0.0
- Docker and Docker Compose
- Cloud provider CLIs:
  - AWS CLI
  - Azure CLI
  - Google Cloud SDK
- Cloud provider accounts and credentials
- Snowflake account (for data platform features)

## Quick Start

1. **Clone the Repository**
   ```bash
   git clone [repository-url]
   cd cloud-dev
   ```

2. **Configure Environment**
   ```bash
   # Copy example configurations
   cp configs/main.tfvars.example configs/main.tfvars
   cp configs/databricks.tfvars.example configs/databricks.tfvars
   cp configs/snowflake.tfvars.example configs/snowflake.tfvars
   
   # Edit configuration files with your values
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Deploy Infrastructure**
   ```bash
   # Review planned changes
   terraform plan -var-file="configs/main.tfvars"
   
   # Apply changes
   terraform apply -var-file="configs/main.tfvars"
   ```

## Data Platform Configuration

### Databricks Setup

The Databricks configuration includes:
- Workspace configuration
- Network settings
- Cluster management
- Resource group configuration

Key configuration files:
- `configs/databricks/main.tfvars`
- `configs/databricks_variables.tf`

### Snowflake Setup

The Snowflake configuration includes:
- Account and region settings
- Database and warehouse configuration
- User and role management
- Storage integrations

Key configuration files:
- `configs/snowflake/main.tfvars`
- `configs/snowflake_variables.tf`

## Security Best Practices

1. **Credential Management**
   - Use environment variables for sensitive data
   - Implement secrets management solutions
   - Never commit credentials to version control

2. **Network Security**
   - Configure VNet integration where applicable
   - Implement IP restrictions
   - Use private endpoints

3. **Access Control**
   - Follow principle of least privilege
   - Implement RBAC
   - Use managed identities

## Resource Naming Convention

Resources follow standardized naming patterns:
- Databricks: `{project_name}-{environment}-{resource_type}`
- Snowflake: `{project_name}_{environment}_{resource_type}`

## Maintenance and Operations

1. **Regular Maintenance**
   - Monitor resource usage
   - Update configurations as needed
   - Review and optimize costs

2. **Troubleshooting**
   - Check cloud provider logs
   - Verify network connectivity
   - Review access permissions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and feature requests, please use the GitHub issue tracker. 