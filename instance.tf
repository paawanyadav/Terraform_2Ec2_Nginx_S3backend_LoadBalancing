terraform {
  backend "s3" {
    bucket = "automate-ec2"
    key    = "bootcamp/ec2/terraform.tfstate"
    region = "us-east-1"
    #      dynamodb_table       = "terraform-lock"
  }
}

# Now here we are creating Ec2 instance for our Nginx

resource "aws_instance" "EC2Terraform" {
  ami                    = var.ami
  instance_type          = var.ins_type
  key_name               = "LEMPAWS"
  vpc_security_group_ids = ["${aws_security_group.Security_TF.id}"]
  subnet_id              = aws_subnet.Subnet_1.id
  tags = {
    Name = "Fantastic_instance"
  }
  user_data = file("${path.module}/script.sh")
}


resource "aws_instance" "EC2Terraform_1" {
  ami                    = var.ami
  instance_type          = var.ins_type
  key_name               = "LEMPAWS"
  vpc_security_group_ids = ["${aws_security_group.Security_TF.id}"]
  subnet_id              = aws_subnet.Subnet_2.id
  tags = {
    Name = "Fantastic_instance2"
  }
  user_data = file("${path.module}/script.sh")
}




output "address" {
  value = aws_elb.EC2Terraform.dns_name
}
