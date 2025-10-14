# terraform_scripts

## AWS Configuration

This project interacts with Amazon Web Services (AWS). To use it, you need to configure your AWS credentials.

### Quick Setup

The easiest way to configure credentials is using the AWS CLI:

```bash
aws configure
```
You will be prompted for the following information:

* **AWS Access Key ID**: Your access key.
* **AWS Secret Access Key**: Your secret key.
* **Default region name**: The AWS region you want to use (e.g., `us-east-1`, `eu-west-1`).
* **Default output format**: The output format for CLI responses (e.g., `json`, `yaml`, `table`). You can usually press Enter to skip.


### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (version 1.0+ recommended)
- AWS CLI configured with appropriate permissions ([see AWS Configuration](#aws-configuration))
- Access to the required AWS services

### Standard Workflow

Follow these steps to deploy the infrastructure:

#### 1. Initialize Terraform

The `init` command initializes your working directory, downloads required providers, and sets up the backend.

```bash
terraform init
```

**What this does:**
- Downloads AWS provider and other dependencies
- Configures the backend for state storage
- Sets up the `.terraform` directory

**Troubleshooting:** If you change backend configuration, run `terraform init -reconfigure`.

#### 2. Plan the Infrastructure

The `plan` command creates an execution plan, showing what resources will be created, modified, or destroyed.

```bash
terraform plan
```

For more detailed output:
```bash
terraform plan -var="environment=staging" -out=tfplan
```

**Key options:**
- `-var="key=value"`: Set input variables
- `-out=filename`: Save plan for later application
- `-var-file`: Use variable definitions file

#### 3. Apply the Configuration

The `apply` command provisions the actual resources. Terraform will show the execution plan and prompt for confirmation.

```bash
terraform apply
```

To apply without confirmation (useful for CI/CD):
```bash
terraform apply -auto-approve
```

To use a saved plan file:
```bash
terraform apply tfplan
```

#### 4. Destroy Resources (Optional)

To tear down all managed infrastructure:
```bash
terraform destroy
```

**Warning:** This will permanently delete all resources managed by this Terraform configuration.

### Common Variables

You may need to set these variables during plan/apply:

```bash
terraform plan -var="environment=production" -var="instance_type=t3.medium"
```

| Variable | Description | Default |
|----------|-------------|---------|
| `environment` | Deployment environment (dev/staging/prod) | `dev` |
| `region` | AWS region to deploy to | `us-east-1` |
| `instance_type` | EC2 instance type | `t3.micro` |


## Development Tools & Extensions

For the best experience working with this Terraform project, we recommend installing the following tools and extensions:

### Required Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **Terraform** | Infrastructure as Code core engine | [Download](https://developer.hashicorp.com/terraform/downloads) |
| **AWS CLI** | AWS command-line interface | [Install Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) |
| **AWS Toolkit** | IDE integration for AWS services | [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-toolkit-vscode) |
| **Hashicorp HCL** | Syntax support for HCL files | [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=hashicorp.hcl) |
| **Hashicorp Terraform** | Terraform language support | [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform) |

### Installation Guide

#### 1. Core Tools

**Terraform CLI**
```bash
# On macOS with Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# On Windows with Chocolatey
choco install terraform

# On Linux
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
apt update && apt install terraform
```

**AWS CLI**
```bash
# macOS with Homebrew
brew install awscli

# Windows with MSI
# Download from: https://aws.amazon.com/cli/

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

#### 2. VS Code Extensions

Install these extensions in VS Code for optimal development:

1. **Hashicorp Terraform**
   - Provides syntax highlighting, autocomplete, and validation for Terraform files
   - Extension ID: `hashicorp.terraform`

2. **Hashicorp HCL**
   - Language support for HCL configuration files
   - Extension ID: `hashicorp.hcl`

3. **AWS Toolkit**
   - Integrated AWS services in VS Code
   - Extension ID: `AmazonWebServices.aws-toolkit-vscode`

**Quick install via command line:**
```bash
code --install-extension hashicorp.terraform
code --install-extension hashicorp.hcl
code --install-extension AmazonWebServices.aws-toolkit-vscode
```

### Configuration

#### AWS Toolkit Setup

1. Open AWS Toolkit in VS Code (Ctrl+Shift+P → "AWS: Sign in to AWS")
2. Choose your authentication method:
   - **IAM Identity Center** (Recommended for AWS organizations)
   - **IAM Credentials** (Access Key & Secret Key)
3. Select your region and profile


### Verification

Verify your setup:

```bash
# Check Terraform
terraform version

# Check AWS CLI
aws --version

# Check AWS configuration
aws configure list
```










### Important Security Note

Never commit your AWS credentials to version control. The `aws configure` command stores them securely in a local file (`~/.aws/credentials`).