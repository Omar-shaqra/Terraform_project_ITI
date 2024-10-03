resource "aws_s3_bucket" "project_s3" {
  bucket = "bucket-iti-OmarShaqra"

  tags = {
    Name        = "Project Bucket"
    Environment = "project"
  }
}