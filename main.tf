resource "aws_kms_key" "default" {
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  policy                   = var.policy != "" ? var.policy : local.default_policy
  tags                     = var.tags
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  # TODO:
  # policy = ...
}

resource "aws_kms_alias" "default" {
  name          = format("alias/%s", var.alias)
  target_key_id = join("", aws_kms_key.default.*.id)
}


locals {
  # Set default of "all of this account" for policy groups
  policy_key_admins   = var.policy_key_admins != null ? var.policy_key_admins : ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  policy_key_users    = var.policy_key_users != null ? var.policy_key_users : ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  policy_key_grantors = var.policy_key_grantors != null ? var.policy_key_grantors : ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  }

data "aws_caller_identity" "current" {}

# This is modelled off of the following example key policy:
# https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-example
locals {
  default_policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      length(local.policy_key_admins) == 0 ? [] : [{
        Sid    = "Allow access for Key Administrators"
        Effect = "Allow"
        Action = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ]
        Principal = {
          AWS = local.policy_key_admins
        }
        Resource = "*"
      }],
      length(local.policy_key_users) == 0 ? [] : [{
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Principal = {
          AWS = local.policy_key_users
        }
        Resource = "*"
      }],
      length(var.policy_key_aws_services) == 0 ? [] : [{
        Sid    = "AWS service usage"
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Principal = {
          Service = var.policy_key_aws_services
        }
        Resource = "*"
      }],
      length(local.policy_key_grantors) == 0 ? [] : [{
        Sid    = "Allow attachment of persistent resources"
        Effect = "Allow"
        Action = [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ]
        Principal = {
          AWS = local.policy_key_grantors
        }
        Resource = "*"
      }],
      var.policy_extra_statements,
    )
  })
}