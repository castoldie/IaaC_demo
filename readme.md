hi! castoldie here; this is a demo of how to setup a basic IaC environment using:

  - terraform to provision the resources our infra will
    work on (IaC: Infrastructure as Code)
  - ansible to configure the instances(VMs) from the aforementioend
    resources (the so called "configuration management")
  - kubernetes to orchestrate these 3 machines that we'll use to make a nginx
    web server available to the public

first step: IaC, Terraform:

  1 install terraform:

    since i'm on apple M1 the procedure will be a tad bit different from what you
    would find on the official [documentation](https://gist.github.com/straubt1/033e9bbe76005c354a458868f914d2de)

  2 write terraform code (in a file witg .tf extension) to provision these
  resources on aws (my choice, feel free to use Azure or GCP)

      - VPC
      - Subnet
      - Security group to allow the ingress on port 22(ssh) and 80(http)
      - 3x ec2 instances

    see the [instance_prov.tf](tf/resources_prov.tf) file for reference, i included comments to explain
    steps and sections

    once done i initialize the backend by going

      cd tf/ ; terraform init

    then to apply my .tf configuration

      terraform apply

    this message will communicate everything went well

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

    enter yes if you're satisfied, and your resources are now provisioned!


second step: Ansible

  1 install ansible, which is alot easier than terraform

    pip install ansible

    if in your case the above command didn't run you might want to use pipx
    pkg mgr instead

  2 write an Ansible playbook(.yml, to not be confused with k8s manifest which
  have .yaml extension) that will perform the following actions on the
  provisioned instances

    - update pkg index
    - install docker
    - install k8s

    see config_mgmt.yml with relative comments to see how i did it

third step: K8S
