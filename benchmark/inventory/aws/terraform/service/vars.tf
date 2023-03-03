/* AWS and Deploy Config */

# AWS region
variable "aws_region" {
  description = "AWS region"
}
variable "aws_availability_zone" {
  description = "AWS availability zone"
}
# A string describing what service this is for
variable "name" {
  description = "app"
  default     = "dataprep-test"
}
# A random string to append to the end of the name
variable "deploy_id" {
  description = "What deployment ID to attach to this service and its infrastructure. Should be lowercase and alphanumeric"
}

/* Ec2 Configuration */

# The configuration for our EC2 instance
variable "ec2_config" {
  description = "Service Configuration for EC2"
  type        = map(any)
  # Set config values as strings and convert to the appropriate type.
  default     = {
    instance_type = "t3.micro" # The instance type to use for the EC2 instance
    tenancy       = "default" # The tenancy of the instance
    ami_filter    = "amzn2-ami-hvm-*-arm64-gp2"
    monitoring    = "false" # Whether to enable detailed monitoring
    volume_type   = "gp2" # The type of volume to use for the EC2 instance
    volume_size   = "20" # in GB. How big of a volume to mount on the Ec2. This is the Size needed for the AMI
  }
}

/* EBS Configuration */

# The configuration for our EBS volumes
variable "ebs_config" {
  description = "Service Configuration for EBS"
  type        = map(any)
  # Set config values as strings and convert to the appropriate type.
  default     = {
    type                 = "st1" # Throughput optimized HDD volume type
    input_device_name    = "/dev/sdf" # The device to mount the EBS volume on the EC2 instance
    packed_device_name   = "/dev/sdg" # The device to mount the EBS volume on the EC2 instance
    unpacked_device_name = "/dev/sdh" # The device to mount the EBS volume on the EC2 instance
    input_volume_size    = "100" # in GB. How big of a volume to mount on the Ec2
    packed_volume_size   = "100" # in GB. How big of a volume to mount on the Ec2
    unpacked_volume_size = "100" # in GB. How big of a volume to mount on the Ec2
  }
}


/* VPC Configuration. We need one public subnet and two private */

# Our VPC CIDR
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
# Our public subnet CIDRs
variable "public_subnet_cidr" {
  description = "A list of available public subnet CIDRs"
  type        = string
  default     = "10.0.1.0/24"
}
