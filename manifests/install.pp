# @summary This class installs Proxmox
# @note It also configures:
# - a public bridge network for VMs or CTs with public IPs
# - a private bridge network for VMs or CTs without public IPs, but with NAT so they can access the internet

class proxmox::install {
  package { 'os-prober':
    ensure => 'absent'
  }
->package { ['proxmox-ve', 'postfix', 'open-iscsi']:
    ensure => 'installed'
  }
  #TODO Configure Postfix properly, maybe as satellites and have a mail server to handle all our sent mail?

~>file { '/etc/network/interfaces':
    ensure  => 'present',
    content => template('proxmox/interfaces.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
#TODO: Put this back in after we can generate a proper network config
#  reboot { '/etc/network/interfaces':
#    subscribe => [ File['/etc/network/interfaces'], Package['proxmox-ve'] ],
#  }
}
