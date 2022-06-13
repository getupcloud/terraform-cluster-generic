module "linkerd" {
  count  = try(local.generic_modules.linkerd.enabled, false) ? 1 : 0
  source = "github.com/getupcloud/terraform-module-linkerd?ref=v0.4"
}
