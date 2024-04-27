# Hosts
A Host is hardware that is configured to run virtual instances of other machines, runing a hypervisor.

This can be done in hundreds of ways and perhaps you already use VMWare (esxi), VirtualBox, Xen or HyperV.

We are going to focus on how to do this solely with NixOS. If you already have a way to install hardware, you can merge it into this model, but we assume this is going to be a new model. We will support all your configurations, no matter what OS tooling you are using.

Yes, NixOS can install on any virtual platform such as AWS, Azure or GPC, what if we want to define one of those ourselves. Maybe we don't intend to become a provider, but we do need to provide for ourselves. 

## NixOS as a Hypervisor
When you only manage a few systems, it is usually enough to install an OS using a live installer on a USB drive. When dealing with a hundred or more systems, using USB drives becomes unfeasable and solutions like PXE booting become necessary.

We want new equipment to connect to the network, detect its own hardware, boot into an environment, install NixOS and be ready to accept new deployments. We don't want to allow unknown hardware to be able to even attach to the network.

There are many ways to do this and we can even specify the equipment when we already know what it is. This is the model we normally follow. If I own equipment, I already know what it is, I just need to reflect those specifications in my configuration.

Since we have to start somewhere, we will make an Installable Image for USB since that is by far the easiest way to do this initially. We are going to start with metal, meaning a fresh machine you have physical access to.

In this instance, we will detect everything and eventually add it to our Inventory. Then we will add some Accounts and be ready to start deploying things.

For this, we are using a local machine and not the cloud.
There is a separate document to do all this in the cloud alone. 

We won't be copying this to multiple machines, everything after this initial machine will deploy through a network.

We intend to have several hardware systems all link together.

### Hardware
Feel free to use any hardware for this stage:
  - Raspberry Pi
  - Laptop
  - Workstation
  - Server

We will make two paths:
  - ISO Image for USB booting on Intel/AMD
  - SD Image (for Raspberry Pi and AArch_64)

They will all be the same at this stage and only have different capabilities. Honestly, a Raspberry Pi can do all this, just don't expect to visualize a million nodes and have it be fast.

### Workstation / Server

We are using a Dell Precision Workstation 7920 with an added NVidia RTX3080 GPU that we want to pass through (mostly for AI) to containers.

This is a pretty beefy machine, but it's only a single "machine" that we treat as a Host + Guests. 

Getting the hardware specs is pretty easy for a Dell. We simply go to the ServiceTag description at Dell.

But we added a Video Card that is not in the spec.

All we really need to know is:
CPU Model
GPU Model
Memory
Disks

Other things like network interfaces, usb and bluetooth are all automatic via the kernel and don't need to be specified uniquely.

Of cource there are exceptions, and we can add any peripheral devices specs that are required in the configuration.

First we are going to try to detect everything and just let the OS figure it out for us.

We will create an image that will already be setup, we don't want to go through any manual steps like figuring out disk geometries and logical volumes.

That all comes later. First we need a usable base for our Domain that will start holding all our Domain information.

This is a really dumb machine... intentionally.
It runs nothing but other virtual devices.

It will however, report statistics on all the guests it is running and some other host specific information for monitoring, scaling and load balancing.

It will do this by sending messages to a running guest.

The "VHost" is going to act like the cloud for us.
When we have more than one "VHost" you have your own cloud network.
It can work and operate like any of the big iron with you managing it instead of some outside vendor.

Obviously there are caveats... my connection isn't quite as fast as these big guys, but if I need things like they offer, I can add them when we need them. What if my hardware dies, that sort of thing...

I really don't care what happens to the hardware as long as my system can detect it and recover from it immediately.

Our "VHost" is vulnerable to hardware failures as a single instance... To mitigate this, we make a cluster and start having some resilience, and that will come for us very soon after our initial instance. 

### Raspberry Pi

