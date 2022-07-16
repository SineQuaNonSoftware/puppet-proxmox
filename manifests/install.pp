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

  reboot { 'proxmox_install':
    apply =>  finished, # Wait until entire catalog is applied before rebooting
  }
}
