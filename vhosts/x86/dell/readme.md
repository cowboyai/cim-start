# Installing on x86
This is for any machine running an x86 processor.

First, let's talk about what we are going to do...
1.  Define our hardware
2.  Create a hardware-configuration
3.  Create a configuration (software)
4.  Test the configuration
5.  Deploy to ISO

## ISO
Why ISO?
On our initial machine we have nothing running and installing over a network is literally impossible because we aren't plugging into a known network.

Sure, if you already have a running network, we "could" use that, but then we are susceptible to any problems already on that network.

CIM is a fresh, new, declarative installation and we didn't declare any existing networks nor can we if we want a clean system.

We will however, build this using ANY system running Nix.
Everything else is declared, we just need somewhere to generate a system. Currently we use a stock NixOS Live Image to just start the system and generate a declarative ISO. 

## Flake.nix
This flake gets a minimal installer from the network, and builds an image that will boot into a live environment, then install itself.

We will create an OS Drive used exclusively for the Hypervisor and virtual images.

We will set all the other attached storage devices to be available for virtual systems running on the host.

We will also harden the system to only support this hardware. A change to hardware (even attaching a usb device) will require a pushed update as we will turn off the ability to do so locally for security reasons.

The Hypervisor doesn't really do anything compute-wise and this is good, it just serves other containers. We don't want any unauthorized containers either, so deployment must come from the Domain.

We switched to hypervisors for everything years ago.
Even our bare metal just gets a hypervisor and everything else is virtual. The actual latency to the hardware is nearly undetectable now.

I do recall when virtualization was a 30% performance hit. That is just not so any more and with optimized tuning can get as low as an undetectable 1%. If that is still too slow, buy faster hardware.

The benefits of having everything separated this way far outweighs the small performance hit for switching in the cpu. Vendors have worked for more than a decade to make hypervisor performance optimal.

We have found very few cases where this may not hold and we need every ounce of performance out of the system. These are truly outliers and should be treated as special cases.

The only real difference is that it will be a dedicated system and you won't be able to simply swap to a new environment in a container or load other containers there. This is perfectly fine. It is treated as any other non-host system.

The Flake here is minimal and made to operate a Virtual Host and monitor the guests. This ends up similar to how we use VMWare Fusion or Proxmox with everything based for us in NixOS.

NixOS alone leaves us to decide how to manage multiple machines.

There are maybe a dozen different ways we have seen to do this and none of them are fitting our model well.

We have decided to abstract that out of NixOS and keep it in agnostic configurations that can generate a NixOS Flake for us.

We already have things like ansible and terraform, but those don't actually do what we want, they are great for deployment ,but how do I manage all this stuff I want to deploy?

That is where we step in and make our Inventory for the CIM.

While we don't have that setup yet, we still make the same decisions, they just get saved into the git repository until such time as we have the Inventory System ready to import our system.

If we try to "auto-detect" everything, then it is no longer declarative.
The software will be, but we want it for the hardware too.

This mean basically that I need to create my hardware-config from previously known information, not something I detect on boot.

If you DO need to do this, run the standard NixOS Live Image, detect the hardware, and save it to the git repository.

Then we can use it to build an installable ISO image.

What I mean here is:
  - Detecting Hardware should be done ONCE and then saved.
  - Hardware changes are something we want to manage, not detect.
  - We want to simplify this, but also allow any conceivable configuration
  - We want to remove manual steps to installation whenever possible

When we buy equipment, we always specify the hardware or at least know what we get.
When I deploy this hardware, it doesn't change.
Why would I want to detect everyting on every boot?
We don't that is how people plug in USB devices and hack you.

If it won't boot from the specification we have provided, then that is our fault and not a failure in detection.

## Collecting the right information
When building equipment, we already know what we are putting into the system. We simply create a digital version of that specification we can use for programming.

### What to collect:
  - Unique IDs (serial number, asset tag, service tag and similar)
  - CPU
  - Memory
  - BIOS Type (legacy or UEFI)
  - Storage
  - Networking

Just start here and add anything else later. We will extract a ton of metadata about our hardware to use in configurations once they are running.

# Networking
Let's discuss networking first.
We want a private address space.
We also want to isolate different services (micro or not...) into their own network for security and internal simplicity.

This network is 192.168.100.0/29
This means:
  - 192.168.100.0 is the network identifier
  - 192.168.100.1 is the gateway to other networks
  - 192.168.100.2 is available as a host
  - 192.168.100.3 is available as a host
  - 192.168.100.4 is available as a host
  - 192.168.100.5 is available as a host
  - 192.168.100.6 is available as a host
  - 192.168.100.7 is the broadcast address

This is meant to be an isolated local address.

We will work with public addresses when we configure DNS.

We will typically make .1 the gateway, which is a router, so it's not really a host address, but could be if you use software routing.

this leaves us 5 usable addresses and we will fill those up so nothing else can join this network.

We do not want DHCP getting in the way so we disable it everywhere.

DHCP while convenient, is a giant security hole. Containers are all software. This means I can set a MAC Address and game the system.

Dynamic things are wonderful on non-deterministic systems. For us, we want to know exactly how things are set and that they can't change dynamically on a rebot, such as a changing dhcp address.

With hardware, there are some unavoidable manual steps... like turning the power on that we just can't avoid until we have a network established.

Configuring machine #1 is always going to require some manual steps until we can have robots do it.

What we want to avoid is sitting at a computer and manually entering a bunch of data, then hopefully writing it all down.

We want to write it all down first, then establish that as our configuration.

If it blows up, we fix it until it works... repeatedly.

For example, setting BIOS options is not something easily done outside of the BIOS itself. Yes, we know there are "utilities" to accomplish this, but it is not a guarantee. We will need to establish how we want to handle these situations.

For now, we establish what we set in the BIOS and save that into our git repo. What happens if we set a password in the BIOS? You'd better write it down! I guarantee you, or someone that needs it, will forget.

Just to test our initial configuration, we are going to install it at least twice to be sure it is identical both times.

It is very easy to make things break by editing the BIOS and this is something we need to track specifically.

This is how we get to a determinitic system, one we know all the configurations for and one that our Information Machine can immediately tell us about these settings.

I don't mean information overload, such as here are the 40000 files you are using... But rather, a searchable, intuitive interface to tell my software what hardware is available and something I can deterministically set.

If it's not in the configuration, it should be disabled, but sometimes we can't do that, such as TPM. For these we just need to be certain that they don't change without the Domain being able to determine it has changed.

After all, what is the point of a deterministic configuration if it gets "auto-detected" and changes from boot to boot.

This is the whole point of these flakes...
hardware-configuration.nix is machine specific, configuration.nix isn't.

configuration.nix should work on any vhost we point it to.

If the vhost is using special hardware, then we want to invoke that.

For our Dell Precision 7920, we have to be able to determine what is actually IN the BIOS, and that it is not changing when we reboot.

Dell offers us a utility for this:
[Dell Command](https://www.dell.com/support/contents/en-us/videos/videoplayer/how-to-do-bios-configuration-with-dell-command/dksd4rz8gma)

If you have a different manufacturer, you can check for their BIOS tooling.

we want this version:
[Dell Command cli for Linux](https://dl.dell.com/FOLDER10469726M/1/command-configure_4.11.0-6.ubuntu22_amd64.tar.gz)

eek, this is for Ubuntu and we are running NixOS...
No worries, we just launch this in a container... 
We will come back to this soon.

This isn't something we want permanently installed, basically because it is a really dangerous tool. We also don't want some hybrid OS. When we need it, we simply invoke it, get the data we need, save it and shutdown the container.

What we want to be able to do is deterministically set the BIOS.

We can read it with a program called `dmidecode` and will use this to read any running system. It's a bit more difficult to use and the settings are all in XML, but we can fix that and export to XML.

Dmidecode is a command-line utility in Linux that retrieves and displays hardware information about a system by decoding the data stored in the DMI (Desktop Management Interface) table or SMBIOS (System Management BIOS) table.

[Domain XML Format](https://libvirt.org/formatdomain.html#smbios-system-information)

We want something that can boot, run dmidecode, export the settings and stop. Then we can insert those results into our configurations. (automatically during build most of the time)

I already know what the hardware is, but I don't know the specifics set in the BIOS like Populated PCI Slots, Serial Numbers, and UUIDs. I also need to be able to repeatedly apply settings, remotely if necessary. This is why we need to extract the BIOS information from the hardware and save it in our configuration.

No matter how we decide to do it, we want to extract the bios info and save it.

## WHY???
Because settings like this are frighteningly difficult.

[A GPU Passthrough Setup for NixOS](https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/)

All I want to do is change a setting... 
On equipment I own... That I want to configure any way I want.
That should definitely not be this hard.

We need to simplify by abstracting and deciding what we need to change in a Virtual Machine's description so we don't get unexpected results, like cheat blockers that are so dumb they are easily bypassed and we aren't cheating.

Alright...

What do we actually care about?

```bash
sudo dmidecode | jc --dmidecode -y > cim-vhost.dmi.yaml
```
And we get a readable format we can work with.

This is a HUGE amount of information, most of which we don't really need, but are glad it's present instead of lacking.

### What we want to know
- Serial Numbers
- CPU
- Memory
- Storage
- Network

We want to set this machine up to allow as much as possible to go to the virtual devices and as little as reasonable to the host.

We don't want to starve the host, but instead give it what it needs and no more.  We can start thinking about everything as being replaceable and it won't hurt us.

If I don't have the hardware locally, maybe I need to replicate to the cloud. Either way, you should be able to move things around at will and still have a working system.

Deterministic configuration is the only realistic way to do this.

Some of these BIOS settings will go directly to the hardware-configuration.nix along with other things like the bootloader and storage information.

We can certainly do this manually by just creating a yaml file, but are you seriously going to retype all this stuff? What about for 1000 servers?

We have to automate all this stuff away, but it must be accurate and verifiable. And that is precisely why we save it. We can then verify at any time.

Who turned off HyperThreading?

if someone manually does this, you have no way of tracking it, unless it's in some sort of change management database. We've done this at the corporate level for a very long time... Yes there are automation tools to do this. We simply have to pick one and make that workflow part of our strategy.

dmidecode is just one way, if you have other tooling, such as [percona toolkit](https://manpages.ubuntu.com/manpages/focal/man1/pt-summary.1p.html) or the manufacturer provided tools we mentioned before feel free to use it. Though it may be harder to set it up and extract what we need from it.

No, I am NOT going to tell you to use a particular piece of software, use what makes sense for your Domain.

Just because we use something by default is not an indication it is irreplacable. In 10 Years, this will look quite different, not because we changed our mind, but because technology marches on and you are keeping up with it in a controlled way.




