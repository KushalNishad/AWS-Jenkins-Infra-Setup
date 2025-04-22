output "dev_proj_jenkins_vpc_id" {
  value = aws_vpc.proj_jenkins_us_east_1.id
}

output "dev_proj_jenkins_public_subnets" {
  value = aws_subnet.proj_jenkins_public_subnets.*.id
}