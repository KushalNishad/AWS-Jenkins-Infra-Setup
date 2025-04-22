# bucket_name = "nishadawsbucket"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-jenkins"
cidr_private_subnet  = ["10.0.1.0/24", "10.0.3.0/24"]
cidr_public_subnet   = ["10.0.2.0/24", "10.0.4.0/24"]
us_availability_zone = ["us-east-1a", "us-east-1b"]

ec2_ami_id = "ami-084568db4383264d4"

# Generate keypair with command <ssh-keygen -t rsa>
# Public key gets appeneded in .ssh/auth_keys file inside the instance.