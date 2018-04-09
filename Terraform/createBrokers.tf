#Create count instances to be kafka servers.

resource "aws_instance" "KafkaServers"
{
associate_public_ip_address = true
ami = "${var.amiServer}"
instance_type = "${var.serversType}"
count = "${var.BrokersNodeCount}"
vpc_security_group_ids = ["${aws_security_group.public-sg.id}"]
key_name = "${var.ServerKeyName}"
subnet_id="${aws_subnet.public_subnet-us-west-1a.id}"
user_data = "${file(var.ServersUserDataFile)}"
tags {
    role = "Kafka"
    group_name = "KafkaServers"
    group_class= "Server"
    Name = "${var.Name_Kafka_Server}${count.index}"
  }
}
