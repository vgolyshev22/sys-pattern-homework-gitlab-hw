variable "flow" {
  type    = string
  default = "24-01"
}

variable "cloud_id" {
  type    = string
  default = "b1g9neapdld8h8ni5sb2"
}
variable "folder_id" {
  type    = string
  default = "b1g5kpobu0vfu53rsoa4"
}

variable "test" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

