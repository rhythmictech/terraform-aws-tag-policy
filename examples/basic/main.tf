module "tag_policy" {
  source = "../../"

  name        = "standard-tag-policy"
  description = "Standard tag policy for our organization"

  tag_policy = {
    Environment = {
      tag_key = "Environment"
      enforced_for = [
        "ec2:instance",
        "s3:bucket"
      ]
      values = ["Production", "Staging", "Development"]
    }
    Project = {
      tag_key = "Project"
      enforced_for = [
        "ec2:instance",
        "s3:bucket",
        "rds:db"
      ]
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
