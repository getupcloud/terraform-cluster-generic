module "internet" {
  source = "github.com/getupcloud/terraform-module-internet?ref=main"
}

module "flux" {
  source = "github.com/getupcloud/terraform-module-flux?ref=main"

  git_repo       = var.flux_git_repo
  manifests_path = "./clusters/${var.name}/generic/manifests"
  wait           = var.flux_wait
  cluster_template_vars = {
    cronitor_id : module.cronitor.cronitor_id
  }
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=main"

  cluster_name  = var.name
  customer_name = var.customer_name
  suffix        = "generic"
  tags          = var.cronitor_tags
  api_key       = var.cronitor_api_key
  pagerduty_key = var.cronitor_pagerduty_key
  api_endpoint  = var.api_endpoint
}
