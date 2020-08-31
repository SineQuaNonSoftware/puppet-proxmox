# Changelog

All notable changes to this project will be documented in this file.

## Release 0.2.0

**Features**

* Complete overhaul of the how the module handles the network, using example42/network.
* Give the user the ability to add more custom bridges/networks.

**Bugfixes**

* Documentation: Explaine how the network is configured and how to work with it and extend it

**Known Issues**

None. Only missing features:

* cloud-init
* IPv6

## Release 0.1.1

**Features**

Improved documentation and setup TravisCI.

**Bugfixes**

A few linting fixes, thanks to the test suite.

**Known Issues**

No more than before.

## Release 0.1.0

**Features**

Turns a Debian 10 buster minimal into a ProxmoxVE server, in a single puppet run, which includes a reboot to switch kernels and apply the network configuration.
The network configuration template generates 2 bridges/networks you can connect your VMs to:

- vmbr0 has direct access to the network interface, use for VMs that have public IPs
- vmbr1 is a private 10.0.1.0/24 network with NATed access to the internet, use for backend servers, databases, staging environment...

These are the two most sensible networks to have on a proxmox servers, so we figured it would be good enough for a 0.1.0.

**Bugfixes**

First version to be able to actually get the work done, in a single puppet run.

**Known Issues**

The fact that we control /etc/network/interfaces makes user-created bridges, vlans or bonds in the web interface very temporary :-/

Option1: Add a custom type and make people manage their network configuration from the module. Lots of work, not a fan.
Option2: Generate only the minimum amount of config (vmbr0) and ignore further modifications to the config file.
Option3: Leave it just like that, this is enough for us.

Feedback and contributions will tell us which option is best

## Release 0.0.2

**Features**

Doesn't break the hand-crafted Proxmox server.

**Bugfixes**

Lots of trivial syntax bugs and missing packages from the minimal install.

**Known Issues**

The network configuration template still requires a lot of work (it only works on our server for now)


## Release 0.0.1

**Features**

Direct transcript of the work described here : https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Buster
No test, nothing.

**Bugfixes**

None. Creating a bunch of them.

**Known Issues**

None. Creating a bunch of them too...