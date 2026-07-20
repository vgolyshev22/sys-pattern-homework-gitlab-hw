output "web_vm_internal_ips" {
  description = "Internal IP addresses of web servers"

  value = [
    for vm in yandex_compute_instance.web :
    vm.network_interface[0].ip_address
  ]
}

output "load_balancer_ip" {
  description = "External IP address of network load balancer"

  value = flatten([
    for listener in yandex_lb_network_load_balancer.web_balancer.listener :
    listener.external_address_spec[*].address
  ])[0]
}

output "load_balancer_url" {
  description = "URL of network load balancer"

  value = "http://${flatten([
    for listener in yandex_lb_network_load_balancer.web_balancer.listener :
    listener.external_address_spec[*].address
  ])[0]}"
}
