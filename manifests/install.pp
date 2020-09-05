# @summary This class installs Proxmox
# @note It also configures:
# - a public bridge network for VMs or CTs with public IPs
# - a private bridge network for VMs or CTs without public IPs, but with NAT so they can access the internet

class proxmox::install {

  Class['apt::update'] -> Package <| provider == 'apt' |>

  package { 'os-prober':
    ensure => 'absent'
  }
->package { ['proxmox-ve', 'postfix', 'open-iscsi']:
    ensure => 'installed',
    notify => Reboot['proxmox_install'],
  }

  diff --git a/manifests/install.pp b/manifests/install.pp
index ceb4e54..bce0132 100644
--- a/manifests/install.pp
+++ b/manifests/install.pp
@@ -16,6 +16,9 @@ class proxmox::install {
   }
   #TODO Configure Postfix properly, maybe as satellites and have a mail server to handle all our sent mail?
  class { 'network':
    config_file_per_interface => true,
  }

  # Public network bridge, ipv4
  network::interface { 'vmbr0':
    family       => 'inet',
    ipaddress    => $::ipaddress,
    netmask      => $::netmask,
    gateway      => $facts['gatewayv4'],
    bridge_ports => [ $facts['netdev'] ],
    bridge_stp   => 'off',
    bridge_fd    => 0,
  }
  # Private network bridge, ipv4
  network::interface { 'vmbr1':
    family       => 'inet',
    address      => '10.0.1.1/24',
    bridge_ports => ['none'],
    bridge_stp   => 'off',
    bridge_fd    => 0,
    post_up      => [
      'echo 1 > /proc/sys/net/ipv4/ip_forward',
      'iptables -t nat -A POSTROUTING -s \'10.0.1.0/24\' -o vmbr0 -j MASQUERADE',
    ],
    post_down    => [
      'iptables -t nat -D POSTROUTING -s \'10.0.1.0/24\' -o vmbr0 -j MASQUERADE',
    ],
  }

  reboot { 'proxmox_install':
    apply =>  finished, # Wait until entire catalog is applied before rebooting
  }
}
