#Create an instance whick it will be used like a bastion host to ssh connections
#to other instances.
resource "aws_instance" "Bastion_host"
{

ami = "${var.amiServer}"
instance_type = "${var.serversType}"
count = 1
vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
key_name = "${var.ServerKeyName}"
subnet_id="${aws_subnet.public_subnet-us-west-1a.id}"
user_data = "${file(var.ServersUserDataFile)}"
associate_public_ip_address = true

tags {
    role = "bastion"
    Name = "${var.Name_Bastion_Server}"
  }
}
