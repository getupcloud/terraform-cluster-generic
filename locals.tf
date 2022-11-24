locals {
  kubeconfig_filename        = abspath(pathexpand(var.kubeconfig_filename))
  api_endpoint               = var.api_endpoint
  token                      = var.kubeconfig_client_token
  certificate_authority_data = var.kubeconfig_cluster_certificate_authority_data
  client_certificate_data    = var.kubeconfig_client_certificate_data
  client_key_data            = var.kubeconfig_client_key_data

  suffix = random_string.suffix.result
  secret = random_string.secret.result

  modules_result = {
    for name, config in local.modules : name => merge(config, {
      output : config.enabled ? lookup(local.register_modules, name, try(config.output, tomap({}))) : tomap({})
    })
  }

  manifests_template_vars = merge(
    var.manifests_template_vars,
    {
      alertmanager_cronitor_id : try(module.cronitor.cronitor_id, "")
      alertmanager_opsgenie_integration_api_key : try(module.opsgenie.api_key, "")
      secret : random_string.secret.result
      suffix : random_string.suffix.result
      modules : local.modules_result
    },
    module.teleport-agent.teleport_agent_config,
    { for k, v in var.manifests_template_vars : k => v if k != "modules" }
  )
}
