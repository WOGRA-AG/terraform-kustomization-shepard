variable "kubernetes_config_path" {
  description = "Path of Kubernetes configuration file"
  default     = "~/.kube/config"
}

variable "neo4j_values_yaml_path" {
  description = "neo4j values.yaml path"
  default = "manifests/neo4j/helm/values.yaml"
}
