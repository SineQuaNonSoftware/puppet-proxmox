![Valid for Puppet 6 and 7 and published on the Forge](https://github.com/SineQuaNonSoftware/puppet-proxmox/workflows/Valid%20for%20Puppet%205%20through%207%20and%20published%20on%20the%20Forge/badge.svg)

![](http://img.shields.io/badge/license-MIT-brightgreen.svg)

![Puppet Forge downloads](https://img.shields.io/puppetforge/dt/cornuwel/proxmox)

# proxmox

Puppet module handling a full automatic Proxmox installation over a fresh Debian install.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with proxmox](#setup)
    * [What proxmox affects](#what-proxmox-affects)
    * [Setup requirements](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS/provider compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The purpose of this module is to provision Proxmox servers at providers who don't offer it preinstalled.
You just order a Debian 10, run puppet and voila! You have a default Proxmox server.

We do not plan on adding features for anything that can be done via Proxmox's web interface, command line, terraform...

## Setup

### What proxmox affects

The module installs and configures a default Proxmox server. Just doing that changes a lot of things during the installation process (just look at how long it takes). The resulting product of a successful puppet run should no longer be considered as a Debian server, but a Proxmox server.
They have a lot in common, but when you have a specific problem or need, go to Proxmox's documentation first.

**Warning** The module will change your network configuration to create the necessary bridge interfaces for a public and a private VM network in proxmox, change your default kernel and remove the mainline one. Read the code and the documentation, and amend the module for your context where necessary.

**Warning** The module will reboot your server once the puppet run is done. This is necessary in order to switch kernel.

### Setup Requirements

* A clean Debian install
* A correct hostname configuration:

**/etc/hosts** file should at least contain IPv4 config:

```
127.0.0.1 localhost.localdomain localhost
<public_server_ip>  proxmox.domain.com proxmox
<puppetserver_ip>   puppet
```

**/etc/hostname** should just contain the fqdn (proxmox.domain.com)

* Install puppet-agent
* puppet agent -t (the server reboots a few seconds after the install is finished)
* After the server pings again, go to https://proxmox.domain.com:8006, ignore the "security" warning, connect with your root password and maybe start by generating a valid certificate with letsencrypt, it's included in proxmox settings ;-)
* Happy Proxmoxing!

## Usage

```
include proxmox
```

By default, the module doesn't touch the network configuration, to allow you to configure just the way you want. We recommend you use [example42/puppet-network](https://github.com/example42/puppet-network/), for example:

```
  # Public network bridge, ipv4
  network::interface { 'vmbr0':
    family       => 'inet',
    ipaddress    => $::ipaddress,
    netmask      => $::netmask,
    gateway      => $facts['gatewayv4'],
    bridge_ports => [ $facts['netdev'] ],
    bridge_stp   => 'off',
    bridge_fd    => 0,
  }
  # Private network bridge, ipv4
  network::interface { 'vmbr1':
    family       => 'inet',
    address      => '10.0.1.1/24',
    bridge_ports => ['none'],
    bridge_stp   => 'off',
    bridge_fd    => 0,
    post_up      => [
      'echo 1 > /proc/sys/net/ipv4/ip_forward',
      'iptables -t nat -A POSTROUTING -s \'10.0.1.0/24\' -o vmbr0 -j MASQUERADE',
    ],
    post_down    => [
      'iptables -t nat -D POSTROUTING -s \'10.0.1.0/24\' -o vmbr0 -j MASQUERADE',
    ],
  }
```
This will create:

* vmbr0 is the public network, where you can use your additional/failover IPs for your load balancer, firewall, etc... Any public VM needs an interface here.
* vmbr1 is the private network, for the application/database/backend VMs that don't need to be acessible directly from the internet. Connect an interface here and you get:
  * a private IP (10.0.1.0/24) by DHCP,
  * access to the internet through NAT,
  * local DNS resolution so everyone can find their friends

If you want to use the private network, you need at least one VM with an interface on **both** bridges to act as firewall, load balancer, VPN, SSH relay, whatever... Otherwise, you'll only be able to access VMs on the private network through a VNC console, or with SSH through the physical host, which will pass the key through to the VM:

```
ssh -J my.physical.host user@10.0.1.1
```

## Limitations

* Debian 10 only. [This is the way](https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster).

* Our only test machine is based on Hetzner's Debian 10.4 minimal amd64 image. It looks standard enough but maybe other providers put stuff that gets in the way, or Hetzner does something we didn't notice and we need to do it on other servers too...

* Network setup addresses are fixed for now. They will be parameters in future versions. For now update subnets in https://github.com/SineQuaNonSoftware/puppet-proxmox/blob/master/manifests/install.pp to match your network.

## Development

Start by submitting an issue that explains what you want to do.
Branch if you are in the org, fork if you are not. Then, make a pull request.

## Deploy a new release

After the feature branches have been merged and you are happy with the state of 'master',
it's time to release the module to the Forge, remember we use [SemVer](https://semver.org/)...

* Create a branch from master and update:
  * CHANGELOG.md
  * metadata.json
* Create a Pull Request
* The person who merges the PR has a little CLI work to do:

```
git checkout master
git pull
git tag X.Y.Z
git push --tags
```

## Links

* https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
* https://puppet.com/docs/puppet/latest/puppet_strings.html
* https://puppet.com/docs/puppet/latest/puppet_strings_style.html
* https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
