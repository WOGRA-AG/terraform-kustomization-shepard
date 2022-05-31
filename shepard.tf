data "kustomization_build" "dlr_shepard_base_build" {
  path = "${path.module}/manifests/common"
}

resource "kustomization_resource" "dlr_shepard_base_resource" {
  for_each = data.kustomization_build.dlr_shepard_base_build.ids
  manifest = replace(
    replace(data.kustomization_build.dlr_shepard_base_build.manifests[each.value], "$SHEPARD_DNS_NAME", var.shepard_dns_name),
    "$KEYCLOAK_URL", var.keycloak_url
  )
}

data "kustomization_build" "dlr_shepard_gateway" {
  path = var.tls ? "${path.module}/manifests/acme-resources" : "${path.module}/manifests/local-shepard-gateway"
}

resource "kustomization_resource" "dlr_shepard_gateway" {
  for_each = data.kustomization_build.dlr_shepard_gateway.ids
  manifest = replace(data.kustomization_build.dlr_shepard_gateway.manifests[each.value], "$SHEPARD_DNS_NAME", var.shepard_dns_name)
  depends_on = [
    kustomization_resource.dlr_shepard_base_resource
  ]
}

data "kustomization_build" "dlr_shepard_backend_build" {
  path = "${path.module}/manifests/backend/overlays/istio"
}

resource "kustomization_resource" "dlr_shepard_backend_resource" {
  for_each = data.kustomization_build.dlr_shepard_backend_build.ids
  manifest = data.kustomization_build.dlr_shepard_backend_build.manifests[each.value]

  depends_on = [
    kustomization_resource.dlr_shepard_base_resource,
    kustomization_resource.dlr_shepard_gateway,
    helm_release.influxdb,
    helm_release.mongodb,
    helm_release.neo4j
  ]
}

data "kustomization_build" "dlr_shepard_frontend_build" {
  path = "${path.module}/manifests/frontend/overlays/istio"
}

resource "kustomization_resource" "dlr_shepard_frontend_resource" {
  for_each = data.kustomization_build.dlr_shepard_frontend_build.ids
  manifest = data.kustomization_build.dlr_shepard_frontend_build.manifests[each.value]

  depends_on = [
    kustomization_resource.dlr_shepard_backend_resource
  ]
}