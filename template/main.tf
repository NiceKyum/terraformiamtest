# Provider
provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Resources
resource "aws_iam_policy" "iamPolicy" {
  name        = var.custom_policy_name 
  description = "CloudXper Custom Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = var.custom_policy_json
  })
}

resource "aws_iam_user" "iamUser" {
  name = var.iam_user_name
  path = "/terraformWorkspace/"
}

resource "aws_iam_access_key" "iamAccessKey" {
  user = aws_iam_user.iamUser.name
}

resource "aws_iam_role" "iamRole" {
  name        = var.iam_role_name
  description = "CloudXper Role"  
}

resource "aws_iam_user_policy_attachment" "IAM-attach-ARN" {
  user       = aws_iam_user.iamUser.name
  count      = length(var.iam_policy_arn)
  policy_arn = element(var.iam_policy_arn, count.index)
  
}

resource "aws_iam_user_policy_attachment" "IAM-attach-customPolicy" {
  user       = aws_iam_user.iamUser.name   
  policy_arn = aws_iam_policy.iamPolicy.arn
}

resource "aws_iam_role_policy_attachment" "Role-attach-ARN" {
  role       = aws_iam_role.iamRole.name
  count      = length(var.iam_policy_arn)
  policy_arn = element(var.iam_policy_arn, count.index)
}

resource "aws_iam_role_policy_attachment" "Role-attach-customPolicy" {
  role       = aws_iam_role.iamRole.name
  policy_arn = aws_iam_policy.iamPolicy.arn
}


#Outputs
output "aws_iam_accessKey" {
  value = aws_iam_access_key.iamAccessKey.id
}

output "aws_iam_secretKey" {
  value = aws_iam_access_key.iamAccessKey.ses_smtp_password_v4
}

output "aws_role_arn" {
  value = aws_iam_role.iamRole.arn
}