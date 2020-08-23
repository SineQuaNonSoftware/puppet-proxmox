# Changelog

All notable changes to this project will be documented in this file.

## Release 0.1.0

**Features**

Turns a Debian 10 buster minimal into a ProxmoxVE server, in a single puppet run, which includes a reboot to switch kernels and apply the network configuration.

**Bugfixes**

First version to be able to actually get the work done, in a single puppet run.

**Known Issues**

The network configuration template generates 2 bridges/networks you can connect your VMs to:

- vmbr0 has direct access to the network interface, use for VMs that have public IPs
- vmbr1 is a private 10.0.1.0/24 network with NATed access to the internet, use for backend servers, databases, staging environment...

This could be improved by providing a proxmoxbridge custom type where you can specify your exact networks layouts, with or without NAT, DHCP, etc.

But we figured it would be better to provide a working module with sensible default network configuration in 0.1.0, and push that feature to 0.2.0, after we figure out how to document, configure and publish a module on the forge...

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