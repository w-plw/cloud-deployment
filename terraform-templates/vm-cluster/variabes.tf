variable "rg_id" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "creation_time" {
  type = string
}

variable "prefix" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}