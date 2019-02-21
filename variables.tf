variable bucket_arn {

    type = "string"

}

variable aws_region {

    type = "string"
    default = "us-east-1"

}

variable role_name {
    type = "string"
    default = "BucketS3TriggerLambdaRole"
}

variable lambda_arn {
    type = "string"
    default = ""
}

variable lambda_name {
    type = "string"
    default = ""
}

variable bucket_name {
    type = "string"
    default = ""
}

variable aws_profile {
    type = "string"
    default = "terraform"
}