# Polkadot full node Ansible playbook

This ansible playbook will deploy a Polkadot full node behind a nginx proxy in Docker.

The full node will be exposed on port 433 (wss) using a self-signed certificate.

## Usage

This ansible playbook assume you have an ec2 instance running in AWS bearing the tag `role: polkadot-full-node`.

Simply run the playbook passing it the inventory file and ansible will install docker and deploy a couple containers (polkdato full node and nginx proxy) on the targeted instance.

```
ansible-playbook -i inventory/polkadot_full_node.aws_ec2.yml polkadot_full_node.yml -v 
```
