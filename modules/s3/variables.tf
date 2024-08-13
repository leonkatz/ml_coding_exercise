variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "sse_algorithm" {
  description = "Encryption algorithm"
  type        = string
  default     = "aws:kms"
}

variable "encrypted" {
  description = "Boolean to enable/disable encryption"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "whether or not to enable versioning"
  type        = bool
  default     = false
}

variable "public_read_policy" {
  description = "Boolean for public read policy"
  type        = bool
  default     = "false"
}

variable "apply_default_policy" {
  description = "toggle applying the default policy"
  type        = bool
  default     = true
}

variable "acl" {
  description = "S3 Access Control List"
  type        = string
  default     = "private"
}

variable "enable_transition" {
  description = "This enables a lifecyle transition rule for any value besides [], e.g. ['yes']"
  type        = bool
  default     = false
}

variable "transition_days_ia" {
  description = "This enables transition to IA for any value besides [], e.g. ['30']"
  type        = string
  default     = ""
}

variable "transition_days_glacier" {
  description = "This enables transition to Glacier for any value besides [], e.g. ['60']"
  type        = string
  default     = ""
}

variable "expiration_days" {
  description = "This enables expiration for any value besides [], e.g. ['90']"
  type        = string
  default     = ""
}

variable "prefix" {
  description = "An optional prefix for a lifecycle rule"
  type        = string
  default     = null
}

variable "static_website" {
  description = "Boolean to enable/disable static website"
  type        = bool
  default     = false
}

variable "index_document" {
  description = "Index document name"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document name"
  type        = string
  default     = "index.html"
}

variable "object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled."
  type        = bool
  default     = false
}

variable "object_lock_mode" {
  description = "The default Object Lock retention mode you want to apply to new objects placed in the specified bucket. COMPLIANCE or GOVERNANCE"
  type        = string
  default     = "GOVERNANCE"
}

variable "object_lock_days" {
  description = "The number of days that you want to specify for the default retention period."
  type        = number
  default     = 365
}

variable "public_access_block_enabled" {
  description = "Whether to block all public ACLs and policies for this bucket"
  type        = bool
  default     = true
}