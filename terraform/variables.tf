variable "region" {
  default = "par1"
}

variable "architecture" {
  default = "x86_64"
}

variable "image" {
  default = "Debian Stretch"
}

variable "master_instance_type" {
  default = "VC1S"
}

variable "master_instance_count" {
  default = 1
}

variable "proxy_instance_type" {
  default = "VC1S"
}

variable "proxy_instance_count" {
  default = 1
}

variable "worker_instance_type" {
  default = "VC1S"
}

variable "worker_volume_size" {
  default = 50
}

variable "worker_instance_count" {
  default = 2 
}
