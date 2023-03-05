data "aws_vpc" "selected" {
  id = var.vpc_id
}

#create private subnets resources
resource "aws_subnet" "private-subnet" {
  vpc_id = data.aws_vpc.selected.id
  for_each = var.private-subnets
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block
}

#create public subnet resource
resource "aws_subnet" "public-subnet" {
  vpc_id = data.aws_vpc.selected.id
  availability_zone = var.public-subnets["public-subnet"].availability_zone
  cidr_block = var.public-subnets["public-subnet"].cidr_block
}

#creating route table
resource "aws_route_table" "public-rt" {

    vpc_id = data.aws_vpc.selected.id
    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }

    tags = {
        Name = "My-Public-Routing-Table"
    }
}

#associate public subnet to routing table
resource "aws_route_table_association" "public-subnet-rt" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

