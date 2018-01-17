provider "scaleway" {
  region = "${var.region}"
}

data "scaleway_image" "os" {
  architecture = "${var.architecture}"
  name         = "${var.image}"
}

//resource "scaleway_ip" "public_ip" {
//  count = 1
//}

resource "scaleway_server" "worker" {
  count  = "${var.worker_instance_count}"
  name   = "worker${count.index}"
  image  = "${data.scaleway_image.os.id}"
  type   = "${var.worker_instance_type}"
  state  = "running"
  tags   = ["workers"]
}

//  volume {
//    size_in_gb = 25
//    type       = "l_ssd"
//}


resource "scaleway_server" "master" {
  count  = "${var.master_instance_count}"
  name   = "master${count.index}"
  image  = "${data.scaleway_image.os.id}"
  type   = "${var.master_instance_type}"
  state  = "running"
  tags   = ["masters"]
}

resource "scaleway_server" "proxy" {
  count = "${var.proxy_instance_count}"
  name  = "proxy${count.index}"
  image = "${data.scaleway_image.os.id}"
  type  = "${var.proxy_instance_type}"
  //public_ip  = "${count.index == "0" ? element(scaleway_ip.public_ip.*.ip, count.index) : "0"}"
  public_ip = "51.15.217.165"
  state  = "running"
  tags  = ["proxy","${count.index == "0" ? "primary" : "secondary"}"]
}

output "worker_private_ips" {
  value = ["${scaleway_server.worker.*.private_ip}"]
}

output "master_private_ips" {
  value = ["${scaleway_server.master.*.private_ip}"]
}

output "proxy_private_ips" {
  value = ["${scaleway_server.proxy.*.private_ip}"]
}

output "public_ip" {
  value = ["${scaleway_server.proxy.*.public_ip}"]
}
