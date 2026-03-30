terraform {
  backend "s3" {
    bucket         = "nezvi-bucket-2026-001"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}