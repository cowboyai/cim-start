# CIM
The Composable Information Machine

CIM is an architecture built to work with today's global and soon to be interplanetary information.
We have massive satellite networks and regular communication off-planet.

So how does my thumb-drive send information to Mars?

Really, that isn't something we have to deal with... yet.

Ok, how about how do I send something to Japan from a ranch in Montana as fast as possible?
Satellites, so we are regularly moving things around the globe using off-world technologies.
Did you know you can launch and deploy your own satellite now for $10,000? That's the cost of a single in-house server or about a year of cloud storage for 1 TB of data in 2024. Why are we still living in 1980s technology?

Most of our techniques for Information were developed before the Internet even existed. We have learned quite a lot since then and Academia has mostly kept up and produced marvelous papers about how we can do things better. Moore's Law finally caught up and both compute power and network speeds are faster, faster than local access in a lot of cases. There's an App for that... and usually that means trapping me into yet another account and yet another data source to contend with and usually another payment.

Where do I put all this... typically it is getting scattered all over the internet, even internationally, usually under some vendor's control and they don't have export or simple eventing available outside their "app".

This is a serious problem.

Fortunately, the litany of valid applications have direct APIs we can talk to and then we wrap the API in our Cmd/Qry/Evt pattern using [Comms](./comms.md) and suddenly, we can talk to any application.

Do I really have to wrap every API?
You are already doing it, we just make that whole process a simple mapping exercise that can usually be accomplished through automation.
If you are using vendor products, you already need to authenticate, speak to a particular location, and use a structure to speak.

We again, wrap this into a configuration and composition to allow access to any API through the messaging system.

## Canonic Message Model
We will be forming a Canonic Message Model for the Domain.
This is a map of all the possible messages that may be sent through the system.
It's like a registry for your functionality inside the Domain.

This aids not only in discovery, such as how can I work with a street address, but also for directing any Entity to be able to have access to this functionality throughout the Domain.

If you have done development in the past... How many times do I need to define functionality for Phone Numbers or Zip Codes... Or do very basic functionality on a collection of data, like sorting and mapping.

Our Domain Message Model is the map of Domain Functionality.

When we have access to information it is usually packaged with an API to the source.

Typically, we have been taught things like:
  Create a Web Site
  Hook it up to a SQL Database
  Profit

This is all great marketing fluff until you need to actually implement it.

Today's information access is different:
  - Most things have an API (seriously, we fought this battle for 25+ years...)
  - The Internet is really fast
  - Storage is cheap
  - Compute is a commodity

I don't have to lose my mind trying to build a datacenter to run these things, incremental, pay-as-you-go service is generally available worldwide. Cost structures can be compared in real-time. Flash mobs are a thing... massive scale-up, scale-down in real-time is needed.

But how do I make my information available, even to me.

This is an issue. A big one.

We have been doing our best to move these crates of data around in our business and personal lives for ever.
I am tired of the old tradition of:
-  Setup a system
-  Test it for validity
-  Make a golden production copy
-  Back it up, on 3 medias in 3 places
-  deploy to production
-  oops, type...
-  repeat above cycle...

That just doesn't work anymore.
-  Configure
-  Test
-  Commit
-  CI/CD does the rest

Additionally:

I have information all over the place...
I need to collect it, modify it and move it around.
Even if I leave it at Vendor X, I want to access it from other "apps"
How can I make all these "apps" talk to each other without coding all this manually?
Comms does that. It does ETL, Projections, Queries and anything else you need to access data and share it over the entire Domain.
It also does it with Zero-trust, every message is scrutinized, so you can be assured of security.
Comms uses Certificates, so all communication is secured and encrypted.
It load balances and scales for you.
If you need durable persistance everywhere, it can provide that too.
Comms is how you work with Commands, Queries and Events.
How can it do all this?

With a Domain Model built directly from a Business Model.

### What about the Business Model?
The term business model refers to a company's plan for making a profit. It identifies the products or services the business plans to sell, its identified target market, and any anticipated expenses.

We add these academic ideas to a relationship with the Business Model:
  - Domain Driven Design
  - Messaging
  - People
  - Organizations
  - Portable Content-Addressed Data
  - Resource Management
  - Event Sourcing
  - Continuous Deliver
  - Continuous Integration
  - Functional Reactive Programming

That is a lot to take in, even at a high level.

The good news is: We have Sage... a tool incorporating a responsive AI system that allows you to ask questions about how all this stuff works. Immediately get started with building your model. Sage is quite a lot more than a co-pilot. It is an interactive Agent fully capable of executing any Command or Query in the CIM and responds with Events.

Let's look at an example:

![CIM - Inventory](./CIM-Inventory.svg)

That is quite a lot of information to understand, and this is a simple base example. In a real Business Model this will have thousands of relationships and more nodes broken down into individual Domain Parts.

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

Open your git repository.

We have few files, mainly, flake.nix, sitting in a git repository and that gives us the ability to start a compute resource, we can ignore the hardware for now.

Where do I run this?

We prefer a system running NixOS. This can be a VM or Metal, Docker works but has issues.
If you have never run NixOS, or for some reason prefer not to, ANY linux system is viable running nix package manager.
Basically, anywhere you can get a shell running Nix.

For Windows WSL2 see [NixOS-WSL]([htt](https://github.com/nix-community/NixOS-WSL))

If you already have NixOS installed, which is always preferred simply open a terminal and either nix develop or direnv allow.
On NixOS we use [direnv](https://direnv.net/), which is part of the flake, but if it's not already there, you'll need to add it to your NixOS systemEnvironment.

Codespaces currently aren't working on pure NixOS, we are working on a solution, we can do it with Alpine and nix.
On https://github.com/TheCowboyAI/cim-start, click "use this template, and choose "open in a codespace"
We will remove the not working comment in devcontainer.json when Codespaces work

If you need another alternative:
  Docker ** coming soon...
  Virtual Machine
  - run the build.sh script to build a vm
  - or download it [here]() 

[Flakes](./Flake.md)

