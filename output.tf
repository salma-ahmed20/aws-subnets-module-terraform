# output file to pass resources to main module and 
# use its value in other modules

output "public_subnet_output" {
  value = aws_subnet.public-subnet

}

output "private_subnet_output" {
  value = aws_subnet.private-subnet
}