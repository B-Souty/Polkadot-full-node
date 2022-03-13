# Polkadot infra (IAC - Terraform)

This collection of terraform manifests describe the infra needed to run a polkadot full node in AWS.

It creates a `t3.micro` instance in the `eu-west-1` region in a dedicated vpc.

## Configuration

There are two options available to customize the infrastructure. They are defined in the `variables.tf` file.

| Option name   | default          | description                                                          |
|---------------|------------------|----------------------------------------------------------------------|
| ssh-whitelist | `["1.2.3.4/32"]` | List of IP addresses/subnets allowed to connect to the node via SSH. |
| kms-key-name  |   `my-key-name`  | Name of the KMS key name to use.                                     |
