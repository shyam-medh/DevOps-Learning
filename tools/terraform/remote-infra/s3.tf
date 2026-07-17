resource "aws_s3_bucket" "remote_S3" {
  bucket = "remote-infra-s3-shyam"

  tags = {
    Name        = "remote-infra-s3-shyam"
  }
}