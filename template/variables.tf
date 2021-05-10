variable "access_key" {
  type = string
  default = "default"
}

variable "secret_key" {
  type = string
  default = "default"
}

variable "aws_region" {
  type = string
  default = "ap-northeast-2"
}

variable "iam_user_name" {
  type = string
  default = "hakyum-registration-user"
}

variable "custom_policy_name" {
  type = string
  default = "hakyum-registration-policy"
}

variable "iam_role_name" {
  type = string
  default = "hakyum-registration-role"
}

variable "custom_policy_json" {
  description = "IAM Policy to be attached to user"  
  default = [
        {
            "Effect": "Allow",
            "Action": [
                "kms:GetKeyRotationStatus",
                "kms:ListResourceTags",
                "elasticfilesystem:ListTagsForResource",
                "support:DescribeTrustedAdvisorCheckResult",
                "support:DescribeTrustedAdvisorChecks"
            ],
            "Resource": "*"
        }
    ]
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to user"  
  default = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}

variable "role_relationship_policy_arn" {
  description = "Role Trust RelationShip Policy to be attached to role"  
  default = [
    "arn:aws:iam::611495371442:role/CrossAccountManagementRole",
    "arn:aws:iam::611495371442:role/CX-PROD-EKS-NODEGROUP-NodeInstanceRole-1HYC11PY1OT07"
  ]
}