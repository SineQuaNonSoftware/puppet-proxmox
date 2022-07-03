# @summary This class installs Proxmox on a Debian Buster minimal
#
# Basically applies what is described here, nothing more, nothing less:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
#
# @example
#   include proxmox

class proxmox {

  # Make sure the module is run on a debian 10
  if( $facts['os']['name'] != 'Debian' or ( $facts['os']['release']['major'] != '10' ) and ( $facts['os']['release']['major'] != '10' ) )
  {
    if(!($facts['os']['release']['major'] == '10' or
    $facts['os']['release']['major'] == '11' ))
    {
      fail('This modules only works on Debian 10 or 11 ("buster" & "bullseye").')
    }
  }

  contain proxmox::packages # Setup the puppet repo and do another full-upgrade
  contain proxmox::install # Actually install ProxmoxVE and reboots
  contain proxmox::cleanup # Remove mainline linux kernel

  Class['proxmox::packages']
->Class['proxmox::install']
->Class['proxmox::cleanup']
}
