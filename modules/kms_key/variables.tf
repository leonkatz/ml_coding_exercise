variable "kms_name" {
  description = "name of kms key"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "enable_key_rotation" {
  description = "whether to enable key rotation"
  type        = bool
  default     = true
}

variable "deletion_window_in_days" {
  description = "deletion window in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "alias" {
  description = "Human friendly key alias"
  type        = string
  default     = null
}