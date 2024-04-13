# Host
A Host is hardware that is configured to run virtual instances of other machines, runing a hypervisor.

This can be done in hundreds of ways and perhaps you already use VMWare (esxi) or VirtualBox or Xen or HyperV.

We are going to focus on how to do this solely with NixOS. If you already have a way to install hardware, just merge it into this model.

Yes, NixOS can install on any virtual platform, what if we want to define one of those ourselves.

## NixOS as a Hypervisor
This means we want a machine to detect its own hardware, boot into an environment, install NixOS and be ready to accept new deployments.

There are many ways to do this and we can even specify the equipment when we already know what it is.

In this instance, we will detect it and add it to our Inventory.
Then we will add some Accounts and be ready to start deploying things.


