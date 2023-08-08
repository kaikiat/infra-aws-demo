resource "aws_instance" "gt_ec2_1" {
  ami                    = "ami-002843b0a9e09324a"
  instance_type          = "t2.micro"
  key_name               = "infra_aws_demo_1"
  subnet_id              = aws_subnet.gt_subnet_1.id
  vpc_security_group_ids = [aws_security_group.gt_ec2_sg.id]
  tags = {
    Name = "Instance-1"
  }
  user_data            = file("cloudinit.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
}


resource "aws_instance" "gt_ec2_2" {
  ami                    = "ami-002843b0a9e09324a"
  instance_type          = "t2.micro"
  key_name               = "infra_aws_demo_2"
  subnet_id              = aws_subnet.gt_subnet_2.id
  vpc_security_group_ids = [aws_security_group.gt_ec2_sg.id]
  tags = {
    Name = "Instance-2"
  }
  user_data            = file("cloudinit.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ECInstanceProfile"
  role = aws_iam_role.ec2_iam_role.name
}


resource "aws_iam_role" "ec2_iam_role" {
  name               = "EC2IamRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ec2_iam_policy_codedeploy" {
  name   = "AmazonEC2RoleforAWSCodeDeploy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws:s3:::gt-code-deploy-bucket/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.ec2_iam_policy_codedeploy.arn
}
