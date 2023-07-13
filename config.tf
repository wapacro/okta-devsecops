variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-1"
}

variable "aws_linux_image_id" {
  type        = string
  description = "AMI ID for Linux-based EC2 instances"
  default     = "ami-0f8e81a3da6e2510a" # Ubuntu 22.04 LTS
}

variable "aws_windows_image_id" {
  type        = string
  description = "AMI ID for Windows-based EC2 instances"
  default     = "ami-0b0de58bd9519cc54" # Windows Server 2022
}

variable "aws_instance_type" {
  type        = string
  description = "Instance type for EC2 instances"
  default     = "t2.micro"
}
