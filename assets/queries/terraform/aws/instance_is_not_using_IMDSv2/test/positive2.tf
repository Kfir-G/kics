resource "aws_instance" "positive2" {
  ami           = "ami-0c94855ba95c71c99" # This is an example Amazon Linux 2 AMI ID; replace with the desired AMI ID for your region
  instance_type = "t2.micro"

  metadata_options {
    
  }
}