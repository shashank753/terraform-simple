
resource "aws_instance" "Raj" {
  ami           = "ami-08718895af4dfa033"  # Replace with your AMI ID
  instance_type = "t2.micro"
  # availability_zone = "ap-south-1c"  # Remove or change this line
}
