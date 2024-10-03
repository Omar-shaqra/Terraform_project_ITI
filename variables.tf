variable "vpc_cidr" {
  description = "VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet"
  type = list(string)
}

variable "azs" {
  description = "Availabel zones"
  type = list(string)
}

variable "state_bucket_name" {
  description = "S3 bucket"
  type = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB"
  type = string
}