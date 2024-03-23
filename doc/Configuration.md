# Configuration
A typical Domain has a lot of moving parts.

How should we manage these?

CIM places these into configurations, Configurations need to align to each part of the Domain we have defined.  We have Machines, Providers, Software and Hardware all controlled by Configurations.

These compose together to make a working system. It is always a difficult task to even align the resources we have, let alone how they are described, started and moved around the system.

```mermaid
graph LR
    A --> B
```

This is where we focus, one thing transitioning to another thing and explaining that in plain language.

We have a large choice of options. Containers are a part of this too.

We can do everything in the Cloud, or we can have everything Local, or a mix of the two.
CIM allows us to perform these operations to fit the business.

Perhaps you already have a large number of configurations and you like the system you use, such as Kubernetes with Terraform or Ansible. You can certainly use those, we simply align those configurations.

We chose to make our Base system a little different.

While we like things like Docker and VMWare and many Operating Systems, we found it worth the trouble to find a common way to do all this.

NixOS is driven by configuration, handles virtual machines as well as containers and can be configured to handle multiple hardware sources for the same software configurations.

This fits well for us, but does have a learning curve.

We use Nix Flakes to configure our OS and Deployments. this gives us a single source to learn, while giving us all the same capabilities the other tools have.

While we won't confine you to NixOS, we can configure anything, including Windows with some extra effort. We will however, be producing all of our samples as NixOS first, then add competing techniques.

## Flakes
Nix flakes provide a standard way to write Nix expressions (and therefore packages) whose dependencies are version-pinned in a lock file, improving reproducibility of Nix installations. The nix CLI lets you evaluate or build an expression contained within a flake, install a derivation from a flake into an User Environment, and operate on flake outputs.

  - A flake refers to a file-system tree whose root directory contains the Nix file specification called flake.nix.
  - An installation may contain any number of flakes, independent of each other or even call each other.
  - The contents of flake.nix file follow the uniform naming schema for expressing packages and dependencies on Nix.
  - Flakes use the standard Nix protocols, including the URL-like syntax for specifying repositories and package names.
  - To simplify the long URL syntax with shorter names, flakes uses a registry of symbolic identifiers.
  - Flakes also allow for locking references and versions that can then be easily queried and updated programmatically.
  - Nix command-line interface accepts flake references for expressions that build, run, and deploy packages.

Flakes are how we create environments, every environment is housed in a git repository.  Flakes can build projects, virtual machines and entire infrastructures. Most of our Flakes will be generated from Domain information.

The flake in this repository creates a Neo4j environment for us to work in and has the necessary information encapsulated to assure that environment runs. If we need to create a project and deploy it, we use same format, we will expand on features as we use them.

This abstract way to reason about our equipment helps considerably when we look at things like Inventory and Resources. Frequently I don't care about the hardware, just run this piece of functionality. In today's inter-connected world, we can certainly do that which much less effort than in the past.

Yet the same problem remains... How do I organize all this? 

We have been relying on all sorts of mainly disconnected ways to manage this:
  - Change Management Database
  - Configuration Database
  - Loose text files on developer machines
  - Spreadsheets
  - Vendor Tools
  - Paper

While these techniques have all been necessary at some time in the past, we can create a better live platform to manage all this and that is what a CIM is doing for us.

CIM is the architecture to help us understand and manage a disparate set of tools and requirements that follow some business function. Then we have a tool to not just look at, but produce the exact same environments when we want to either scale or produce more information.

This seemingly IT management tool ties directly to a Business Model. The Model is the thing, not what it is built with. We can change or experiment with new processes in parallel and see the differences before we decide to deploy those into production.

We can import simple lists into this environment and create entire Domains from a base configuration set plus an Event Stream pushing the data into into that prepared configuration.

This seems like a shockingly different way to work with an Information System than we have been presented previously.

We eschew the idea that "computers" are file systems with processing power and start looking at it as a configured information system plus the ability communicate.

We already have that with any OS + Network protocol, but making that work in Business Terms is almost non-existent. How do we make this better?

1.  Where do I put my Information?
2.  How do I make the Information Reactive?
    1.  How can I Query it?
    2.  How do I Modify it?
    3.  How do I know it was done?
3.  How do I recover from failure?
4.  How does any of this affect the Business?

This used to be a fairly simple set of questions to answer.
Today we have so many choices, that finding one that fits into a business model becomes untenable.

I need to be able to restart my business from scratch. Why? Because that is how we know and can test that the functionality even exists and operates properly in a disaster situation.

What if the business burns to the ground?
What if I get hacked?
What if... What if...
How do I even ask those questions today?

We started with a single big computer that did all this on its own. Then came networking and we could share the load, but this took extra effort to manage (IAM) Identity and Access Management. Then came the flood of software that all tried to manage everything...

Information systems have taken a massive leap in capability in the last decade.
Today we have Cloud, NLP and AI to contend with.
Mobility and Connectivity are truly ubiquitous.
Hardware is a commodity.
Production Grade Software is freely available
Most software remains disconnected and isolated.

Then what is a better architecture for today?

[CIM - the Composable Information Machine](./cim.md)