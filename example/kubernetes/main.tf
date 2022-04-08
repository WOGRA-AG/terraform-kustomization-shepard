terraform {
  backend "kubernetes" {
    secret_suffix = "state"
    config_path   = "~/.kube/config"
  }
}

module "shepard" {
  source  = "gitlab.wogra.com/infrastructure/dlr-shepard/local"
  version = "0.0.1"
}