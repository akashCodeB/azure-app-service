locals {
  resource_group_name     = "cicd-resource-group"
  container_registry_name = "cicdtestingregistry"
  location                = "East US"
  web_app_name            = "cicd-web-app"
  load_balancer_name      = "cicdloadbalancerGateway"
  public_ip_name          = "cicdpublicip"
  fontend_public_ip_name  = "cicdpublicip"
  security_group_name     = "cicd-network-security-group"
  vnet                    = "cicdvnet"
  container_name          = "cicd-testing"
}


variable "container_apps" {
  type = list(object({
    name            = string
    image           = string
    containerPort   = number
    ingress_enabled = bool
    min_replicas    = number
    max_replicas    = number
    cpu_requests    = number
    mem_requests    = string
  }))

  default = [{
    image           = "nginx"
    name            = "testing-container"
    containerPort   = 80
    ingress_enabled = true
    min_replicas    = 1
    max_replicas    = 5
    cpu_requests    = 0.25
    mem_requests    = "0.5Gi"
    },
  ]
}
