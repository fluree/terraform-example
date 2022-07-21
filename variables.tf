variable "image_name" {
  description = "Value of the name for the docker image"
  type        = string
  default     = "fluree/ledger:2.0.0-alpha4"
}

variable "container_path" {
  description = "Value of the path to the data inside the Fluree container"
  type        = string
  default     = "/var/lib/fluree"
}

variable "network_name" {
  description = "Value of the internal docker network name"
  type        = string
  default     = "fluree_network"
}

variable "external_docker_ports" {
  type = list(object({
    db     = number
    ledger = number
  }))
  default = [
    {
      db     = 8090
      ledger = 9790
    },
    {
      db     = 8091
      ledger = 9791
    },
    {
      db     = 8092
      ledger = 9792
    }
  ]
}