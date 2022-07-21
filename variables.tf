variable "image_name" {
  description = "Value of the name for the docker image"
  type        = string
  default     = "fluree/ledger:2.0.0-alpha4"
}

variable "ledger_count" {
  type    = number
  default = 3
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
