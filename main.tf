locals {
  tag_policy_content = {
    tags = {
      for tag_name, tag in var.tag_policy :
      tag_name => merge(
        {
          tag_key = merge(
            try(tag.enforced_for_operators_allowed_for_child_policies, null) != null ? {
              "@@operators_allowed_for_child_policies" = tag.enforced_for_operators_allowed_for_child_policies
            } : {},
            {
              coalesce(tag.tag_key_operator, "@@assign") = tag.tag_key
            }
          )
        },
        try(tag.values, null) != null ? {
          tag_value = merge(
            try(tag.values_operators_allowed_for_child_policies, null) != null ? {
              "@@operators_allowed_for_child_policies" = tag.values_operators_allowed_for_child_policies
            } : {},
            {
              coalesce(tag.values_operator, "@@assign") = tag.values
            }
          )
        } : {},
        try(tag.enforced_for, null) != null ? {
          enforced_for = merge(
            try(tag.enforced_for_operators_allowed_for_child_policies, null) != null ? {
              "@@operators_allowed_for_child_policies" = tag.enforced_for_operators_allowed_for_child_policies
            } : {},
            {
              coalesce(tag.enforced_for_operator, "@@assign") = tag.enforced_for
            }
          )
        } : {}
      )
    }
  }
}

data "aws_organizations_organization" "org" {}

resource "aws_organizations_policy" "this" {
  name        = var.name
  content     = jsonencode(local.tag_policy_content)
  description = var.description
  tags        = var.tags
  type        = "TAG_POLICY"
}

resource "aws_organizations_policy_attachment" "tag_policy_attachment" {
  for_each = toset(var.attach_ous)

  policy_id = aws_organizations_policy.this.id
  target_id = each.value
}

resource "aws_organizations_policy_attachment" "tag_policy_attachment_org" {
  count = var.attach_to_org ? 1 : 0

  policy_id = aws_organizations_policy.this.id
  target_id = data.aws_organizations_organization.org.id
}
