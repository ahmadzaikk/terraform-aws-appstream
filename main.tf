provider "aws" {
  region = "us-west-2"
}
data "aws_caller_identity" "this" {}
### S3
module "s3" {
  source         = "git::https://git@github.com/ucopacme/terraform-aws-s3-bucket.git//?ref=v0.0.6"
  bucket         = join("-", [var.name, "appstream-app-settings","${var.region}","${data.aws_caller_identity.this.account_id}"])
  enabled        = true
  policy         = data.aws_iam_policy_document.s3.json
  policy_enabled = true
  sse_algorithm  = "AES256"
  tags = var.tags
  versioning_enabled = "Disabled"
}
### s3 Policy
data "aws_iam_policy_document" "s3" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = ["s3:DeleteBucket"]
    resources = [module.s3.bucket_arn]
  }
}
### IAM
resource "aws_iam_role" "appstream_role" {
  name = join("-", [var.name, "appstream_role"])

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "appstream.amazonaws.com"
      }
    }]
  })
  tags = var.tags
}

resource "aws_iam_policy" "appstream_policy" {
  name        = join("-", [var.name, "appstream_policy"])
  description = "Managed By Terraform"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        Effect = "Allow",
        Resource = [module.s3.bucket_arn, "${module.s3.bucket_arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "appstream_role_attachment" {
  role       = aws_iam_role.appstream_role.name
  policy_arn = aws_iam_policy.appstream_policy.arn
}



# Conditionally Create VPC Endpoint
resource "aws_vpc_endpoint" "appstream_vpce" {
  count             = var.enable_vpce ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.appstream.streaming"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = var.security_group_ids

  tags = var.tags
}

resource "aws_appstream_stack" "this" {
  name         = join("-", [var.name, "stack"])
  display_name = join("-", [var.name, "stack"])
  description  = join("-", [var.name, "stack"])
  dynamic "user_settings" {
    for_each = var.user_settings
    content {
      action     = user_settings.value.action
      permission = user_settings.value.permission
    }
  }
 # dynamic "access_endpoints" {
  #  for_each = var.enable_vpce ? [1] : []
   # content {
    #  endpoint_type = "STREAMING"
     # vpce_id       = aws_vpc_endpoint.appstream_vpce[0].id
    #}
  #}


 

  application_settings {
    enabled        = true
    settings_group = join("-", [var.name, "setting-group"])
  }
  tags = var.tags
}

### Fleet 
resource "aws_appstream_fleet" "this" {
  name                           = join("-", [var.name, "fleet"])
  instance_type                  = var.instance_type
  fleet_type                     = var.fleet_type
  image_name                     = var.image_name
  max_user_duration_in_seconds   = var.max_user_duration_in_seconds
  disconnect_timeout_in_seconds  = var.disconnect_timeout_in_seconds
  stream_view                    = var.stream_view
  enable_default_internet_access = var.enable_default_internet_access
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  iam_role_arn = aws_iam_role.appstream_role.arn

  compute_capacity {
    desired_instances = var.desired_instances
  }
  tags = var.tags
}

resource "aws_appstream_fleet_stack_association" "this" {
  fleet_name = aws_appstream_fleet.this.name
  stack_name = aws_appstream_stack.this.name
}

