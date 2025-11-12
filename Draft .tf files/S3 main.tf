provider "aws" {
  region = "us-east-1"
}

# Generate random suffix for unique bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 8
}

# Create S3 bucket with unique name
resource "aws_s3_bucket" "netcore_ce" {
  bucket = "netcore-ce-${random_id.bucket_suffix.hex}"
  
  tags = {
    Name        = "netcore-ce-bucket"
    Environment = "development"
    Project     = "my-project"
  }
}

# Configure bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "netcore_ce" {
  bucket = aws_s3_bucket.netcore_ce.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure public access block
resource "aws_s3_bucket_public_access_block" "netcore_ce" {
  bucket = aws_s3_bucket.netcore_ce.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create directory/folder object inside the bucket
resource "aws_s3_object" "netcore_ce_directory" {
  bucket = aws_s3_bucket.netcore_ce.id
  key    = "necore-ce/"
}

# Output the actual bucket name
output "bucket_name" {
  value = aws_s3_bucket.netcore_ce.bucket
}