resource "yandex_vpc_network" "vpc" {
  name = "yc-web-vpc"
}


resource "yandex_vpc_subnet" "subnet" {
  name           = "yc-web-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


resource "yandex_compute_instance" "web" {
  count = 2

  name = "yc-web-server-${count.index}"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd82vchjp2kdjiuam29k"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_key}"
  }
}

resource "yandex_vpc_security_group" "vm_sg" {
  name        = "vm-security-group"
  description = "Security group for virtual machines in Yandex Cloud"

  network_id = yandex_vpc_network.vpc.id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 22
    to_port        = 22
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 80
    to_port        = 80
  }
}
