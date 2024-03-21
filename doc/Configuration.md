# Configuration
A typical Domain has a lot of moving parts.

How should we manage these?

CIM places these into configurations, Configurations need to align to each part of the Domain we have defined.  We have Machines, Providers, Software and Hardware all controlled by Configurations.

These compose together to make a working system. It is always a difficult task to even align the resources we have, let alone how they are described, started and moved around the system.

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
Nix flakes provide a standard way to write Nix expressions (and therefore packages) whose dependencies are version-pinned in a lock file, improving reproducibility of Nix installations. The experimental nix CLI lets you evaluate or build an expression contained within a flake, install a derivation from a flake into an User Environment, and operate on flake outputs much like the original nix-{build,eval,...} commands would.

  - A flake refers to a file-system tree whose root directory contains the Nix file specification called flake.nix.
  - An installation may contain any number of flakes, independent of each other or even call each other.
  - The contents of flake.nix file follow the uniform naming schema for expressing packages and dependencies on Nix.
  - Flakes use the standard Nix protocols, including the URL-like syntax for specifying repositories and package names.
  - To simplify the long URL syntax with shorter names, flakes uses a registry of symbolic identifiers.
  - Flakes also allow for locking references and versions that can then be easily queried and updated programmatically.
  - Nix command-line interface accepts flake references for expressions that build, run, and deploy packages.

Flakes are how we create environments, every environment is housed in a git repository.

The flake in this repository creates a Neo4j environment for us to work in and has the necessary information encapsulated to assure that environment runs. If we need to create a project and deploy it, same format.

This abstract way to reason about our equipment helps considerably when we look at things like Inventory and Resources. Frequently I don't care about the hardware, just run this piece of functionality. In today's inter-connected world, we can certainly do that which much less effort than we did in the past.

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

# CIM
The Composable Information Machine

CIM is an architecture built to work with today's global and soon to be interplanetary information.
We have massive satellite networks and regular communication off-planet.

So how does my thumb-drive send information to Mars?

Really, that isn't something we have to deal with... yet.

Ok, how about how do I send something to Japan from California as fast as possible?
Satellites, so we are regularly moving things around the globe using off-world technologies.
Did you know you can launch and deploy your own satellite no for $10,000? That's the cost of a single in-house server or about a year of cloud storage for 1 TB of data.

Most of our techniques for Information were developed before the Internet even existed. We have learned quite a lot since then and Academia has mostly kept up and produced marvelous papers about how we can do things better. Moore's Law finally caught up and both compute power and network speeds are faster, faster than local access in a lot of cases. 

### What about the Business Model?
The term business model refers to a company's plan for making a profit. It identifies the products or services the business plans to sell, its identified target market, and any anticipated expenses.

We add these academic ideas to a relationship with the Business Model:
  - Domain Driven Design
  - People
  - Organizations
  - Portable Content-Addressed Data
  - Resource Management
  - Event Sourcing
  - Continuous Deliver
  - Continuous Integration
  - Functional Reactive Programming

That is a lot to take in, even at a high level.

The good news is: We have Sage... a tool incorporating a responsive AI system that allows you to ask questions about how all this stuff works immediately and get started with building your model. Sage is quite a lot more than a co-pilot. It is an interactive Agent fully capable of executing and Command or Query into the CIM and responds with Events.

Let's look at an example:

![CIM - Inventory](./CIM-Inventory.svg)

That is quite a lot of information to understand. This is a simple base example. In a real Business Model this will have thousands of relationships and more nodes broken down into individual Domain Parts.

The advantage of doing all this in a graph and translating it, gives us an extremely flexible framework for change while maintaining order and discipline.

The bottom Nodes for IT Resources will be a list of Hardware and a set of Configurations.
The Top nodes are Domains and Organizations.  While these are not strictly hierarchical, they are definitely directed graphs.

We leverage [git](https://git-scm.com/) to manage configurations along with their documentation and tests.  git is a universal tool that operates on Content-Addresses (a commit) and fits our model for portability. Guess what git's model is... a Graph. We are seeing this more and more in the information world.

git resources can live in simple Object Stores and we can maintain them simply without the need for github or gitlab. If you want to use those tools, you are more than welcome to, but they are not required. git is. We can store git repositories in an S3 bucket and basically have the same thing as github if we add a front-end to it.

With git at our disposal, we have a reliable source for our Configurations no matter what form they may take, they will be version controlled, we can perform actions (commands) and ask questions (query).

Our structure starts like this:
1.  create a git repository anywhere
2.  make configurations (i.e. flake.nix)
3.  commit them

That's it. That is all we need to start.

Changes are stored in the git repository and we may query them, or project them into a Domain Event Stream at any time. git enables us to persist our configuration in a reliable, portable, version controlled way. If you want a different repository, you will need to figure out how to make it Content-Addressable and store an Event Stream of changes. git already does this, and is available universally.

We can now start from an empty git repository and walk through building a Domain CIM.

The Domain CIM is your base, in which you will contain your Business Model for the Domain, the Domain Model.  We separate the Domain Model and the Business Model for distribution and clarity, some Business Models will contain several Domains and some Domains will contain several Business Models.

From here we can grow to sub modules and projects that connect to the Domain Model.
Since this is git, it's already distributed, you just need some replicas.

This is the model we want to think about.  We are creating a Business Model and a Domain Model, its all stored in a self contained, distributed bucket, from there we can relate to everything required to make this a successful venture.

We will be extracting a Ubiquitous Language as we add to the CIM.
CIM is designed to understand your entire Model and help you build it.
While CIM is indeed an architectural concept, Cowboy AI provides a wide assortment of tooling to help you get everything in the architecture up and running.

We start with git, and build our first Model, a NixOS Compute Environment.
This is where we can run and test our Domain Model. You don't even need to own a computer to do this, it is all available online, you just need a browser.

This sounds like utter magic.

Recall:
> "Any sufficiently advanced technology is indistinguishable from magic." - Arthur C. Clark

That really means: when you learn the technology, it's no longer "magic".

Open flake.nix and copy it's contents into your new git repository.

```bash
git commit -m init
```

We now have single file, flake.nix, sitting in a git repository and that gives us the ability to start a compute resource, we can ignore the hardware for now.

Where do I run this?

Anywhere you can get a shell(running NixOS), or use a Codespace for now.
Let's look at a Codespace.

Open https://github.com and go to your account.

If you already have NixOS installed, simply open a terminal.
On NixOS we use direnv, which is part of the flake, but if it's not already there, you'll need to add it to your NixOS systemEnvironment.

[Flakes](./Flake.md)

