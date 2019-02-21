

#resource "aws_iam_policy" "policy" {
#  name   = "example_policy"
  #path   = "/"
 # policy = "${data.aws_iam_policy_document.iam_assume_role_policy.json}"
#}
# resource "aws_iam_role" "test_role" {
#  name               = "stock-picture-upsert-executor"
#  assume_role_policy = "${data.aws_iam_policy_document.iam_assume_role_policy.json}"
#}
#resource "aws_iam_policy_attachment" "test_attach" {
#  name       = "test-attachment"
#  roles      = ["arn:aws:iam::807746362931:role/stock-picture-upsert-executor"]
#  assume_role_policy = "${data.aws_iam_policy_document.iam_assume_role_policy.json}"

  # policy_arn = "${aws_iam_policy.policy.arn}"
#}
resource "aws_iam_role" "lambda_role" {
  name = "${var.role_name}"
  #assume_role_policy = "${data.aws_iam_policy_document.iam_assume_role_policy.json}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${var.bucket_arn}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.bucket_name}"

  lambda_function {
    lambda_function_arn = "${var.lambda_arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "/"
    filter_suffix       = ".jpg"
  }
}

