#arquivo usado como array utilzado no arquivo network para nomes das vpc filha
variable "availability_zones" {
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "my_public_ip" {} #esta sem valor pois qdo executo o terraform ele carrega essa var
