resource "helm_release" "go_app" {
  name       = "metrics-${var.go_app_name}"
  namespace  = "default"
  chart      = "./samples/${var.go_app_name}/chart/${var.go_app_name}"
  wait       = true

  set {
    name  = "replicaCount"
    value = 3
  }

  set {
    name  = "image.repository"
    value = var.go_image_repository
  }

  set {
    name  = "ingress.name"
    value = "${var.go_app_name}-ingress"
  }

  set {
    name  = "ingress.host"
    value = "metrics-${var.go_app_name}.${data.ibm_container_cluster.cluster.ingress_hostname}"
  }

  set {
    name  = "ingress.tls.hosts"
    value = "metrics-${var.go_app_name}.${data.ibm_container_cluster.cluster.ingress_hostname}"
  }

  set {
    name  = "ingress.tls.secret_name"
    value = data.ibm_container_cluster.cluster.ingress_secret
  }
}

resource "helm_release" "node_app" {
  name       = "metrics-${var.node_app_name}"
  namespace  = "default"
  chart      = "./samples/${var.node_app_name}/chart/${var.node_app_name}"
  wait       = true

  set {
    name  = "replicaCount"
    value = 3
  }

  set {
    name  = "image.repository"
    value = var.node_image_repository
  }

  set {
    name  = "ingress.name"
    value = "${var.node_app_name}-ingress"
  }

  set {
    name  = "ingress.host"
    value = "metrics-${var.node_app_name}.${data.ibm_container_cluster.cluster.ingress_hostname}"
  }

  set {
    name  = "ingress.tls.hosts"
    value = "metrics-${var.node_app_name}.${data.ibm_container_cluster.cluster.ingress_hostname}"
  }

  set {
    name  = "ingress.tls.secret_name"
    value = data.ibm_container_cluster.cluster.ingress_secret
  }
}