resource "aws_security_group" "public-sg"
{
name="public-security-group"
description="Security group for publicly accessible instances"
vpc_id="${aws_vpc.kafkaVpc.id}"
tags {
  Name = "public-sg"
}
}

#bastion
resource "aws_security_group" "bastion_sg"
{
  name = "bastion-security-group"
  vpc_id = "${aws_vpc.kafkaVpc.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "bastion_sg"
  }
}
#public rules
resource "aws_security_group_rule" "allow-access-ssh"
{
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"

  security_group_id = "${aws_security_group.public-sg.id}"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"

}

resource "aws_security_group_rule" "allow-all-http"
{
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  #cidr_blocks     = ["0.0.0.0/0"]
  source_security_group_id = "${aws_security_group.elb-main-sgdefault.id}"

  security_group_id = "${aws_security_group.public-sg.id}"

}
resource "aws_security_group_rule" "allow-all-zookeeper"
{
  type            = "ingress"
  from_port       = 2888
  to_port         = 2888
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.public-sg.id}"
  security_group_id = "${aws_security_group.public-sg.id}"

}
resource "aws_security_group_rule" "allow-all-zookeeper-leader"
{
  type            = "ingress"
  from_port       = 3888
  to_port         = 3888
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.public-sg.id}"
  security_group_id = "${aws_security_group.public-sg.id}"

}

resource "aws_security_group_rule" "allow-all-zookeeper-service-discovery"
{
  type            = "ingress"
  from_port       = 2181
  to_port         = 2181
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.public-sg.id}"

  security_group_id = "${aws_security_group.public-sg.id}"

}

resource "aws_security_group_rule" "allow-all-kafka-node"
{
  type            = "ingress"
  from_port       = 9091
  to_port         = 9091
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.public-sg.id}"
  security_group_id = "${aws_security_group.public-sg.id}"

}
resource "aws_security_group_rule" "allow-all-kafka-node_2"
{
  type            = "ingress"
  from_port       = 9092
  to_port         = 9092
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.public-sg.id}"
  security_group_id = "${aws_security_group.public-sg.id}"

}


resource "aws_security_group_rule" "allow-all-outbound"
{
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.public-sg.id}"

}



#elastic_load_balancer security group
resource "aws_security_group" "elb-main-sgdefault" {
  name        = "elb-main-sgdefault"
  description = "Used for the ELBs"
  vpc_id      = "${aws_vpc.kafkaVpc.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH access no configured, only bastion.
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  #Kafka access
  ingress {
    from_port   = 9091
    to_port     = 9091
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #zookeeper client port
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "elb-main-sgdefault"
  }
}
