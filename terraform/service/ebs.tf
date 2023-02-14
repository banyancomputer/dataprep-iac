/* ebs.tf: Configuration and deploy of our EBS volumes */

# Our Volumes

# Our Test Set Volume
resource "aws_ebs_volume" "test_set_volume" {
  availability_zone = var.aws_availability_zone
  # We need to be able to hold var.test_set_config.count * var.test_set_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 5% to the size of the volume, and round up to the nearest GB
  size              = ceil(tonumber(var.test_set_config.size) *  tonumber(var.test_set_config.count) * 1.05)
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
  # We need to be able to hold var.test_set_config.count * var.test_set_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 5% to the size of the volume, and round up to the nearest GB
  size              = ceil(tonumber(var.test_set_config.size) * 1.05)
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
  # We need to be able to hold var.test_set_config.count * var.test_set_config.size GB of data
  # Ext4 has about 5% overhead, so we need to add 5% to the size of the volume, and round up to the nearest GB
  size              = ceil(tonumber(var.test_set_config.size) * 1.05)
  type              = var.ebs_config.type

  tags = {
    deploy_id    = var.deploy_id
    service_name = var.name
    name         = join("-", [var.name, "unpacked-volume"])
  }
}

# Oue Volume Attachments to our EC2 Instance
# Test Set Volume
resource "aws_volume_attachment" "test_set_volume_attachment" {
  device_name = var.ebs_config.test_set_device_name
  volume_id   = aws_ebs_volume.test_set_volume.id
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