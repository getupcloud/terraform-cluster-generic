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
  source = "github.com/getupcloud/terraform-module-flux?ref=v2.0.0-beta4"

  git_repo                = var.flux_git_repo
  manifests_path          = "./clusters/${var.cluster_name}/${var.cluster_type}/manifests"
  wait                    = var.flux_wait
  flux_version            = var.flux_version
  install_on_okd          = var.install_on_okd
  manifests_template_vars = local.manifests_template_vars
  debug                   = var.dump_debug

  depends_on = [
    # generic clusters have no pre_create scripts because they already exists at this point.
    shell_script.post_create
  ]
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=v2.0"

  api_endpoint       = var.api_endpoint
  cronitor_enabled   = var.cronitor_enabled
  cluster_name       = var.cluster_name
  cluster_sla        = var.cluster_sla
  customer_name      = var.customer_name
  suffix             = var.cluster_type
  tags               = [var.region]
  pagerduty_key      = var.cronitor_pagerduty_key
  notification_lists = var.cronitor_notification_lists
}

module "opsgenie" {
  source = "github.com/getupcloud/terraform-module-opsgenie?ref=v1.2"

  opsgenie_enabled = var.opsgenie_enabled
  customer_name    = var.customer_name
  owner_team_name  = var.opsgenie_team_name
}
