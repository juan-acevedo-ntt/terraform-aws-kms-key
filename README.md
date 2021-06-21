# terraform-aws-kms-key

Terraform module to provision a [KMS](https://aws.amazon.com/kms/) key with alias.

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Credits

- Based on [terraform-aws-kms-key by "Cloud Posse"](https://github.com/cloudposse/terraform-aws-kms-key)
- Includes [unaccepted PR code](https://github.com/cloudposse/terraform-aws-kms-key/pull/26) by @alexjurkiewicz

## Usage

Example:

```hcl
module "kms_key" {
  source = "../../"

  description             = "Test KMS key"
  deletion_window_in_days = 7
  enable_key_rotation     = false
  alias = "testkeyjja"
  tags = {
    ntt_monitoring  = "1"
    ntt_owner       = "Juanje"
  }

}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | The display name of the alias. | `string` | n/a | yes |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `10` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Parameter Store KMS master key"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid KMS policy JSON document. Note that if the policy document is not<br>specific enough (but still valid), Terraform may view the policy as<br>constantly changing in a terraform plan. In this case, please make sure you<br>use the verbose/specific version of the policy. This variable takes<br>precedence over other 'policy\_*' variables. | `string` | `""` | no |
| <a name="input_policy_extra_statements"></a> [policy\_extra\_statements](#input\_policy\_extra\_statements) | A list of additional IAM policy statements to attach to the key policy.<br>These statements should be in JSON (string) format.<br>This variable is ignored if the 'policy' variable is set. | `list(string)` | `[]` | no |
| <a name="input_policy_key_admins"></a> [policy\_key\_admins](#input\_policy\_key\_admins) | A list of AWS principals allowed to administer this key. You can specify<br>ARNs of IAM users/roles, and AWS account IDs.<br>If you do not provide any value for this variable, access will be granted to<br>the entire account. If you do not want any principal to have this access,<br>specify [].<br>This variable is ignored if the 'policy' variable is set. | `list(string)` | `null` | no |
| <a name="input_policy_key_aws_services"></a> [policy\_key\_aws\_services](#input\_policy\_key\_aws\_services) | A list of AWS services allowed to use this key.<br>This variable is ignored if the 'policy' variable is set. | `list(string)` | `[]` | no |
| <a name="input_policy_key_grantors"></a> [policy\_key\_grantors](#input\_policy\_key\_grantors) | A list of AWS principals allowed to grant use of this key to AWS resources.<br>You can specify ARNs of IAM users/roles, and AWS account IDs.<br>If you do not provide any value for this variable, access will be granted to<br>the entire account. If you do not want any principal to have this access,<br>specify [].<br>This variable is ignored if the 'policy' variable is set. | `list(string)` | `null` | no |
| <a name="input_policy_key_users"></a> [policy\_key\_users](#input\_policy\_key\_users) | A list of AWS principals allowed to use this key for cryptographic<br>operations. You can specify ARNs of IAM users/roles, and AWS account IDs.<br>If you do not provide any value for this variable, access will be granted to<br>the entire account. If you do not want any principal to have this access,<br>specify [].<br>This variable is ignored if the 'policy' variable is set. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags associated with the resources. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_arn"></a> [alias\_arn](#output\_alias\_arn) | Alias ARN |
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | Alias name |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | Key ARN |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | Key ID |

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
