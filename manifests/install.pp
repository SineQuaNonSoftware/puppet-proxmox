class proxmox::install {
  package { ['os-prober':
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
  reboot { '/etc/network/interfaces':
    subscribe => File['/etc/network/interfaces'],
  }
}
