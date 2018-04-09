variable "amiServer"{
default="ami-925144f2"
}
variable "serversType"{
default="t2.micro"
}
variable "ServerKeyName"{
default="admin_california"
}
variable "Name_Kafka_Server" {
  default = "KAFKA-"
}
variable "Name_Zookeeper_Server" {
  default = "ZOOKEEPER-"
}
variable "ServersUserDataFile"{
default="userDataKafka"
}
variable "Name_Bastion_Server" {
  default = "Bastion"
}
variable "BrokersNodeCount"{
  default = 2
}
variable "ZookeeperNodeCount"{
  default = 2
}


variable "public_subnet_availabilityzone_a"{
default="us-west-1a"
}
variable "public_subnet_availabilityzone_b"{
default="us-west-1b"
}

variable "cidr_block_vpc"{
  default = "10.0.0.0/16"
}
variable "cidr_block_public"{
  default = "10.0.10.0/27"
}

variable "elb_regions"{
  type = "list"
  default = ["us-west-1a"]
}
variable "elb_subnets"{
  type = "list"
  default = ["10.0.10.0/27"]
}
