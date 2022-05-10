terraform {
  backend "kubernetes" {
    secret_suffix = "state"
    config_path   = "~/.kube/config"
  }
}

module "shepard" {
  source  = "WOGRA-AG/shepard/kustomization"
  version = "0.0.6"
}
