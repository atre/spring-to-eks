variable "region" {
  type = string
  default = "eu-central-1"
}

variable "azs" {
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

locals {
  name = "petclinic"
  cluster_name = "petclinic-${random_string.suffix.result}"
  cluster_version = "1.22"
}
