variable "kubernetes_config_path" {
  description = "Path of Kubernetes configuration file"
  default     = "~/.kube/config"
}

variable "shepard_dns_name" {
  description = "shepard dns name"
  type        = string
  default     = "shepard.example.com"
}

variable "tls" {
  description = "provide letsencrypt tls certificate"
  type        = bool
  default     = false
}

variable "oidc_public_key" {
  description = "provide oidc realm public key"
  type        = string
  default     = ""
}

variable "keycloak_url" {
  description = "Public Url to keycloak"
  type        = string
  default     = "https://keycloak.example.com"
}