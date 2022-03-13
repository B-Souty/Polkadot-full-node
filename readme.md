# POC - Polkadot full node on AWS

## :warning: **_WARNING:_**  Do not use this code to deploy a production polkadot node. :warning:

This repo is a proof of concept to deploy a polkadot full node behind a nginx proxy on AWS.

It uses Terraform to deploy the required infra in AWS and ansible to deploy the polkadot full node and a nginx proxy in docker.

## Usage

clone this repository to your machine and navigate into it.

```
git clone https://github.com/B-Souty/Polkadot-full-node.git
cd Polkadot-full-node
```

Navigate to the terraform directory, update the variables in `variables.tf` then run the script (you need to init terraform before the first run).

```
cd terraform/Polkadot

terraform init # only the first time
terraform apply # review the plan and apply by typing yes
```

Once the infrastructur is up, you then simply need to run the ansible playbook. Write down the ip address of the instance that was created, you will need it later on to access the node.

Go back to the root of this repository then into the ansible directory.

```
cd ../..
cd ansible
```

*Optional: You may want to run the ansible-inventory script first to check that your new instance is found by ansible.*

```
ansible-inventory -i inventory/polkadot_full_node.aws_ec2.yml --list
```

Execute the playbook.

```
ansible-playbook -i inventory/polkadot_full_node.aws_ec2.yml polkadot_full_node.yml -v
```

You should now have a polkadot full node running on EC2 and accessible via wss.

Because this poc is using a self-signed certificate, you need to whitelist it on your browser before the next step. On your browser, navigate to `https://EC2_INSTANCE_IP_ADDRESS`, you will see a security warning, you need to accept the risk to continue. When you see a websocket error message you can move on to the next step.

Finally,go to https://polkadot.js.org/apps/ and click on the logo in the top left corner. Select the `Development` submenu and in custom endpoint enter `wss://EC2_INSTANCE_IP_ADDRESS:443`. Click on switch and the UI you show the state of the blockchain synced on your node

### Delete the polkadot node

Once you're done with testing the node you can get rid of the whole infrastructure by destroying the terraform resources.

```
cd terraform/Polkadot # from the root of the repository
terraform destroy # type yes after reviewing the plan
```

## Credentials

You will need access to an AWS account to be able to run the terraform script and ansible playbook. 

This can be handled several way (c.f. [terraform doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration), [ansible doc](https://docs.ansible.com/ansible/2.5/scenario_guides/guide_aws.html#authentication))

I personally use [aws-vault](https://github.com/99designs/aws-vault) with an IAM role setup in AWS.
