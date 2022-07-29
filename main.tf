terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.19.0"
    }
  }
}

provider "docker" {}

locals {
  fdb_group_servers = <<EOT
        fdb_group_servers=
        %{~for index in range(var.ledger_count)~}
        server${index + 1}@ledger${index + 1}:${9790 + index},
        %{~endfor~}
    EOT
}

resource "docker_image" "fluree" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_network" "fluree_network" {
  name = var.network_name
}

resource "docker_container" "ledger" {
  count = var.ledger_count
  image = docker_image.fluree.latest
  name  = "ledger${count.index + 1}"
  networks_advanced {
    name = var.network_name
  }
  volumes {
    container_path = var.container_path
    host_path      = "${path.cwd}/data/ledger${count.index + 1}"
  }
  ports {
    internal = 8090
    external = 8090 + count.index
  }
  ports {
    internal = 9790
    external = 9790 + count.index
  }
  env = [
    local.fdb_group_servers,
    "fdb_group_this_server=server${count.index + 1}",
    "fdb_group_port=9790"
  ]
}

