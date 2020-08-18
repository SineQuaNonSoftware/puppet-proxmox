class proxmox::packages {
  file { '/etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg':
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
    repos    => 'pve-no-subscription',
  }
~>exec { 'apt_update && apt full-upgrade': }
}
