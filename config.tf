variable "okta_org" {
  type        = string
  description = "Okta Organization Name"
}

variable "okta_url" {
  type        = string
  description = "Okta Base URL (okta.com or oktapreview.com)"
  default     = "oktapreview.com"
}

variable "okta_key" {
  type        = string
  description = "Okta API Key"
}

variable "opa_key" {
  type        = string
  description = "Okta Privileged Access API Key"
}

variable "opa_secret" {
  type        = string
  description = "Okta Privileged Access API Secret"
}

variable "opa_team" {
  type        = string
  description = "Okta Privileged Access Team Name"
}

variable "opa_host" {
  type        = string
  description = "Okta Privileged Access API Host"
  default     = ""
}

variable "opa_k8s_group" {
  type        = string
  description = "Okta Privileged Access group name for K8s access"
  default     = "everyone"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-central-2"
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
  default     = "t3.micro"
}
