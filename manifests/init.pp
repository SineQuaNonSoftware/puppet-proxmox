# @summary This class installs Proxmox on a Debian Buster minimal
#
# Basically applies what is described here:
# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
#
# @example
#   include proxmox

class proxmox {
  contain proxmox::hostname
  contain proxmox::packages
  contain proxmox::install
  contain proxmox::config

  Class['proxmox::hostname']
  -> Class['proxmox::packages']
  -> Class['proxmox::install']
  ~> Class['proxmox::config']
}
