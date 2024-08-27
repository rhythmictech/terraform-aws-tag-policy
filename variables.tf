
variable "name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
}

variable "description" {
  default     = null
  description = "Description of the tag policy"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "attach_ous" {
  default     = []
  description = "List of OU IDs to attach the tag policies to"
  type        = list(string)
}

variable "attach_to_org" {
  default     = true
  description = "Whether to attach the tag policy to the organization (set to false if you want to attach to OUs)"
  type        = bool
}

variable "tag_policy" {
  description = "List of tag policies to create"
  type = map(object({
    enforced_for                                      = optional(list(string))
    enforced_for_operator                             = optional(string)
    enforced_for_operators_allowed_for_child_policies = optional(list(string))
    tag_key                                           = string
    tag_key_operator                                  = optional(string)
    tag_key_operators_allowed_for_child_policies      = optional(list(string))
    values                                            = optional(list(string))
    values_operator                                   = optional(string)
    values_operators_allowed_for_child_policies       = optional(list(string))
  }))
  default = {}
}
