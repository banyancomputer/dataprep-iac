# dataprep-test

Repository for testing and benchmarking Dataprep.

## Dependencies
- Python
- Ansible
- Terraform
- Git
- aws cli (configured with your credentials)

## Testing locally
To run test on your local machine, do the following:
### Configure your environment
- move `env.local.benchmark` to `env.benchmark`
- Configure your environment variables in `env.benchmark` before running the following commands. See that file for more information.

### Running the test pipeline
To run the test pipeline, run the following commands:
```bash
# Install Benchmark Dependencies on local machine at the configured path
./install.sh
```
```bash
# Run the configured benchmarks 
./benchmark.sh
```
```bash
# Check the status of a long-running benchmark
./check.sh
```
 Results should appear at `$BENCH_PATH/dataprep/target/criterion`. You can copy them to your working directory with
```bash
./result.sh
```
All test results run on this host should appear in your working directory in a folder called `local-result`.

## Provisioning and testing on AWS
To run test on AWS, do the following:
### Configure your environment
- move `env.aws.benchmark` to `env.benchmark`
- Configure your environment variables in `env.benchmark` before running the following commands. See that file for more information.
- Import AWS keys into your environment with the AWS CLI 
### Provisioning AWS infrastructure
```bash
# Move to the terraform directory
cd terraform
```
```bash
# Source your environment variables. They have important information for terraform.
source ../env/env.benchmark
```
```bash
# Initialize terraform (if you haven't already)
terraform init
```
```bash
# Deploy the infrastructure
terraform apply
```

Terraform should populate a `env/env.ssh` file to facilitate SSH access to the instance.
Terraform should populate `inventory/awshost` with the inventory of the instance.

Finally, mount the volumes on the instance and install any dependencies:

```bash
# Set up the volumes on our Cloud instance and install git, rust, etc.
./ec2_setup.sh
```

Note, the instance configured right now with a t3.medium instance. This is a good instance for testing, but it's not a good instance for benchmarking. If you want to benchmark, you should use a larger instance.
See `terraform/main.tf` for more information.

### Running the test pipeline
```bash
# Install the benchmark on the remote instance 
./install.sh
```
```bash
# Run the tests
./benchmark.sh
```
```bash
# Check the status of a long-running benchmark
./check.sh
```

You should see the results of tests in the `$BENCH_PATH/dataprep/target/criterion` directory on the remote instance.
```bash
# You can copy them to your local machine with
./result.sh
```
All test results run on this host should appear in your working directory in a folder called `local-result`.

### Destroying AWS infrastructure
```
cd terraform
terraform destroy
```
done! :tada: 