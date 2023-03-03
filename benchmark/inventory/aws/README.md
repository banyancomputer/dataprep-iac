
## Provisioning and testing on AWS
To run test on AWS, do the following:
### Configure your environment
- move `env.ec2.benchmark` to `env.benchmark`
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

You should be able to SSH into the instance with the following command:
```bash
source env/env.ssh
ssh -i $EC2_PEM_PATH ec2-user@$EC2_PUBLIC_DNS
```

Finally, mount the volumes on the instance and install any dependencies:

```bash
# Set up the volumes on our Cloud instance and install git, rust, for the ec2-user
./ec2_setup.sh
```

Note, the instance configured right now with a r6g.8xlarge ~~dedicated~~ instance.
You might need to contact your AWS administrator to get access to this instance type.
See `terraform/main.tf` for more information or to configure a different instance type, and
`terraform/service/ec2.tf` to turn on or off dedicated instances.

### Running the test pipeline
```bash
# Install the benchmark on the remote instance 
./install.sh
```
You are responsible for ensuring that the `INPUT_PATH` is populated with the data you want to test. The `INPUT_PATH` is configured in `env.benchmark`.
You can use this script to populate the `INPUT_PATH` with the data you want to test:
```bash
# Generate fake files for testing. See env.benchmark for more information.
./generate.sh
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