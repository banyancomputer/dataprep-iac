/* ebs.tf: Configuration and deploy of our EBS volumes */

# Our Volumes

# Our Test Set Volume
resource "aws_ebs_volume" "input_volume" {
  availability_zone = var.aws_availability_zone
  size              = var.ebs_config.input_volume_size
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
  size              = var.ebs_config.packed_volume_size
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
  size              = var.ebs_config.unpacked_volume_size
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