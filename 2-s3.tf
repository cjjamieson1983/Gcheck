resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "jenkins-bucket-"
  force_destroy = true

  tags = {
    Name = "G-Check Bucket"
  }
}

resource "aws_s3_bucket_versioning" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "Armageddonrepojpg" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/Armageddonrepo.jpg"
  source       = "${path.module}/ArmageddonRepo.jpg"
  etag         = filemd5("${path.module}/ArmageddonRepo.jpg")
  content_type = "image/jpeg"
}

resource "aws_s3_object" "armageddonrepomd" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/Armageddonrepo.md"
  source       = "${path.module}/ArmageddonRepo.md"
  etag         = filemd5("${path.module}/ArmageddonRepo.md")
  content_type = "text/markdown"
}

resource "aws_s3_object" "gcheckss1" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/gcheckss1.jpg"
  source       = "${path.module}/gcheckss1.jpg"
  etag         = filemd5("${path.module}/gcheckss1.jpg")
  content_type = "image/jpeg"
}

resource "aws_s3_object" "gcheckss2" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/gcheckss2.jpg"
  source       = "${path.module}/gcheckss2.jpg"
  etag         = filemd5("${path.module}/gcheckss2.jpg")
  content_type = "image/jpeg"
}

resource "aws_s3_object" "gcheckss3" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/gcheckss3.jpg"
  source       = "${path.module}/gcheckss3.jpg"
  etag         = filemd5("${path.module}/gcheckss3.jpg")
  content_type = "image/jpeg"
}
resource "aws_s3_object" "webhook3" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/webhook3"
  source       = "${path.module}/webhook3"
  etag         = filemd5("${path.module}/webhook3")
  content_type = "image/jpeg"
}
resource "aws_s3_object" "webhook2" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/webhook2"
  source       = "${path.module}/webhook2"
  etag         = filemd5("${path.module}/webhook2")
  content_type = "image/jpeg"
}
resource "aws_s3_object" "webhook1" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/webhook1.jpg"
  source       = "${path.module}/webhook1.jpg"
  etag         = filemd5("${path.module}/webhook1.jpg")
  content_type = "image/jpeg"
}
resource "aws_s3_object" "s3jpg" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "gcheck/s3.jpg"
  source       = "${path.module}/s3.jpg"
  etag         = filemd5("${path.module}/s3.jpg")
  content_type = "image/jpeg"
}
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.frontend.id

  depends_on = [aws_s3_bucket_public_access_block.frontend]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadObjects"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend.arn}/*"
      }
    ]
  })
}