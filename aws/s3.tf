resource "aws_s3_bucket" "code_deploy_bucket" {
  bucket = "gt-code-deploy-bucket"
}

data "aws_iam_policy_document" "s3_iam_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.code_deploy_bucket.arn}",
      "${aws_s3_bucket.code_deploy_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.code_deploy_bucket.id
  policy = data.aws_iam_policy_document.s3_iam_policy.json
}