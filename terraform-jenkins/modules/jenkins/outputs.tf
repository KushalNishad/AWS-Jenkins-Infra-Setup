output "jenkins_ec2_instance_id" {
  value = aws_instance.jenkins_ec2_instance.id
}

output "dev_proj_1_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2_instance.public_ip
}