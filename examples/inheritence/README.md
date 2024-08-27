# inheritence example

This example defines a tag policy for Environment and Owner tags, with the Engineering OU adding an additional cost_center value and required team values. 

The following tag policy is produced and attached to the organization:

```
{
  "tags": {
    "cost_center": {
      "enforced_for": {
        "@@assign": [
          "*"
        ]
      },
      "tag_key": {
        "@@assign": "cost_center"
      },
      "tag_value": {
        "@@assign": [
          "1000",
          "2000",
          "3000"
        ]
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

The following tag policy is produced and attached to the Engineering OU:

```
{
  "tags": {
    "cost_center": {
      "enforced_for": {
        "@@assign": [
          "*"
        ]
      },
      "tag_key": {
        "@@assign": "cost_center"
      },
      "tag_value": {
        "@@append": [
          "4000"
        ]
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
      },
      "tag_value": {
        "@@assign": [
          "Team 1",
          "Team 2",
          "Team 3"
        ]
      }
    }
  }
}
```
