resource "helm_release" "mongodb" {
  name = "mongodb"

  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  version    = "0.7.3"

  namespace = "shepard"

  depends_on = [
    kustomization_resource.dlr_shepard_base_resource
  ]
}

data "kustomization_build" "mongodb_cr_build" {
  path = "${path.module}/manifests/mongodb"
}

resource "kustomization_resource" "mongodb_cr_resource" {
  for_each = data.kustomization_build.mongodb_cr_build.ids
  manifest = data.kustomization_build.mongodb_cr_build.manifests[each.value]

  depends_on = [
    helm_release.mongodb
  ]
}