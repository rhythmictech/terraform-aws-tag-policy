# terraform-aws-tag-policy
Facilitate the creation of tag policies in AWS Organizations.

[![tflint](https://github.com/rhythmictech/terraform-aws-tag-policy/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-tag-policy/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![trivy](https://github.com/rhythmictech/terraform-aws-tag-policy/workflows/trivy/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-tag-policy/actions?query=workflow%3Atrivy+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-tag-policy/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-tag-policy/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-tag-policy/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-tag-policy/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-tag-policy/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-tag-policy/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

## Example
Here's what using the module will look like
```hcl
module "example" {
  name        = "require-owner-tag"

  tag_policy = {
    Owner = {
      tag_key = "Owner"
      enforced_for = [
        "*"
      ]
    }
  }
}
```

## About
This module creates a tag policy in AWS Organizations. It can be attached to the organization or to a list of OUs. It is possible to attach multiple tag policies to an organization or OU by using this module multiple times. 

This module supports inheritance of tag policies. It uses the `@@assign` operator by default, so the effective tag policy will be the union of all tag policies attached to an organization or OU. It is possible to use the `@@append` and `@@remove` operators to modify the tag policy, as well as to define child inheritence rules. Thus, 

Rolling out a tag policy in a running environment can cause unexpected results. Be sure to test in a dedicated AWS account and roll out carefully. Consult AWS documentation:

* [Getting started with tag policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies-getting-started.html)
* [Services and resource types that support enforcement](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_supported-resources-enforcement.html)
* [Inheritance examples](https://docs.aws.amazon.com/organizations/latest/userguide/inheritance-examples.html)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.tag_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_attachment_org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_ous"></a> [attach\_ous](#input\_attach\_ous) | List of OU IDs to attach the tag policies to | `list(string)` | `[]` | no |
| <a name="input_attach_to_org"></a> [attach\_to\_org](#input\_attach\_to\_org) | Whether to attach the tag policy to the organization (set to false if you want to attach to OUs) | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the tag policy | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Moniker to apply to all resources in the module | `string` | n/a | yes |
| <a name="input_tag_policy"></a> [tag\_policy](#input\_tag\_policy) | List of tag policies to create | <pre>map(object({<br>    enforced_for                                      = optional(list(string))<br>    enforced_for_operator                             = optional(string)<br>    enforced_for_operators_allowed_for_child_policies = optional(list(string))<br>    tag_key                                           = string<br>    tag_key_operator                                  = optional(string)<br>    tag_key_operators_allowed_for_child_policies      = optional(list(string))<br>    values                                            = optional(list(string))<br>    values_operator                                   = optional(string)<br>    values_operators_allowed_for_child_policies       = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User-Defined tags | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Getting Started
This workflow has a few prerequisites which are installed through the `./bin/install-x.sh` scripts and are linked below. The install script will also work on your local machine. 

- [pre-commit](https://pre-commit.com)
- [terraform](https://terraform.io)
- [tfenv](https://github.com/tfutils/tfenv)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [trivy](https://github.com/trivy/trivy)
- [tflint](https://github.com/terraform-linters/tflint)

We use `tfenv` to manage `terraform` versions, so the version is defined in the `versions.tf` and `tfenv` installs the latest compliant version.
`pre-commit` is like a package manager for scripts that integrate with git hooks. We use them to run the rest of the tools before apply. 
`terraform-docs` creates the beautiful docs (above),  `trivy` scans for security no-nos, `tflint` scans for best practices. 
