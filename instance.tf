
resource "aws_instance" "Raj" {
  ami           = "ami-08718895af4dfa033"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pvt1.id       
  vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id] 
}