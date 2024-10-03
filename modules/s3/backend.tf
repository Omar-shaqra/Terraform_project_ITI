terraform {
  backend "s3" {
    encrypt = true    
    bucket = "bucket-iti-OmarShaqra"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}