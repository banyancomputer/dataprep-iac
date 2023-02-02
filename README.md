# dataprep-test

Repository for testing and benchmarking Dataprep.

## Dependencies
- Python
- Ansible
- Terraform

# Testing locally

```bash
# Install dataprep on your local machine
sudo ansible-playbook -i inventory/localhost -e "install_path=~" ./ansible/dataprep.yml
```
```bash
# Populate the test set with data
sudo ansible-playbook -i inventory/localhost --extra-vars "test_set_path=~/test_set" --extra-vars "packed_path=~/packed" --extra-vars "unpacked_path=~/unpacked" --extra-vars "test_set_count=1" --extra-vars "test_set_size=1" --extra-vars "install_path=~" ./ansible/populate_tests.yml
```
TODO (amiller68) - This fails on local instance. Need to fix.
```bash
# Run the tests
sudo ansible-playbook -i inventory/localhost -e "test_set_path=~/test_set" -e "packed_path=~/packed" -e "unpacked_path=~/unpacked" -e "manifest_path=~/manifest" -e "install_path=~" ./ansible/run_tests.yml
```

# Provisioning and testing on AWS
Import your AWS credentials into your environment. Then:
```
cd terraform
terraform init
terraform apply
terraform output -json > ../aws_inventory.json
```
Look in `aws_inventory.json` for the IP address of the instance and the path of the .pem on your local machine.
Edit the contents of `inventory/awshost` to match the DNS name of the instance and the path to the .pem file.

To provision test instances on AWS, run the following: