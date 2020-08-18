class proxmox::install {
  package { ['os-prober':
    ensure => 'absent'
  }
->package { ['proxmox-ve', 'postfix', 'open-iscsi']:
    ensure => 'installed'
  } 
->file { '/etc/network/interfaces':
    ensure  => 'present',
    content => template('proxmox/interfaces.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
~>exec { '/sbin/reboot': }
}
