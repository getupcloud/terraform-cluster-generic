locals {
  kubeconfig_filename        = abspath(pathexpand(var.kubeconfig_filename))
  api_endpoint               = var.api_endpoint
  token                      = var.kubeconfig_client_token
  certificate_authority_data = var.kubeconfig_cluster_certificate_authority_data
  client_certificate_data    = var.kubeconfig_client_certificate_data
  client_key_data            = var.kubeconfig_client_key_data

  suffix = random_string.suffix.result
  secret = random_string.secret.result

  generic_modules = merge(var.generic_modules_defaults, var.generic_modules)
  generic_modules_output = {
    linkerd : local.generic_modules.linkerd.enabled ? module.linkerd[0] : {}
  }
}
