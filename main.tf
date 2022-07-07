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
  source = "github.com/getupcloud/terraform-module-flux?ref=v1.10"

  git_repo       = var.flux_git_repo
  manifests_path = "./clusters/${var.cluster_name}/${var.cluster_type}/manifests"
  wait           = var.flux_wait
  flux_version   = var.flux_version
  install_on_okd = var.install_on_okd

  manifests_template_vars = merge(
    {
      alertmanager_cronitor_id : try(module.cronitor.cronitor_id, "")
      alertmanager_opsgenie_integration_api_key : try(module.opsgenie.api_key, "")
      secret : random_string.secret.result
      suffix : random_string.suffix.result
      modules : local.generic_modules
      modules_output : local.generic_modules_output
    },
    module.teleport-agent.teleport_agent_config,
    var.manifests_template_vars
  )
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=v1.3"

  cluster_name  = var.cluster_name
  customer_name = var.customer_name
  cluster_sla   = var.cluster_sla
  suffix        = var.cluster_type
  tags          = []
  pagerduty_key = var.cronitor_pagerduty_key
  api_endpoint  = var.api_endpoint
}

module "opsgenie" {
  source = "github.com/getupcloud/terraform-module-opsgenie?ref=main"

  opsgenie_enabled = var.opsgenie_enabled
  customer_name    = var.customer_name
  owner_team_name  = var.opsgenie_team_name
}

