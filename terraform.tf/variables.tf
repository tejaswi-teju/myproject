variable "vpc_cidr" {
    description = "this is vpc cidr block"
    type  = string
    default = "192.168.0.0/24"
}

variable "public_cidr" {
    description = "this is public subnet cidr block"
    type  = string
    default = "192.168.0.0/28"   
}

variable "ami_id" {
  description = "ami for ec2"
  type = string
  default = "ami-0279a86684f669718"
}