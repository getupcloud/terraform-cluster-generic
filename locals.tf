locals {
  api_endpoint = var.api_endpoint
  kubeconfig   = abspath(pathexpand(var.kubeconfig_filename))
  suffix       = random_string.suffix.result
  secret       = random_string.secret.result
}
