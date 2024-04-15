# Hosts
A Host is hardware that is configured to run virtual instances of other machines, runing a hypervisor.

This can be done in hundreds of ways and perhaps you already use VMWare (esxi), VirtualBox, Xen or HyperV.

We are going to focus on how to do this solely with NixOS. If you already have a way to install hardware, just merge it into this model.
NixOps will support all your configurations, no matter what OS tooling you are using.

Yes, NixOS can install on any virtual platform such as AWS, Azure or GPC, what if we want to define one of those ourselves. Maybe we don't intend to become a provider, but we do need to provide for ourselves. 

## NixOS as a Hypervisor
This means we want a machine to detect its own hardware, boot into an environment, install NixOS and be ready to accept new deployments.

There are many ways to do this and we can even specify the equipment when we already know what it is. This is the model we normally follow.
If I own equipment, I already know what it is, I just need to reflect those specifications into my configuration.

In this instance, we will detect it and add it to our Inventory.
Then we will add some Accounts and be ready to start deploying things.

We will setup a base Host that is ready to accept our deployments from NixOps.
