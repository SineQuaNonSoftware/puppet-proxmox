# @summary This class installs Proxmox on a Debian Buster minimal
#
# Basically applies what is described here:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
#
# @example
#   include proxmox

class proxmox {
  contain proxmox::hostname # This should be handled in terraform, same as apt full-upgrade and installing Puppet packages
  contain proxmox::packages # Setup the puppet repo and do another full-upgrade
  contain proxmox::install # Actually install ProxmoxVE and reboots
  contain proxmox::cleanup # Remove mainline linux kernel

  Class['proxmox::hostname']
  -> Class['proxmox::packages']
  -> Class['proxmox::install']
  -> Class['proxmox::cleanup']
}
