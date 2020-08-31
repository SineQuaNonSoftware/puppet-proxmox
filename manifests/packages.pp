# @summary This class adds Proxmox repositories and performs a full-upgrade

class proxmox::packages {
  file { '/etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg':
    ensure => 'present',
    source => 'http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg', # Proxmox doesn't provide a proper https path to their gpg key
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }
->apt::source { 'proxmox':
    ensure   => 'present',
    comment  => 'This is the proxmox stable repo',
    location => 'http://download.proxmox.com/debian/pve', # Proxmox doesn't provide a proper https repo either
    release  => 'buster',
    repos    => 'pve-no-subscription',
    notify   => Class['apt::update'],
  }

~>exec { 'apt-full-upgrade':
    command     => '/usr/bin/apt full-upgrade -y',
    refreshonly => true,
    require     => Exec['apt_update'],
  }

}
