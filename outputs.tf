output "ledger_one_container_id" {
  description = "ID of the docker container for Fluree Ledger One"
  value       = docker_container.ledger_one.id
}

output "ledger_one_image_id" {
  description = "ID of the docker image for Fluree Ledger One"
  value       = docker_image.fluree.id
}