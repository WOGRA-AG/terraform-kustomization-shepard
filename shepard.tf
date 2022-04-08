data "kustomization_build" "dlr_shepard_base_build" {
  path = "manifests/common"
}

resource "kustomization_resource" "dlr_shepard_base_resource" {
  for_each = data.kustomization_build.dlr_shepard_base_build.ids
  manifest = data.kustomization_build.dlr_shepard_base_build.manifests[each.value]
}

data "kustomization_build" "dlr_shepard_backend_build" {
  path = "manifests/backend/base"
}

resource "kustomization_resource" "dlr_shepard_backend_resource" {
  for_each = data.kustomization_build.dlr_shepard_backend_build.ids
  manifest = data.kustomization_build.dlr_shepard_backend_build.manifests[each.value]

  depends_on = [
    helm_release.influxdb,
    helm_release.mongodb,
    helm_release.neo4j
  ]
}

data "kustomization_build" "dlr_shepard_frontend_build" {
  path = "manifests/frontend/overlays/istio"
}

resource "kustomization_resource" "dlr_shepard_frontend_resource" {
  for_each = data.kustomization_build.dlr_shepard_frontend_build.ids
  manifest = data.kustomization_build.dlr_shepard_frontend_build.manifests[each.value]

  depends_on = [
    kustomization_resource.dlr_shepard_backend_resource
  ]
}