# dataprep-test

Repository for testing and benchmarking Dataprep.

## Dependencies
- Python
- Ansible
- Terraform

## Configuration

1. move '.env-example' to '.env' 
2. fill in the variables in '.env' with your own values - make sure you know what you are doing. See the comments in the file for more information.

## Testing locally
Be sure to configure your environment variables in `.env` before running the following commands.
Make sure `ANSIBLE_INVENTORY` is set to `inventory/localhost` in `.env`.
You may or may not need to run the following commands as `sudo` depending on your local environment.
```bash
# Install Test Dependencies on local machine 
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
You should see the results of tests in the $RESULTS_PATH directory.
You can copy them to this directory with
```bash
./result.sh
```
All test results run on this host should appear in your working directory in a folder called `result`.
Note, this will overwrite any previous results on your machine. Use care when running this command.
Files are named according to <test_parameters>-<test_timestamp>.txt

## Provisioning and testing on AWS
To run test on AWS, do the following:

Import your AWS credentials into your environment. Then:
```
cd terraform
terraform init
terraform apply
terraform output -json > ../aws_inventory.json
```
Look in `aws_inventory.json` for the IP address of the instance and the path of the .pem on your local machine.
Edit the contents of `inventory/awshost` to match the DNS name of the instance and the path to the .pem file.

Configure your environment variables in `.env` before running the following commands.
Make sure `ANSIBLE_INVENTORY` is set to `inventory/awshost` in `.env`.

To provision test instances on AWS, run the following (you may or may not need to run as sudo)
```bash
# Set up the volumes on our Cloud instance
./ec2_setup.sh
```
```bash
# Install Test Dependencies on Cloud instance
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
All test results run on this host should appear in your working directory in a folder called `result`.
Note, this will overwrite any previous results on your machine. Use care when running this command.
Files are named according to <test_parameters>-<test_timestamp>.txt