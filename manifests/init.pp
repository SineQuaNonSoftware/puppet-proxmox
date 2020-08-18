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
->file { '/etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg':
    ensure => 'present',
    source => 'http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg',
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }
->apt::source { 'proxmox':
    ensure   => 'present',
    comment  => 'This is the proxmox stable repo',
    location => 'http://download.proxmox.com/debian/pve',
    release  => 'buster',
    repos    => 'pve-no-subscription'
  }


}
