variable "kubernetes_config_path" {
  description = "Path of Kubernetes configuration file"
  default     = "~/.kube/config"
}

variable "shepard_dns_name" {
  description = "shepard dns name"
  type        = string
  default     = "*"
}

variable "tls" {
  description = "provide letsencrypt tls certificate"
  type        = bool
  default     = false
}