resource "aws_security_group" "polkadot-server" {
  name        = "polkadot-server"
  description = "Allow required port to manage and use a polkadot full node server"
  vpc_id      = aws_vpc.polkadot-poc.id

  egress {
    description      = "Allow all outgoing connection"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Allow ssh only to authorized endpoints defined in variables"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.ssh-whitelist
  }

  ingress {
    description = "Allow HTTPs connection to nginx proxy"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "polkadot-server"
  }
}

resource "aws_iam_role" "polkadot-server" {
  name = "polkadot-server"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "polkadot-server"
  }
}

resource "aws_iam_instance_profile" "polkadot-server" {
  name = "polkadot-server"
  role = aws_iam_role.polkadot-server.name
}
