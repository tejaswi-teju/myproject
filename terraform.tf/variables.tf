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

