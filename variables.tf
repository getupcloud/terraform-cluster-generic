variable "name" {
  description = "Cluster name"
  type        = string
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

variable "manifests_path" {
  description = "Manifests dir inside GitRepository"
  type        = string
  default     = ""
}

variable "customer_name" {
  description = "Customer name (Informative only)"
  type        = string
}

variable "api_endpoint" {
  description = "Kubernetes API endpoint (Informative only)"
  type        = string
  default     = ""
}

variable "cronitor_api_key" {
  description = "Cronitor API key. Leave empty to destroy"
  type        = string
  default     = ""
}

variable "cronitor_pagerduty_key" {
  description = "Cronitor PagerDuty key"
  type        = string
  default     = ""
}

variable "cronitor_tags" {
  description = "Monitor tags (Informative only)"
  type        = list(string)
  default     = []
}