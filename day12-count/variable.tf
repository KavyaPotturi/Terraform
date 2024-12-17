variable "sandboxes" {
    type = list(string)
    default = [ "dev","test","prod"]
  
}

variable "ami" {
  description = "inserting ami id"
  type = string
  default = "ami-0fd05997b4dff7aac"
}

variable "instance_type" {
  description = "inserting instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "inserting the key name"
  type = string
  default = "AWS-key"
}