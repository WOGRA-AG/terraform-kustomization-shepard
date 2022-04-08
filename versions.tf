terraform {
  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = ">= 0.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
  required_version = "~> 1.1"
}