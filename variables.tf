variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "cluster_type" {
  description = "Overrides cluster type"
  type        = string
  default     = "generic"
}

variable "cluster_sla" {
  description = "Cluster SLA"
  type        = string
  default     = "none"
}

variable "customer_name" {
  description = "Customer name (Informative only)"
  type        = string
}

variable "region" {
  description = "Cluster Region"
  type        = string
  default     = "unknown"
}

variable "use_kubeconfig" {
  description = "Should kubernetes/kubectl providers use local kubeconfig or credentials from cloud module"
  type        = bool
  default     = false
}

variable "kubeconfig_filename" {
  description = "Kubeconfig path"
  type        = string
  default     = "~/.kube/config"
}

variable "get_kubeconfig_command" {
  description = "Command to create/update kubeconfig"
  type        = string
  default     = "true"
}

variable "kubeconfig_cluster_certificate_authority_data" {
  description = "Kubeconfig Cluster CA Certificate"
  type        = string
  default     = null
}

variable "kubeconfig_client_certificate_data" {
  description = "Kubeconfig Cluster Client Certificate Data"
  type        = string
  default     = null
}

variable "kubeconfig_client_key_data" {
  description = "Kubeconfig Cluster Client Certificate Key Data"
  type        = string
  default     = null
}

variable "kubeconfig_client_token" {
  description = "Kubeconfig Client Auth Token"
  type        = string
  default     = null
}

variable "flux_git_repo" {
  description = "GitRepository URL."
  type        = string
  default     = ""
}

variable "flux_wait" {
  description = "Wait for all manifests to apply"
  type        = bool
  default     = true
}

variable "flux_version" {
  description = "Flux version to install"
  type        = string
  default     = "v0.15.3"
}

variable "manifests_path" {
  description = "Manifests dir inside GitRepository"
  type        = string
  default     = ""
}

variable "api_endpoint" {
  description = "Kubernetes API endpoint (Informative only)"
  type        = string
  default     = ""
}

variable "cronitor_enabled" {
  description = "Creates and enables Cronitor monitor."
  type        = bool
  default     = false
}
variable "cronitor_pagerduty_key" {
  description = "Cronitor PagerDuty key"
  type        = string
  default     = ""
}

variable "opsgenie_enabled" {
  description = "Creates and enables Opsgenie integration."
  type        = bool
  default     = false
}

variable "opsgenie_team_name" {
  description = "Opsgenie Owner team name of the integration."
  type        = string
  default     = "Operations"
}

variable "manifests_template_vars" {
  description = "Template vars for use by cluster manifests"
  type        = any
  default = {
    alertmanager_pagerduty_key : ""
  }
}

variable "teleport_auth_token" {
  description = "Teleport Agent auth token"
  type        = string
  default     = ""
}

variable "install_on_okd" {
  description = "Apply all required patches to install on OKD (Openshift)"
  type        = bool
  default     = false
}

variable "generic_modules" {
  description = "Configure generic modules to install"
  type        = any
  default     = {}
}

variable "generic_modules_defaults" {
  description = "Configure modules to install (defaults)"
  type = object({
    linkerd = object({
      enabled : bool
      nodeSelector : any
    })
    linkerd-cni = object({
      enabled : bool
      nodeSelector : any
    })
    linkerd-viz = object({
      enabled : bool
      nodeSelector : any
    })
  })

  default = {
    linkerd : {
      enabled : false
      nodeSelector : {
        role : "infra"
      }
    }
    linkerd-viz : {
      enabled : false
      nodeSelector : {
        role : "infra"
      }
    }
    linkerd-cni : {
      enabled : false
      nodeSelector : {
        role : "infra"
      }
    }
  }
}

variable "pre_create" {
  description = "Scripts to execute before cluster is created."
  type        = list(string)
  default     = []
}

variable "post_create" {
  description = "Scripts to execute after cluster is created."
  type        = list(string)
  default     = []
}
