# Fluree Terraform Docker Example

This project provides an example of how to use Terraform to deploy Fluree as a 3-node transactor group against Docker

## Get Started

Make sure you have Terraform installed by running

```bash
terraform -help
```

If you need to install Terraform, you can use [Homebrew](https://brew.sh/) with the following command, or you can consult the [Terraform Installation Instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/docker-get-started)

```bash
brew tap hashicorp/tap

brew install hashicorp/tap/terraform
```

This example uses Docker Desktop for provisioning your Fluree cluster. Ensure you have Docker Desktop installed and running, or look for installation instructions [here](https://docs.docker.com/desktop/install/mac-install/)

Once you have confirmed your installation of Terraform & Docker Desktop, clone or download this repository onto your machine.

```bash
git clone https://github.com/fluree/terraform-example.git

cd terraform-example
```

## Using Terraform to Run Fluree

Running Fluree through Terraform is easy. From within the `terraform-example` working directory, simply run

```bash
terraform init
#This initializes the Terraform plugin for Docker

terraform apply
#This will provision Fluree against your Docker Desktop environment
```

> Note: Docker Desktop RAM defaults may be too low for running Fluree in a multi-node
> configuration locally. We generally recommend 2-3GB of RAM per node, so for this example,
> 8GB should suffice.

If you want to run a network with a different number of Fluree transactors, you can edit the `count` variable within `variables.tf` to include more servers, for example

```ruby
...
variable "ledger_count" {
  type    = number
  default = 5
}
...
```

## Customizing Fluree

Additional environment variables can be passed into your `docker_container` resource block to configure Fluree in specific ways.

Information regarding configurable Fluree settings is available [here](https://developers.flur.ee/docs/reference/fluree_config/).

## Verify container

By default, you should be able to access the Admin UI for any of your Terraform-provisioned Fluree instances by navigating to http://localhost:8090, http://localhost:8091, or http://localhost:8092

The Docker Dashboard is useful to verify/access the container and fluree
service. Via the dashboard, you can inspect environment settings, review
logs, open a CLI terminal session and even browse to the Fluree Admin UI
site.

You can also run `docker ps` to observe your containers provisioned through Terraform.

---

## License

This project is licensed under the terms of the MIT license.
