# Configuration
A typical domain encompasses numerous components, each requiring meticulous management.

CIM organizes these components into configurations that align with every aspect of the defined domain, encompassing machines, providers, software, and hardware, all governed by configurations. This cohesion ensures a functional system, despite the challenge of aligning resources and their management.

Our focus is to facilitate transitions between components, articulating these processes in clear, understandable terms.

```mermaid
graph LR
    A --> B
```

Options abound, including containers. Whether entirely cloud-based, local, or a hybrid, CIM adapts to fit business needs. If you're already using a system like Kubernetes with Terraform or Ansible, CIM can integrate seamlessly with your existing configurations.

We opted for a foundational system that diverges from the norm. While appreciating technologies like Docker and VMware, and Multipass, we sought a unified approach to managing various operations that is essentially Distro agnostic. NixOS, driven by configuration, builds both virtual machines and containers, accommodating multiple hardware configurations for identical software setups.

Nix Flakes form the core of our configuration and deployment strategy, offering a comprehensive framework while maintaining the versatility found in other tools. While NixOS is our preference, we can adapt configurations for any system, including Windows, albeit with extra effort. Our examples primarily feature NixOS, with alternative techniques introduced subsequently.

### Flakes
Nix flakes standardize the creation of Nix expressions, ensuring reproducibility through a version-pinned lock file. They allow for the evaluation, building, and installation of expressions, managing derivations within a user environment, and handling flake outputs.

Flakes encapsulate environments within a git repository, building projects, virtual machines, and infrastructures from domain information. This repository's flake establishes a several virtual environments, including all necessary details for operational assurance. Flake formats are used consistently, with features expanded upon utilization.

We have a series of Flake templates that we will leverage to create these systems. As for "packages" NixOS offers 80,000 linux packages, more than all other providers combined.

Viewing equipment abstractly aids in inventory and resource management, focusing on functionality over hardware specifics. Today's interconnected world simplifies this approach, yet organizing these resources remains a challenge.

When I need a machine to compute a service I wrote, I don't want to be forced to specify things like disk geometries and gui preferences it doesn't even use.

Historically, management relied on various, often disjointed methods:
- Change and configuration databases
- Developer notes and spreadsheets
- Vendor tools
- Paper records

While these methods served past needs, a CIM provides a live platform for more effective management, aligning IT tools and business functions. It not only visualizes but also reproduces environments for scaling or informational expansion, bridging IT management with business modeling.

The challenge lies in aligning technological capabilities with business terms, transforming "computers" from mere file systems with processing power into configured information systems with communicative abilities.

The transition from centralized computing to networked environments and software proliferation has complicated identity and access management (IAM), with information systems advancing significantly in the last decade. Today, we navigate a landscape of cloud computing, NLP, AI, ubiquitous connectivity, and freely available production-grade software, yet integration remains sparse.

# Flake Layout
This is how we layout our nix files in git repositories for consistency.
![NixOS Flakes](./NixOS%20Flakes.svg)

I believe you will find this a bit different than some of the other samples seen on github and out in the wild for flake management.

We have a different intent. We are managing and entire information architecture, not a single machine or a few machines and users with sporadic software needs.

What architecture then suits the modern landscape? This question guides our exploration of a system that not only supports but enhances business functionality, ensuring resilience and adaptability in the face of unforeseen challenges and constant change.

[CIM - the Composable Information Machine](./cim.md)