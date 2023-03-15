resource "helm_release" "istio" {
  name       = "istio"
  repository = "https://istio.io/charts/"
  chart      = "istio"
  namespace  = "istio-system"
  version    = "1.8.2"

  set {
    name  = "gateways.istio-ingressgateway.enabled"
    value = "true"
  }

  set {
    name  = "gateways.istio-egressgateway.enabled"
    value = "true"
  }

  set {
    name  = "global.controlPlaneSecurityEnabled"
    value = "true"
  }
}
