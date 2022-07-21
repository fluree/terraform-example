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
  fdb_group_servers = "fdb_group_servers=server1@ledger_one:${var.external_docker_ports[0].ledger},server2@ledger_two:${var.external_docker_ports[1].ledger},server3@ledger_three:${var.external_docker_ports[2].ledger}"
}

resource "docker_image" "fluree" {
  name         = var.image_name
  keep_locally = false
}

resource "docker_network" "fluree_network" {
  name = var.network_name
}

resource "docker_container" "ledger_one" {
  image = docker_image.fluree.latest
  name  = "ledger_one"
  networks_advanced {
    name = var.network_name
  }
  volumes {
    container_path = var.container_path
    host_path      = "${path.cwd}/data/ledger_one"
  }
  ports {
    internal = 8090
    external = var.external_docker_ports[0].db
  }
  ports {
    internal = 9790
    external = var.external_docker_ports[0].ledger
  }
  env = [
    local.fdb_group_servers,
    "fdb_group_this_server=server1",
    "fdb_group_port=9790"
  ]
}

resource "docker_container" "ledger_two" {
  image = docker_image.fluree.latest
  name  = "ledger_two"
  networks_advanced {
    name = var.network_name
  }
  volumes {
    container_path = var.container_path
    host_path      = "${path.cwd}/data/ledger_two"
  }

  ports {
    internal = 8090
    external = var.external_docker_ports[1].db
  }
  ports {
    internal = 9790
    external = var.external_docker_ports[1].ledger
  }
  env = [
    local.fdb_group_servers,
    "fdb_group_this_server=server2",
    "fdb_group_port=9790"
  ]
}

resource "docker_container" "ledger_three" {
  image = docker_image.fluree.latest
  name  = "ledger_three"
  networks_advanced {
    name = var.network_name
  }
  volumes {
    container_path = var.container_path
    host_path      = "${path.cwd}/data/ledger_three"
  }

  ports {
    internal = 8090
    external = var.external_docker_ports[2].db
  }
  ports {
    internal = 9790
    external = var.external_docker_ports[2].ledger
  }
  env = [
    local.fdb_group_servers,
    "fdb_group_this_server=server3",
    "fdb_group_port=9790"
  ]
}