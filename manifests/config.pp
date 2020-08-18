class proxmox::config {
  package { ['linux-image-amd64','linux-image-4.19*':
    ensure => 'absent'
  }
~>exec { 'update-grub': }
}
