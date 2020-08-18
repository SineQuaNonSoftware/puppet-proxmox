class proxmox::hostname {
  #TODO Move this to the terraform server-init
  host { 'proxmox':
    name          => $facts['fqdn'],
    ip            => $facts['ipaddress'],
    host_aliases  => $facts['hostname'],
  }
}
