
key_name = "same"
vpc_cidr = "10.0.0.0/16"
vpc_name = "nezvi_vpc"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
bucket_name   = "nezvi-bucket-2026-001"
instance_type = "t3.micro"
ami_id = "ami-05d2d839d4f73aafb"

