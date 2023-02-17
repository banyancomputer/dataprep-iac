/* ebs.tf: Configuration and deploy of our EBS volumes */

# Our Volumes

# Our Test Set Volume
resource "aws_ebs_volume" "input_volume" {
  availability_zone = var.aws_availability_zone
  # We need to be able to hold var.input_config.count * var.input_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 10% to the size of the volume, and round up to the nearest GB
  # If the value is less than 125 Gb, set to 125 Gb. That's the minimum size for an EBS volume
  size              = max(ceil(tonumber(var.input_config.total_size) * 1.1), 125)
  type              = var.ebs_config.type

  tags = {
    deploy_id    = var.deploy_id
    service_name = var.name
    name         = join("-", [var.name, "test-set-volume"])
  }
}
# Our Packed Volume
resource "aws_ebs_volume" "packed_volume" {
  availability_zone = var.aws_availability_zone
  # We need to be able to hold var.input_config.count * var.input_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 15% to the size of the volume, and round up to the nearest GB
  # If the value is less than 125 Gb, set to 125 Gb. That's the minimum size for an EBS volume
  size              = max(ceil(tonumber(var.input_config.size) * 1.15), 125)
  type              = var.ebs_config.type

  tags = {
    deploy_id    = var.deploy_id
    service_name = var.name
    name         = join("-", [var.name, "packed-volume"])
  }
}
# Our Unpacked Volume
resource "aws_ebs_volume" "unpacked_volume" {
  availability_zone = var.aws_availability_zone
  # We need to be able to hold var.input_config.count * var.input_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 10% to the size of the volume, and round up to the nearest GB
  # If the value is less than 125 Gb, set to 125 Gb. That's the minimum size for an EBS volume
  size              = max(ceil(tonumber(var.input_config.size) * 1.1), 125)
  type              = var.ebs_config.type

  tags = {
    deploy_id    = var.deploy_id
    service_name = var.name
    name         = join("-", [var.name, "unpacked-volume"])
  }
}

# Our Volume Attachments to our EC2 Instance
# Test Set Volume
resource "aws_volume_attachment" "input_volume_attachment" {
  device_name = var.ebs_config.input_device_name
  volume_id   = aws_ebs_volume.input_volume.id
  instance_id = aws_instance.ec2.id
}
# Packed Volume
resource "aws_volume_attachment" "packed_volume_attachment" {
  device_name = var.ebs_config.packed_device_name
  volume_id   = aws_ebs_volume.packed_volume.id
  instance_id = aws_instance.ec2.id
}
# Unpacked Volume
resource "aws_volume_attachment" "unpacked_volume_attachment" {
  device_name = var.ebs_config.unpacked_device_name
  volume_id   = aws_ebs_volume.unpacked_volume.id
  instance_id = aws_instance.ec2.id
}