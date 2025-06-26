variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_subnet_group_name" {
  description = "Name for the DB Subnet Group"
  type        = string
  default     = "my-db-subnet-group"
}

variable "db_username" {
  description = "Root username for the MySQL Database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Root password for the MySQL Database"
  type        = string
  sensitive   = true
  default     = "adminadmin"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}
