# proxmox

A "one click" Proxmox installation over a fresh Debian install.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with proxmox](#setup)
    * [What proxmox affects](#what-proxmox-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with proxmox](#beginning-with-proxmox)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The purpose of this module is to provision Proxmox servers at providers who don't offer the option.
You just order a Debian 10, run puppet and voila! You have a default Proxmox server.

We do not plan on adding features for anything that can be done via Proxmox's web interface, command line, terraform... 

## Setup

### What proxmox affects

The module only does one thing, install Proxmox. But Proxmox itself changes a lot of things during the installation process (just look at how long it takes).
So, the resulting product of a successful puppet run should no longer be considered as a Debian, but a Proxmox server.
They have a lot in common, but when you have a specific problem or need, go to Proxmox's documentation first.

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
* puppet-run
* Profit!

## Usage

```
include proxmox
```

## Reference

This section is deprecated. Instead, add reference information to your code as
Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your
module. For details on how to add code comments and generate documentation with
Strings, see the [Puppet Strings documentation][2] and [style guide][3].

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the
root of your module directory and list out each of your module's classes,
defined types, facts, functions, Puppet tasks, task plans, and resource types
and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

* The data type, if applicable.
* A description of what the element does.
* Valid values, if the data type doesn't make it obvious.
* Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other
warnings.

## Development

In the Development section, tell other users the ground rules for contributing
to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel are
necessary or important to include here. Please use the `##` header.

[1]: https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
[2]: https://puppet.com/docs/puppet/latest/puppet_strings.html
[3]: https://puppet.com/docs/puppet/latest/puppet_strings_style.html
