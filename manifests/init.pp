# @summary This class installs Proxmox on a Debian Buster minimal
#
# Basically applies what is described here:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
#
# @example
#   include proxmox
class proxmox {
  #TODO Move this to the terraform server-init
  host { 'proxmox':
    name          => $facts['fqdn'],
    ip            => $facts['ipaddress'],
    host_aliases  => $facts['hostname'],
  }
}
