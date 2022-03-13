output "instance_ip_addr" {
  value = aws_instance.polkadot-server.public_dns
}
