## This file is auto-generated by command:
## $ ./make-modules variables-modules.tf

locals {
  modules = {
    cert-manager = {
      enabled         = try(var.modules.cert-manager.enabled, var.modules_defaults.cert-manager.enabled)
      hosted_zone_ids = try(var.modules.cert-manager.hosted_zone_ids, var.modules_defaults.cert-manager.hosted_zone_ids)
    }
    external-dns = {
      enabled         = try(var.modules.external-dns.enabled, var.modules_defaults.external-dns.enabled)
      private         = try(var.modules.external-dns.private, var.modules_defaults.external-dns.private)
      hosted_zone_ids = try(var.modules.external-dns.hosted_zone_ids, var.modules_defaults.external-dns.hosted_zone_ids)
      domain_filters  = try(var.modules.external-dns.domain_filters, var.modules_defaults.external-dns.domain_filters)
    }
    velero = {
      enabled     = try(var.modules.velero.enabled, var.modules_defaults.velero.enabled)
      bucket_name = try(var.modules.velero.bucket_name, var.modules_defaults.velero.bucket_name)
    }
  }
}
