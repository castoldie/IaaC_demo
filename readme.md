# Infrastructure as Code (IaC) Demo: Terraform, Ansible, and Kubernetes

Hello, this is Castoldie! Welcome to a comprehensive demo on how to set up a basic Infrastructure as Code (IaC) environment using the following technologies:

- **Terraform**: For provisioning the resources on which our infrastructure will operate.
- **Ansible**: For configuration management of the instances (Virtual Machines).
- **Kubernetes**: For orchestrating the machines, specifically, for deploying an Nginx web server accessible to the public.

## Step 1: Infrastructure as Code with Terraform

### 1.1 Install Terraform

For users on Apple's M1 chip, the installation procedure may differ slightly from what's in the [official documentation](https://gist.github.com/straubt1/033e9bbe76005c354a458868f914d2de).

### 1.2 Write Terraform Code

Create a Terraform configuration file with a `.tf` extension. The code will provision the following AWS resources (you can also opt for Azure or GCP):

- VPC
- Subnet
- Security group (to allow ingress on ports 22 for SSH and 80 for HTTP)
- 3x EC2 instances

Refer to the [`instance_prov.tf`](tf/resources_prov.tf) file for more details. I've included comments to explain each step and section.

To initialize the backend, execute the following commands:

```zsh
cd tf/
terraform init
```

To apply your Terraform configuration:

```zsh
terraform apply
```

You'll receive a message confirming successful execution. Enter `yes` if you're satisfied, and your resources will be provisioned!

<details>
  <summary>Click to expand</summary>
    ```zsh
    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            + create

          Terraform will perform the following actions:

            # aws_instance.IaC_instance[0] will be created
            + resource "aws_instance" "IaC_instance" {
                + ami                                  = "ami-007b48239f2f40f93"
                + arn                                  = (known after apply)
                + associate_public_ip_address          = (known after apply)
                + availability_zone                    = (known after apply)
                + cpu_core_count                       = (known after apply)
                + cpu_threads_per_core                 = (known after apply)
                + disable_api_stop                     = (known after apply)
                + disable_api_termination              = (known after apply)
                + ebs_optimized                        = (known after apply)
                + get_password_data                    = false
                + host_id                              = (known after apply)
                + host_resource_group_arn              = (known after apply)
                + iam_instance_profile                 = (known after apply)
                + id                                   = (known after apply)
                + instance_initiated_shutdown_behavior = (known after apply)
                + instance_lifecycle                   = (known after apply)
                + instance_state                       = (known after apply)
                + instance_type                        = "t2.micro"
                + ipv6_address_count                   = (known after apply)
                + ipv6_addresses                       = (known after apply)
                + key_name                             = "IaC_kp"
                + monitoring                           = (known after apply)
                + outpost_arn                          = (known after apply)
                + password_data                        = (known after apply)
                + placement_group                      = (known after apply)
                + placement_partition_number           = (known after apply)
                + primary_network_interface_id         = (known after apply)
                + private_dns                          = (known after apply)
                + private_ip                           = (known after apply)
                + public_dns                           = (known after apply)
                + public_ip                            = (known after apply)
                + secondary_private_ips                = (known after apply)
                + security_groups                      = [
                    + "SG",
                  ]
                + source_dest_check                    = true
                + spot_instance_request_id             = (known after apply)
                + subnet_id                            = (known after apply)
                + tags                                 = {
                    + "Name" = "IaC_instance-0"
                  }
                + tags_all                             = {
                    + "Name" = "IaC_instance-0"
                  }
                + tenancy                              = (known after apply)
                + user_data                            = (known after apply)
                + user_data_base64                     = (known after apply)
                + user_data_replace_on_change          = false
                + vpc_security_group_ids               = (known after apply)
              }

            # aws_instance.IaC_instance[1] will be created
            + resource "aws_instance" "IaC_instance" {
                + ami                                  = "ami-007b48239f2f40f93"
                + arn                                  = (known after apply)
                + associate_public_ip_address          = (known after apply)
                + availability_zone                    = (known after apply)
                + cpu_core_count                       = (known after apply)
                + cpu_threads_per_core                 = (known after apply)
                + disable_api_stop                     = (known after apply)
                + disable_api_termination              = (known after apply)
                + ebs_optimized                        = (known after apply)
                + get_password_data                    = false
                + host_id                              = (known after apply)
                + host_resource_group_arn              = (known after apply)
                + iam_instance_profile                 = (known after apply)
                + id                                   = (known after apply)
                + instance_initiated_shutdown_behavior = (known after apply)
                + instance_lifecycle                   = (known after apply)
                + instance_state                       = (known after apply)
                + instance_type                        = "t2.micro"
                + ipv6_address_count                   = (known after apply)
                + ipv6_addresses                       = (known after apply)
                + key_name                             = "IaC_kp"
                + monitoring                           = (known after apply)
                + outpost_arn                          = (known after apply)
                + password_data                        = (known after apply)
                + placement_group                      = (known after apply)
                + placement_partition_number           = (known after apply)
                + primary_network_interface_id         = (known after apply)
                + private_dns                          = (known after apply)
                + private_ip                           = (known after apply)
                + public_dns                           = (known after apply)
                + public_ip                            = (known after apply)
                + secondary_private_ips                = (known after apply)
                + security_groups                      = [
                    + "SG",
                  ]
                + source_dest_check                    = true
                + spot_instance_request_id             = (known after apply)
                + subnet_id                            = (known after apply)
                + tags                                 = {
                    + "Name" = "IaC_instance-1"
                  }
                + tags_all                             = {
                    + "Name" = "IaC_instance-1"
                  }
                + tenancy                              = (known after apply)
                + user_data                            = (known after apply)
                + user_data_base64                     = (known after apply)
                + user_data_replace_on_change          = false
                + vpc_security_group_ids               = (known after apply)
              }

            # aws_instance.IaC_instance[2] will be created
            + resource "aws_instance" "IaC_instance" {
                + ami                                  = "ami-007b48239f2f40f93"
                + arn                                  = (known after apply)
                + associate_public_ip_address          = (known after apply)
                + availability_zone                    = (known after apply)
                + cpu_core_count                       = (known after apply)
                + cpu_threads_per_core                 = (known after apply)
                + disable_api_stop                     = (known after apply)
                + disable_api_termination              = (known after apply)
                + ebs_optimized                        = (known after apply)
                + get_password_data                    = false
                + host_id                              = (known after apply)
                + host_resource_group_arn              = (known after apply)
                + iam_instance_profile                 = (known after apply)
                + id                                   = (known after apply)
                + instance_initiated_shutdown_behavior = (known after apply)
                + instance_lifecycle                   = (known after apply)
                + instance_state                       = (known after apply)
                + instance_type                        = "t2.micro"
                + ipv6_address_count                   = (known after apply)
                + ipv6_addresses                       = (known after apply)
                + key_name                             = "IaC_kp"
                + monitoring                           = (known after apply)
                + outpost_arn                          = (known after apply)
                + password_data                        = (known after apply)
                + placement_group                      = (known after apply)
                + placement_partition_number           = (known after apply)
                + primary_network_interface_id         = (known after apply)
                + private_dns                          = (known after apply)
                + private_ip                           = (known after apply)
                + public_dns                           = (known after apply)
                + public_ip                            = (known after apply)
                + secondary_private_ips                = (known after apply)
                + security_groups                      = [
                    + "SG",
                  ]
                + source_dest_check                    = true
                + spot_instance_request_id             = (known after apply)
                + subnet_id                            = (known after apply)
                + tags                                 = {
                    + "Name" = "IaC_instance-2"
                  }
                + tags_all                             = {
                    + "Name" = "IaC_instance-2"
                  }
                + tenancy                              = (known after apply)
                + user_data                            = (known after apply)
                + user_data_base64                     = (known after apply)
                + user_data_replace_on_change          = false
                + vpc_security_group_ids               = (known after apply)
              }

            # aws_security_group.IaC will be created
            + resource "aws_security_group" "IaC" {
                + arn                    = (known after apply)
                + description            = "Allow SSH and HTTP"
                + egress                 = [
                    + {
                        + cidr_blocks      = [
                            + "0.0.0.0/0",
                          ]
                        + description      = ""
                        + from_port        = 0
                        + ipv6_cidr_blocks = []
                        + prefix_list_ids  = []
                        + protocol         = "-1"
                        + security_groups  = []
                        + self             = false
                        + to_port          = 0
                      },
                  ]
                + id                     = (known after apply)
                + ingress                = [
                    + {
                        + cidr_blocks      = [
                            + "0.0.0.0/0",
                          ]
                        + description      = ""
                        + from_port        = 22
                        + ipv6_cidr_blocks = []
                        + prefix_list_ids  = []
                        + protocol         = "tcp"
                        + security_groups  = []
                        + self             = false
                        + to_port          = 22
                      },
                    + {
                        + cidr_blocks      = [
                            + "0.0.0.0/0",
                          ]
                        + description      = ""
                        + from_port        = 80
                        + ipv6_cidr_blocks = []
                        + prefix_list_ids  = []
                        + protocol         = "tcp"
                        + security_groups  = []
                        + self             = false
                        + to_port          = 80
                      },
                  ]
                + name                   = "SG"
                + name_prefix            = (known after apply)
                + owner_id               = (known after apply)
                + revoke_rules_on_delete = false
                + tags_all               = (known after apply)
                + vpc_id                 = (known after apply)
              }

            # aws_subnet.IaC_subnet will be created
            + resource "aws_subnet" "IaC_subnet" {
                + arn                                            = (known after apply)
                + assign_ipv6_address_on_creation                = false
                + availability_zone                              = (known after apply)
                + availability_zone_id                           = (known after apply)
                + cidr_block                                     = "10.0.1.0/24"
                + enable_dns64                                   = false
                + enable_resource_name_dns_a_record_on_launch    = false
                + enable_resource_name_dns_aaaa_record_on_launch = false
                + id                                             = (known after apply)
                + ipv6_cidr_block_association_id                 = (known after apply)
                + ipv6_native                                    = false
                + map_public_ip_on_launch                        = false
                + owner_id                                       = (known after apply)
                + private_dns_hostname_type_on_launch            = (known after apply)
                + tags                                           = {
                    + "Name" = "IaC_subnet"
                  }
                + tags_all                                       = {
                    + "Name" = "IaC_subnet"
                  }
                + vpc_id                                         = (known after apply)
              }

            # aws_vpc.IaC_vpc will be created
            + resource "aws_vpc" "IaC_vpc" {
                + arn                                  = (known after apply)
                + cidr_block                           = "10.0.0.0/16"
                + default_network_acl_id               = (known after apply)
                + default_route_table_id               = (known after apply)
                + default_security_group_id            = (known after apply)
                + dhcp_options_id                      = (known after apply)
                + enable_dns_hostnames                 = true
                + enable_dns_support                   = true
                + enable_network_address_usage_metrics = (known after apply)
                + id                                   = (known after apply)
                + instance_tenancy                     = "default"
                + ipv6_association_id                  = (known after apply)
                + ipv6_cidr_block                      = (known after apply)
                + ipv6_cidr_block_network_border_group = (known after apply)
                + main_route_table_id                  = (known after apply)
                + owner_id                             = (known after apply)
                + tags                                 = {
                    + "Name" = "IaC_vpc"
                  }
                + tags_all                             = {
                    + "Name" = "IaC_vpc"
                  }
              }

          Plan: 6 to add, 0 to change, 0 to destroy.

          Do you want to perform these actions?
            Terraform will perform the actions described above.
            Only 'yes' will be accepted to approve.

            Enter a value:
</details>

## Step 2: Configuration Management with Ansible

### 2.1 Install Ansible

Installing Ansible is simpler compared to Terraform:

```zsh
pip install ansible
```

If the above command doesn't work, you might want to use the `pipx` package manager instead.

### 2.2 Write Ansible Playbook

Create an Ansible playbook with a `.yml` extension (not to be confused with Kubernetes manifests, which use `.yaml`). The playbook should perform the following tasks on the provisioned instances:

- Update package index
- Install Docker
- Install Kubernetes

Refer to [`config_mgmt.yml`](ansible/config_mgmt.yml) for details on how I accomplished this.

## Step 3: Orchestration with Kubernetes (K8S)
