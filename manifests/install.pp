# @summary This class installs Proxmox
class proxmox::install {

  Class['apt::update'] -> Package <| provider == 'apt' |>

->package { ['proxmox-ve', 'postfix', 'open-iscsi']:
    ensure => 'installed',
    notify => Reboot['proxmox_install'],
  }

  reboot { 'proxmox_install':
    apply =>  finished, # Wait until entire catalog is applied before rebooting
  }
}
