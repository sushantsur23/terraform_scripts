provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    count = 1  # Creates 5 instances

    ami = "ami-0360c520857e3138f"  # Specify an appropriate AMI ID from EC2 instance creation page
    instance_type = "t2.micro"
    subnet_id = "subnet-0932cac26582bf62a"
    key_name = "mykeypair"

    tags = {
    Name     = "web-server-${count.index + 1}"
    Environment = "development"
    Project     = "my-project"
    InstanceId  = count.index + 1
  }
  
}
