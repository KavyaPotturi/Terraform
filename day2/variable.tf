variable "ami" {
  description = "inserting ami id"
  type = string
  default = ""
}

variable "instance_type" {
  description = "inserting instance type"
  type = string
  default = ""
}

variable "key_name" {
  description = "inserting the key name"
  type = string
  default = ""
}

variable "availability_zone" {
  description = "inserting the az"
  type = string
  default = ""
}