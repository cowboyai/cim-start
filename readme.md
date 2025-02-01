## **Introduction to Building a CIM with NixOS**

This guide introduces a template for creating a **Composable Information Machine (CIM)** using [NixOS](https://nixos.org). CIM is designed for developers who want to build systems based on **Domain-Driven Design (DDD)** and **Event Sourcing**. If these paradigms are not part of your goals, this structure may not be suitable for you.

NONE of this belongs in Nix or NixOS proper.
We DO want it all to be a specific group of modules, based on NixOS, used in a special way to achieve something specific: A CIM.

Awesome, let's edit some code...

Hold on pardner... This is about Abstraction.

We have 3 levels of Application Development State:
dev:
  - project branch is experimental and not tested for production release
  - CI/CD pipeline is incomplete
  - WE ARE CURRENTLY HERE
  - internal distribution for comments
  - `dev` git branch (or personal branch, feature branch, etc.)
  - `alpha` - pre 1.0 untested
test:
  - in testing
  - tests are written, but not finished or passing
  - CI/CD pipeline are functioning
  - approved for limited distribution
  - actively tested by the end customer
  - `test` git branch
  - `beta` - pre 1.0 in testing
prod:
  - tests pass in the CI/CD pipeline
  - approval for wide distribution
  - actively used by the end customer
  - `main` git branch
  - `release > 1.0`

These flow states may sound familiar.

They are the most prominent in software development and you should respect those linguistic models.
I don't mean what "most companies" use... I mean the Developers... almost all of the devs I work with call it "dev", "test" and "prod" no matter what your company calls it.

If you decide you are going to change them, expect other people to call them something else.

If you call test "beta" and prod "gamma" it may have different meaning than "in testing" and "production". This is actually fine, IF and Only If your entire team agrees. Otherwise we are going to be getting requests for the "beta" release of something and it's meaning may be ambiguous.

# Rust
We are also ***VERY*** [rust](https://www.rust-lang.org/)-centric here

All of our samples revolve around nix and rust.

That doesn't mean you can't use go, python, .net, haskell, javascript, or anything else... just "package" those as NixOS packages and modules and they will operate just fine in this ecosystem.

## **DISCLAIMER** 
This is a `Pre-Alpha Edition`.

We need to set some `ground rules` for how we build things.

Expect the API here to change until we reach a stable release candidate, then it will be fairly rigid for core operations.

Every version can be `pinned` or `locked` in Nix and we will take advantage of that.

We are going to be very opinionated about what goes where and how... Even how you name things, after all we are building languages.

If you have 5 machines, don't do this.
If you have 50... or 500... or 5000... please continue.

This isn't about [ricing a desktop](https://www.reddit.com/r/unixporn/), it's about managing a distributed system and building real-world business software. A distributed system by nature means it has a purpose and it is made from "parts" on separate "machines" connected to make a whole.

>"Distributed system management refers to the process of overseeing and controlling the operation, configuration, and performance of distributed systems. It involves managing the various components, nodes, and resources that make up the distributed system to ensure its reliable, efficient, and secure operation." [geeks for geeks](https://www.geeksforgeeks.org/distributed-system-management/)

Isn't that what kubernetes is?
>"Kubernetes is an open-source platform that automates the management, deployment, and scaling of containerized applications. It's also known as "k8s". 
"
note, `containerized` applications... not "composed application systems as a complete and separate whole", that is what a CIM does.

A CIM is by definition a `greenfield` application, meaning it is something new and not created by refactoring a previous application.

CIM *uses* and is *fed by* other "applications", but every new "CIM" is a new set of Objects and Events stored in a sequential, immutable pattern.

Many CIMs are orchestrated to communicate with each other to compose bigger information machines or to scale effectively.

### **What is CIM?**
CIM is an architectural approach that reimagines how distributed systems are built. It emphasizes:

- **Domain-Driven Design (DDD):** A methodology that aligns software design with the core business domain by modeling its concepts explicitly[2].
We use the definitions as described by Eric Evans.
[What is Domain Driven Design?](https://www.youtube.com/watch?v=pMuiVlnGqjk)

- **Event Sourcing:** A pattern that records all changes in the system as a series of immutable events, providing a complete history of state changes[8].
We use the definitions as described by [Greg Young](https://github.com/gregoryyoung).
[What is Event Sourcing?](https://youtu.be/8JKjvY4etTY?si=Mqy47CZrH8QACK3U)
Additionally, we heavily use the [CQRS](https://www.youtube.com/watch?v=LDW0QWie21s) pattern as described by Greg Young.

- **Modular Construction**
At its core, CIM leverages NixOS's unique capabilities to create deterministic, reproducible, and modular systems. 
[Flake Schemas](https://youtu.be/ChaJY0V4ElM?si=JhDplvBRxeWNqWom)

Our CIM approach introduces a structured way to use just **Nix Flakes** - organizing everything around the concept of *domains*.

We will talk about things like how to manage applications we build, applications we use, and applications we serve.

There are many other ways to do this, and unless you really want to work with Domains and Event Sourcing, those may be more appropriate for your needs.

From instatiation, we are using DDD and Eventsourcing.

[Structuring with Nix](./doc/structuring-nix.md)

---

## **Key Concepts**
CIM may sound academic, but it is heavily drawn from the deep experience of "Domain Experts" in building and running computer hardware and software over the last 50 years.

CIM is rooted in [Applied Category Theory](https://en.wikipedia.org/wiki/Applied_category_theory), the real-world application of specific mathematical principles across domains.

### **Domains in CIM**
A *domain* represents a specific area of concern or functionality in your system. For example:
- In DDD, domains model your business logic.
- In NixOS, domains structure configurations for hosts, users, networks, etc.
- Both work with Organizations, People, Inventory and Events.

# Discovery

By injecting domains into the Nix ecosystem, we can relate all aspects of configuration and infrastructure directly to the domain they belong to. This creates a clean separation between:
- The **Nix Domain:** The foundational tools and abstractions provided by Nix. i.e. nixosConfiguration
- Your **Application Domain:** The specific logic and configurations you define for your system. i.e. Website
- Your **Business Domain:** The specific logic and configurations you define for your business. i.e. Employees

There are others, but we start here.

This separation ensures clarity and modularity while enabling seamless interaction between different domains.

Deciding what goes where is something we want to determine, and not tell our programmers (including ourselves) to go look it up at [nixos.org]

Nix doesn't really care how you write a flake.nix other than "put them in inputs and outputs"

How you `slice and dice` a flake is totally up to you.

We are going to provide a structure for them, how do I get a package, how do I configure it, where do I edit things, why shouldn't I put a hard string here, *how in the heck to I access this attribute!* and all that sort of guidance.

We aren't taking your freedom away, we want to make it much easier to *choose* your own approach and be able to make it easier to implement.

---

### **Why Use Nix Flakes?**
[Nix Flakes](https://nixos.org/manual/nix/stable/#flakes) provide:
- A standardized structure for projects.
- Version pinning for dependencies via `flake.lock`, ensuring reproducibility.
- A clear way to define inputs (dependencies) and outputs (packages, modules, configurations).

In the context of CIM:
1. The **flake.nix** file becomes the root of a system hierarchy.
2. Domains are explicitly defined and partitioned, rather than being in one giant file, or scattered across arbitrary semi-structured files, they are `modularized`.

We further use [flake-parts](./doc/parts.nix) to enhance our modular approach. you should be familiar with [https://flake.parts/best-practices-for-module-writing]

We have an opinionated way we interpret Nix and NixOS into Domains. This opinion closely follows the work of "Domain Experts" and we document that where appropriate.

We aren't changing anything about Nix or NixOS, we are simply declaring how we intend to use them in a specific way.

This is painstakingly modeled around our interpretation of the the intent of Nix as proposed here:
-[Official Nix Reference Manual](https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-flake)
-[Writing Modules](https://nixos.org/manual/nixos/stable/#sec-writing-modules)

In other words, the official recommendations.

`nix` is often refered to as a "package manager" but it's actually a Language and there is also a package manager called "nixpkgs" which uses nix.

`nix` (the language) is the glue that holds this all together.

### Nix Architecture:
git repo
flake
  - modules
  - overlays
  - packages
  - configurations
  - ci/cd

Flakes now hold everything, in modules.

So is a flake a module or do I put modules in a flake?
Yes.

Flakes are recursive ways of looking at a git repo.

See [How we use NixOS](cim-and-nixos.md) for even more details.
---

## **How CIM Organizes NixOS Configurations**

Traditional NixOS setups often rely on two main files: `hardware-configuration.nix` and `configuration.nix`. These files can quickly become cluttered as your system grows. While there is no official standard on architecture, CIM introduces a domain-based structure to improve clarity and maintainability.

### **Proposed Structure**
Here’s what a domain-based setup might look like:

```
flake.nix
├── domain/
|   ├──names/
|   ├──organizations/
|   ├──people/
|   ├──locations/
|   ├──inventory/
|   |  ├──accounts/
|   |  ├──secrets/
|   |  ├──sourcecode/
|   |  ├──devices/
|   |  └──equipment/
|   ├──networks/
|   |  ├──people/
|   |  └──equipment/
|   ├──policies/
|   |  ├──authorization/
|   |  └──authentication/
|   ├──procedures/
|   |  ├──constants/
|   |  ├──commands/
|   |  └──queries/
|   ├──events/
|   └──relationships/
├── hosts/
├── homes/
├── modules/
|   ├──services/
|   ├──programs/
|   └──environments/
├── networks/
├── shells/
└── users/
```
You are surely going to expand these, this is the base of what a CIM needs to function properly.

You don't have to fill this all out at once (and we won't), everything but a few basic options all have defaults. The more you fill out, the more we can use with Nix.

NOW, take out all those folders, and put them in their own flakes.

That's right, flakes are just assemblies of other flakes.
You can put them together in git-submodules too.

This is an evolutionary system, we expect it to:
1. start with an empty base
2. allow you to just add config files and rebuild
3. build everything piece by piece
4. show everything that is built
5. help understand what we just built
6. help us build more things

Each flake corresponds to a specific domain:
- **domain**: Core domain logic.
- **homes**: User-specific configurations (e.g., home-manager setups).
- **hosts**: Host-specific configurations for local or remote machines.
- **nodes**: Specific configurations without an implied host.
- **networks**: Network-related settings (e.g., DNS, firewall rules).
- **modules**: Modular reusable configurations.
- **shells**: Development environments or shell configurations.
- **users**: User accounts and permissions.

These are all going to cross communicate like spaghetti.
Domain single-responsibility keeps it straight.

They all live in their own git repo and have boundaries.

Each Sub-domain should be as generic as possible while still being a specific category. Hierarchy becomes very important.

This structure ensures that configurations are logically grouped by their purpose, making it easier to manage complex systems.

`Atomization` by `git repo` ensures code clarity and boundaries. Flakes treat these as independent modules.

---

## **Advantages of This Approach**

1. **Domain Integrity:** By partitioning configurations into domains, you ensure that each part of the system is self-contained and well-defined.
2. **Reproducibility:** Using flakes guarantees that your system builds consistently across environments.
3. **Scalability:** The modular design makes it easier to extend or modify individual domains without affecting others. This is the whole idea behind this approach... As my domains increase, how can I understand the scale. 
***Don't abandon me after `hello world.`***
4. **Enhanced Understanding:** Visual aids and clear separation between domains improve comprehension of the overall system architecture.

---

## **Getting Started**
To begin building your CIM with this structure, create a new git repository then:
1. Generate this template: `nix flake init --template github:thecowboyai/templates#cim` then, 
2. If you are targetting metal, use `just generate` This will generate an initial NixOS configuration using `nixos-generate-config` if you are using hardware. (you can run this in a virtual environment and control other systems that don't need hardware, a.k.a. the cloud.)
2.a. better automation coming soon.
3. Your `flake.nix` file is the entry point for managing these domains. You start with a devshell... to actually make a NixOS configuration, you will need to complete a few more steps, like adding your preferred settings. 

This approach is not about replacing tools like `home-manager` but about extending them with domain-driven organization tailored for distributed systems.

The system will actually guide you through this if you need it to.

[Guide](./docs/guide.md)

To Start, just open a terminal in the flake.nix folder.

type:
```bash
direnv allow
```

This will build the devshell.

Now we can initialize a system. 

We initialize, by starting it.

```bash
`just run`
```

>"You are free to use any part of the system, or even replace it. Your mileage may vary, depending on how tightly you adhere to these principles."

You have a model to work with to make it a module and use it.

---

By adopting this methodology, you’re not just configuring a Linux system—you’re creating a robust framework for building scalable, maintainable distributed systems with NixOS at its core.

Citations:
[1] https://nixos.org
[2] https://www.geeksforgeeks.org/domain-driven-design-ddd/
[3] https://dax.dk/cim-nmm-event-sourcing/
[4] https://www.youtube.com/watch?v=kYVBwIB56Xg
[5] https://www.reddit.com/r/NixOS/comments/yj3xrv/hard_user_separation_with_nixos/
[7] https://en.wikipedia.org/wiki/Domain_separation
[8] https://www.kurrent.io/event-sourcing
[9] https://www.sec.gov/Archives/edgar/data/312070/000095010319015431/0000950103-19-015431.txt
[10] https://github.com/oskardudycz/EventSourcing.NetCore
[11] https://www.youtube.com/watch?v=gvW9uJSFujA
[12] https://eventsourcing.readthedocs.io/en/v9.0.3/topics/introduction.html
[13] https://www.sec.gov/Archives/edgar/data/1022079/000094787112000745/0000947871-12-000745.txt
[14] https://www.kenneth-truyers.net/2013/12/05/introduction-to-domain-driven-design-cqrs-and-event-sourcing/
[15] https://www.reddit.com/r/NixOS/comments/131fvqs/can_someone_explain_to_me_what_a_flake_is_like_im/
[16] https://github.com/NixOS/nix/issues/3843
[17] https://jade.fyi/blog/flakes-arent-real/
[18] https://dev.to/stablejoy/flake-my-life-how-do-nix-flakes-work-2foe
[19] https://www.tweag.io/blog/2020-05-25-flakes/
[20] https://danilafe.com/blog/blog_with_nix/
[21] https://zero-to-nix.com/concepts/flakes/
[22] https://guekka.github.io/nixos-server-2/
[23] https://jameswillia.ms/posts/flake-line-by-line.html
[24] http://ghedam.at/a-tour-of-nix-flakes
[25] https://dev.to/arnu515/getting-started-with-nix-and-nix-flakes-mml
[26] https://www.globalknowledge.com/en-gb/products/servicenow/sndsi-od
[27] https://sagikazarmark.hu/blog/manage-certificates-on-nixos-using-acme-and-google-domains/
[28] https://releases.nixos.org/nix/nix-1.5.2/manual.pdf
[29] https://github.com/NixOS/nixpkgs/issues/94011
[30] https://jin.crypt.sg/files/nixos-deep-dive.pdf