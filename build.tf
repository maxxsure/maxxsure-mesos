provider "aws" {
  region = "us-east-1"
}
##############
### State ####
##############
terraform {
  required_version = ">= 0.9.3"
  backend "s3" {
    bucket = "maxxsure-terraform-state"
    key    = "terraform/customers/maxxsure/provider/mesos/remotestate/ci-instances.tfstate"
    region = "us-east-1"
  }
}

module "mesos" {
  source = "github.com/maxxsure/tfm-mesos"

  # cluster
  cluster_name   = "maxxscan"
  region         = "us-east-1"
  network_number = 42

  #zookeeper
  zookeeper_ami          = "ami-8c1be5f6"
  instance_type_zookeeer = "m3.medium"
  zookeeper_capacity     = "3"

  #mesos master
  mesos_master_ami     = "ami-8c1be5f6"
  instance_type_master = "m3.medium"
  master_capacity      = "1"

  #mesos agent
  mesos_agent_ami     = "ami-8c1be5f6"
  instance_type_agent = "m3.medium"
  agent_min_capacity  = "2"

  # access related
  aws_key_name = "${var.aws_key_name}"

  # dns related
  route_zone_id = "Z1VKFREO8JNOY5"
  fqdn          = "maxxsure.com"

  #auto scale
  scale_up_threshold   = "90"
  scale_down_threshold = "80"
  mem_resource         = "15"
  cpu_resource         = "8"

  tag_product = "maxxscan_cluster"
  tag_purpose = "dev"
}
