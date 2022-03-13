data "aws_ami" "amzn2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
    "amzn2-ami-kernel-5.10-*"]
  }

  filter {
    name = "architecture"
    values = [
    "x86_64"]
  }
}

resource "aws_instance" "polkadot-server" {

  ami           = data.aws_ami.amzn2.id 
  instance_type = "t3.micro"

  key_name = local.kms-key-name

  iam_instance_profile = aws_iam_role.polkadot-server.name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    tags = {
      Name = "polkadot-server"
    }
  }

  vpc_security_group_ids = [
    aws_security_group.polkadot-server.id
  ]
  subnet_id = aws_subnet.polkadot-poc-subnet.id
  associate_public_ip_address = true

  tags = {
    role  = "polkadot-full-node"
  }

}
