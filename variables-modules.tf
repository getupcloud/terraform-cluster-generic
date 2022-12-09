## Provider-specific modules variables
## Copy to toplevel

variable "modules_defaults" {
  description = "Configure modules to install (defaults)"
  type = object({
    cert-manager = object({
      enabled         = bool
      hosted_zone_ids = list(string)
    })
    external-dns = object({
      enabled         = bool
      private         = bool
      hosted_zone_ids = list(string)
      domain_filters  = list(string)
    })
    velero = object({
      enabled     = bool
      bucket_name = string
    })
  })

  default = {
    cert-manager = {
      enabled         = false
      hosted_zone_ids = []
    }
    external-dns = {
      enabled         = false
      private         = false
      hosted_zone_ids = []
      domain_filters  = []
    }
    velero = {
      enabled     = false
      bucket_name = ""
    }
  }
}

locals {
  register_modules = {
    cert-manager : local.modules.cert-manager.enabled ? module.cert-manager[0] : {}
    # external-dns : local.modules.external-dns.enabled ? module.external-dns[0] : {}
    velero : local.modules.velero.enabled ? module.velero[0] : {}
  }
}
