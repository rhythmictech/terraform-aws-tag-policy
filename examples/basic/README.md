# basic example

This example defines a tag policy for Environment, Project, and Owner tags. The following tag policy is produced and attached to the organization:

```
{
  "tags": {
    "Environment": {
      "enforced_for": {
        "@@assign": [
          "ec2:instance",
          "s3:bucket"
        ]
      },
      "tag_key": {
        "@@assign": "Environment"
      },
      "tag_value": {
        "@@assign": [
          "Production",
          "Staging",
          "Development"
        ]
      }
    },
    "Project": {
      "enforced_for": {
        "@@assign": [
          "ec2:instance",
          "s3:bucket",
          "rds:db"
        ]
      },
      "tag_key": {
        "@@assign": "Project"
      }
    },
    "Owner": {
      "enforced_for": {
        "@@assign": [
          "*"
        ]
      },
      "tag_key": {
        "@@assign": "Owner"
      }
    }
  }
}
```
