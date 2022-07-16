# @summary This class adds Proxmox repositories and performs a full-upgrade
#
class proxmox::packages {
  $key_path = $facts['os']['release']['major'] ? {
    '10'    => '/etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg',
    default => "/etc/apt/trusted.gpg.d/proxmox-release-${facts['os']['distro']['codename']}.gpg",
  }
  $key_url = $facts['os']['release']['major'] ? {
    '10'    => 'http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg',
    default => "https://enterprise.proxmox.com/debian/proxmox-release-${facts['os']['distro']['codename']}.gpg",
  }

  file { $key_path:
    ensure => 'present',
    source => $key_url, # Proxmox doesn't provide a proper https path to their gpg key
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }
->apt::source { 'proxmox':
    ensure   => 'present',
    comment  => 'This is the proxmox stable repo',
    location => 'http://download.proxmox.com/debian/pve',
    release  => $facts['os']['distro']['codename'],
    repos    => 'pve-no-subscription',
    notify   => Class['apt::update'],
  }

~>exec { 'apt-full-upgrade':
    command     => '/usr/bin/apt full-upgrade -y',
    refreshonly => true,
    require     => Exec['apt_update'],
  }

}
