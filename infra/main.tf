resource "aws_s3_bucket" "s3_dev" {
  bucket = "${var.app_name}"

  tags = {
    Name        = "${var.app_name}"
    Environment = "Dev"
  }
}