# AWS
AWS provides a selection of on-demand dedicated servers we can use for testing.

## Instance Architecture
- We use a single Ec2 instance for running the benchmark.
- We use a single EBS volume for storing the data we want to test.
- We use a single EBS volume for storing the outputs of `dataprep pack`.
- We use a single EBS volume for storing the outputs of `dataprep unpack`.
- All other storage is on the instance itself.

## Configuring the instance
We use terraform for provisioning and managing the AWS infrastructure.
See `terraform/main.tf` for more information configuring the instance. You should be able to configure:
- The instance
  - Type
  - Tenancy
  - Volume
  - etc.
- The volumes
  - Type
  - Size (individually)
  - etc.
Be sure to commit any changes you make to `terraform/main.tf` to the repository, so they can cross-referenced with results.

## Provisioning the instance
- Make sure you have terraform installed
- Make sure you have the AWS CLI installed
- Make sure you have the AWS CLI configured with proper AWS credentials
- Then, set up the instance with the following commands:
```bash
# Move to the terraform directory
cd terraform
```
```bash
# Initialize terraform (if you haven't already)
terraform init
```
```bash
# Plan the infrastructure
terraform plan
```
```bash
# Deploy the infrastructure
terraform apply
```
Terraform should:
- save ssh keys on your local machine
- populate a `env.ssh` file with the information you need to SSH into the instance
- populate `host` with the inventory of the instance (used by ansible)
For example:
```bash
# Navigate to `inventory/aws`
cd ..
# Source the environment variables
source env.ssh
# SSH into the instance
ssh -i $EC2_PEM_PATH ec2-user@$EC2_PUBLIC_DNS
```

## Changing the instance
You can make more changes to the instance by editing `terraform/main.tf` and running `terraform apply` again.

## Setting up the instance
Before you this instance is ready to use, you need to: 
- Install dependencies that the ec2-user will need to install tools and run the benchmark
- Mount the volumes on the instance

After appropriately configuring and moving `env/env.instance.aws`, you can do this with the following commands:
```bash
# Return to the root of the `benchmark` directory
cd ../../..
# Set up the instance
./scripts/setup.sh
```
You should only need to do this once, unless you destroy the EC2 instance.

### Destroying the instance 
Once you are done with the instance, you can destroy the AWS infrastructure with the following commands:
```
cd terraform
terraform destroy
```
done! :tada: 