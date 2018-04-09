resource "aws_elb" "elb-main" {
  
  subnets = ["${aws_subnet.public_subnet-us-west-1a.id}"]
  security_groups = ["${aws_security_group.elb-main-sgdefault.id}"]
  depends_on = ["aws_internet_gateway.igw"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 8080
    lb_protocol = "http"
  }

  listener {
    instance_port = 9091
    instance_protocol = "tcp"
    lb_port = 9091
    lb_protocol = "tcp"
  }
  listener {
    instance_port = 9092
    instance_protocol = "tcp"
    lb_port = 9092
    lb_protocol = "tcp"
  }
  listener {
    instance_port = 2181
    instance_protocol = "tcp"
    lb_port = 2181
    lb_protocol = "tcp"
  }

  tags {
    Name = "elb-main"
  }
}
