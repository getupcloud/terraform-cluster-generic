module "internet" {
  source = "github.com/getupcloud/terraform-module-internet?ref=v1.0"
}

module "teleport-agent" {
  source = "github.com/getupcloud/terraform-module-teleport-agent-config?ref=v0.3"

  auth_token       = var.teleport_auth_token
  cluster_name     = var.cluster_name
  customer_name    = var.customer_name
  cluster_sla      = var.cluster_sla
  cluster_provider = var.cluster_type
  cluster_region   = var.region
}

module "flux" {
  source = "github.com/getupcloud/terraform-module-flux?ref=v2.8.1"

  git_repo                = var.flux_git_repo
  manifests_path          = "./clusters/${var.cluster_name}/${var.cluster_type}/manifests"
  wait                    = var.flux_wait
  flux_version            = var.flux_version
  manifests_template_vars = local.manifests_template_vars
  flux_install_file       = var.flux_install_file
  identity_file           = var.flux_identity_file
  identity_pub_file       = var.flux_identity_pub_file
  debug                   = var.dump_debug
  install_on_okd          = var.install_on_okd
}
