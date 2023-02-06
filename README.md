# dataprep-test

Repository for testing and benchmarking Dataprep.

## Dependencies
- Python
- Ansible
- Terraform
- Git
- Rust (Cargo, Rustup, +nightly toolchain)
- aws cli (configured with your credentials)

## Testing locally
To run test on your local machine, do the following:
### Configure your environment
- move `.env-local` to `.env`
- Configure your environment variables in `.env` before running the following commands. See `.env` for more information.

### Running the test pipeline
To run the test pipeline, run the following commands:
```bash
# You might have to run this as sudo!
# Install Test Dependencies on local machine at the configured path
./install.sh
```
```bash
# Populate the test set with data at the configured path
./populate.sh
```
```bash
# Run the tests and store the results and manifests at the configured paths
./run.sh
```
You should see the results of tests in the $RESULTS_PATH directory.
You can copy them to this directory with
```bash
./result.sh
```
All test results run on this host should appear in your working directory in a folder called `local-result`.
Files are named according to <test_parameters>-<test_timestamp>.txt

You should be able to run `./populate.sh` to repopulate the test set with data.
You should be able to run `./run.sh` to run the tests again on the same data.
You should be able to run `./result.sh` to copy the results to your local machine. This "shouldn't" overwrite any existing results, but it might.

## Provisioning and testing on AWS
To run test on AWS, do the following:
### Configure your environment
- move `.env-aws` to `.env`
- That should be it!
### Provisioning AWS infrastructure
Import your AWS credentials into your environment. Then:
```
cd terraform
terraform init
terraform apply
```
Terraform should populate a `.env-ssh` file to facilitate SSH access to the instance.
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
# Install Test Dependencies on Cloud instance (dataprep + aux scripts)
./install.sh
```
```bash
# Populate the test set with data
./populate.sh
```
```bash
# Run the tests
./run.sh
```
You should see the results of tests in the $RESULTS_PATH directory. You can copy them to your local machine with
```bash
./result.sh
```
All test results run on this host should appear in your working directory in a folder called `local-result`.
Files are named according to <test_parameters>-<test_timestamp>.txt

You should be able to run `./populate.sh` to repopulate the test set with data.
You should be able to run `./run.sh` to run the tests again on the same data.
You should be able to run `./result.sh` to copy the results to your local machine. This "shouldn't" overwrite any existing results, but it might.

### Destroying AWS infrastructure
```
cd terraform
terraform destroy
```
done! :tada: 