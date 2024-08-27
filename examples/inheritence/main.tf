module "org_tag_policy" {
  source = "../../"

  name        = "standard-tag-policy"
  description = "Standard tag policy for our organization"

  tag_policy = {
    cost_center = {
      tag_key = "cost_center"
      enforced_for = [
        "*"
      ]
      values = ["1000", "2000", "3000"]
    }

    Owner = {
      tag_key = "Owner"
      enforced_for = [
        "*"
      ]
    }
  }

  attach_to_org = true
}

module "engineering_tag_policy" {
  source = "../../"

  name        = "standard-tag-policy"
  description = "Standard tag policy for our organization"

  tag_policy = {
    cost_center = {
      tag_key = "cost_center"
      enforced_for = [
        "*"
      ]
      values_operator = "@@append"
      values          = ["4000"] # allow engineering to use cost center 4000
    }

    Owner = {
      tag_key = "Owner"
      enforced_for = [
        "*"
      ]
      values = ["Team 1", "Team 2", "Team 3"] # require engineering to use defined teams
    }
  }

  attach_to_org = true
}
