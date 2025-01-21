# Initial Construction
This represents our initial construct and we will quickly outgrow this format.

We need to preserve our base of operation and how we are establishing an information system.

This consists of the initial Domain, People, Organizations and Inventory.

From here a CIM will be constructed.

Then the CIM can take over the information, but we need to construct the CIM and this is how we do that.

A set of YAML files describes our initial operation.

The uuids can be left empty and we will apply a policy to it to construct the working results.

## Machines

## Network

## Modules

## Configurations

## Derivations

## People
- People require a relationship to a user.
- Organizations require a relationship to an Account
- Operator requires a relationship to an Organization

All authentication is multi-level. All of the security modes have an accounts level with users belonging to those accounts. The decentralized JWT Authentication also has an operator to which the accounts belong.

Each account has its own independent subject namespace: a message published on subject 'foo' in one account will not be seen by subscribers to 'foo' in other accounts. Accounts can however define exports and imports of subject(s) streams as well as expose request-reply services between accounts. Users within an account will share the same subject namespace but can be restricted to only be able to publish-subscribe to specific subjects.

Roles are hierarchical and form a chain of trust. Operators issue Accounts which in turn issue Users. Servers trust specific Operators. If an account is issued by an operator that is trusted, account users are trusted.

![Authorization graph](../doc/Authorization%20graph.svg)

The directions in this graph are important, they are acyclic and stem from person.

In this system a person is responsible for every message. If you are operating an agent, you own the message.

Operators, Accounts and Users are in ../compute/nats/nats-init.sh

# Organizations
I have added a few organizations derived from the equipment we have declared in our inventory.

We have to manage how we talk to these organizations and what information we exchange, this will be the same for every organization we encounter.

Organizations afterall are usually made of people.

They can also be made of other organizations or Agents of organizations.

It's a flexible model and one you may adapt in any way you see fit.

The key here is that organizations own Operators and Accounts.

People and Agents are Users.

Agents ALWAYS have an associated person ultimately responsible for anything they do.

# Inventory
This is where we get very specific.

We are giving real details on real equipment and it will end up in some database somewhere and we want to know how it got there and how we get new updated information.

How we obtain this information is done in many ways, what we want to do is clarify our process. If that means sit at the equipment and copy it into this format, then that is the process, if it is go to a specific site or invoice to gain the information, then that is the process, we just need to know what it is and that it is documented for the person who is supposed to do this, even you. We expect this all to be very fluid, but we also need a starting point.

If you deviate here, you eliminate you process from the start.

Stick with the process, it will prove itself very soon.

We want to include absolutely minimal information that is required to build our machine.

We need to identify parts, but the details, or the metadata, can all come later.

We don't want this to be cryptic, we have a name, a serial number of some kind, and a uuid. Think of Inventory as a way to associate a uuid and a serial number with a common name. It alo declares all this as "parts" meaning we gather more information from parts.yaml.

This is where we get a lot more specific, by device part, kits like a computers made of individual parts are simply nested when they are contained and siblings when "plugged in" such as a usb device.

A device is anything you intend to be part of this cim that stands alone (but is probably made of other parts we identify). It is also something we can replace or add/remove other parts from.

Cloud ends up a bit different, the resources are already defined and not things we have to do anything with but instantiate.

Parts is where we detail our initial hardware inventory and we hope it is this small, because adding things later is much easier.n We have tools like netbox that can get very granular on all this and we can choose that as an option after we have built the Domain.

This isn't supposed to be a database, but it will help you understand why we need them and how to populate and query them. We have much better tooling to be applied later, we just need the launch vehicle.

Now we have our Domain defined in some crude yaml and several nix files.

Since you will need the internet to do anything truly useful, let's configure the Domain over a network using nixos-anywhere.

We will match our Domain to the hardware and the software then generate a running system.

Review everything in [domain](./) and be sure it is adjusted as needed for your application domain.

Review [vhost-dev](../vhosts/x86/vhost-dev/) to understand what is being built. 

