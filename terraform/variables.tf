variable "region" {
  default = "par1"
}

variable "architecture" {
  default = "arm"
}

variable "image" {
  default = "Debian Stretch"
}

variable "master_instance_type" {
  default = "C1"
}

variable "master_instance_count" {
  default = 1
}

variable "proxy_instance_type" {
  default = "C1"
}

variable "proxy_instance_count" {
  default = 1
}

variable "worker_instance_type" {
  default = "C1"
}

variable "worker_volume_size" {
  default = 50
}

variable "worker_instance_count" {
  default = 2 
}
