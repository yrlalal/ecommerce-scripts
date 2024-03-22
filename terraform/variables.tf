variable "cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-1"
}

variable "aws_zones" {
  description = "AWS Region Zones"
  type        = any
  default     = ["us-west-1a", "us-west-1b"]
}