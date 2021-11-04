module "internet" {
  source = "github.com/getupcloud/terraform-module-internet?ref=main"
}

module "flux" {
  source = "github.com/getupcloud/terraform-module-flux?ref=main"

  git_repo       = var.flux_git_repo
  manifests_path = "./clusters/${var.name}/generic/manifests"
  wait           = var.flux_wait
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=main"

  cluster_name  = var.name
  customer_name = var.customer_name
  suffix        = "generic"
  api_key       = var.cronitor_api_key
  pagerduty_key = var.cronitor_pagerduty_key
  api_endpoint  = var.api_endpoint
  tags          = var.cronitor_tags
}