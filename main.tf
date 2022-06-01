module "internet" {
  source = "github.com/getupcloud/terraform-module-internet?ref=v1.0"
}

module "teleport-agent" {
  source = "github.com/getupcloud/terraform-module-teleport-agent-config?ref=v0.2"

  auth_token       = var.teleport_auth_token
  cluster_name     = var.cluster_name
  customer_name    = var.customer_name
  cluster_sla      = var.cluster_sla
  cluster_provider = "generic"
  cluster_region   = var.region
}

module "flux" {
  source = "github.com/getupcloud/terraform-module-flux?ref=v1.9"

  git_repo       = var.flux_git_repo
  manifests_path = "./clusters/${var.cluster_name}/generic/manifests"
  wait           = var.flux_wait
  flux_version   = var.flux_version
  install_on_okd = var.install_on_okd

  manifests_template_vars = merge(
    {
      alertmanager_cronitor_id : module.cronitor.cronitor_id
      secret : random_string.secret.result
      suffix : random_string.suffix.result
    },
    module.teleport-agent.teleport_agent_config,
    var.manifests_template_vars
  )
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=v1.1"

  cluster_name  = var.cluster_name
  customer_name = var.customer_name
  cluster_sla   = var.cluster_sla
  suffix        = "generic"
  tags          = []
  api_key       = var.cronitor_api_key
  pagerduty_key = var.cronitor_pagerduty_key
  api_endpoint  = var.api_endpoint
}
