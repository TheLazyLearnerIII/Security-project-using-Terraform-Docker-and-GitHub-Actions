# Custom VPC

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = "main"
    }
}
# Private subnet for VPC

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr

    tags = {
      Name = "Main"
    }
}
# Security group rule egress rule for outbound traffic only

resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    description = "Allow only outbound traffic"
    vpc_id = aws_vpc.main.id

    egress = {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_block = ["0.0.0.0/0"]
    }
  }
# EC2 Instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type

    # Attaching custom subnet
    subnet_id = aws_subnet.main.id
    # Attaching security group with least-privilage rule
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    # Attaching IAM instance profile so that instance can use SSM read-only permissions
    iam_instance_profile = aws_iam_instance_profile.epm_profile.name

    tags = {
      Name = var.instance_name
      Environment = "Dev"
      Project = "Security_Project_1"
    }
}
# IAM role and creating role for EC2 instance & using attached policy with least privilege (read-only or scoped permissions)
# Create IAM role

resource "aws_iam_instance_profile" "epm_profile" {
  name = "epm_profile"
  role = aws_iam_role.ssm_read_role.name
}
resource "aws_iam_role" "ssm_read_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name = "ssm_read_only_policy"
  }
}
resource "aws_iam_role_policy_attachment" "ssm_read_policy_attachement" {
  role = aws_iam_role.ssm_read_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess" 
}
