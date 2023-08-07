resource "aws_instance" "gt_ec2_1" {
  ami           = "ami-0df7a207adb9748c7"
  instance_type = "t2.micro"

  availability_zone      = "ap-southeast-1a"
  vpc_security_group_ids = [aws_security_group.gt_ec2_sg.id]

  tags = {
    Name = "Instance 1"
  }

  user_data = file("cloudinit.sh")
}


resource "aws_instance" "gt_ec2_2" {
  ami           = "ami-0df7a207adb9748c7"
  instance_type = "t2.micro"

  availability_zone      = "ap-southeast-1b"
  vpc_security_group_ids = [aws_security_group.gt_ec2_sg.id]

  tags = {
    Name = "Instance 2"
  }

  user_data = file("cloudinit.sh")
}