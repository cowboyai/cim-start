# The CIM Tech Stack

## [CIM](http://www.thecowboy.ai/cim) - Composable Information Machine
A CIM is a self-assembling, self-replicating, self-improving, self-aware, inteligence system.
We manage this by creating a Domain that encapsulates all the knowedge the machine cares about, incuding itself.

# [git](https://git-scm.com)
git is our starting point for a reason. A git repository is simply a portable collection of files that have the ability to track their changes. git accomplishes this with a Content Identifier for each commit that we use reactively to perform actions based on committed changes.

### Training
[Examples](https://www.atlassian.com/git/tutorials/advanced-overview)

# [NixOS](https://nixos.org)
Nix and NixOS specifically give us the ability to perform the actions of the following tools in a single environment:
  - Repeatable Linux From Scratch (build everything from source)
  - Virtual Machines (QEMU/KVM)
  - Containers (OCI, LXD, Bottles, systemd-nspawn)
  - Package Management (Nix - 100,000+ Packages)
  - git access to packages (pull a package source from git by version and build it)
  - Multi-machine configuration management
  - Remote deployment
  - User management
  - Shell management
  - Desktop management
  - Development environments
  - Shared modules
  - A Compiled Language we can generate from templates and tools
  - Compiled configurations
  - Immutable Content IDs

We can also call out to tools like docker, kubernetes, wireguard, terraform, ansible, or any other infrastructure tools you may already use... several have conversions to nix already available. Calling to a tool is fully testable and can be sandboxed in any way required.

### Training

- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Nix Dev](https://nix.dev/)
- [Learning Nix](https://github.com/spacekookie/learning-nix)
- [The Nix Hour](https://github.com/tweag/nix-hour)
- [Continuous Integration](https://nix.dev/tutorials/nixos/continuous-integration-github-actions)

# [NATS](https://nats.io)
NATS is our communication platform.
Everything in a CIM communicates through messages and nats controls that messaging environment.

NATS Provides:
  - Streaming
  - Message Sequencing
  - Platform Independence
  - Stream Processing Interface
  - Event Stores
  - Key Value Stores
  - Object Stores
  - Transaction Management

NATS is Subject-based, meaning all messages are routed by subject.
This enables us to have direct request/response interactions with Agents and APIs, and then broadcast results to a different Subject for a broadcast audience such as publish/subscribe fan-in or fan-out.

Anything with an API can be quickly and easily redirected to NATS messaging, even automated through AI.

### Training
- [Examples](https://natsbyexample.com/)
- [Videos](https://www.youtube.com/c/nats_messaging/videos)



# [Red Panda](https://redpanda.com/what-is-redpanda)
[Redpanda Connect](https://redpanda.com/connect) is our go to tool for Stream Processing.
Subscribe to any stream and process the messages to make projections, more messages, or self-introspection.

#### Training
[University](https://university.redpanda.com/)

# [neo4j](https://neo4j.com)
neo4j provides a robust graph database capability that we use to make relationships and manage graphs of the CIM.

### Training
[Cypher](https://graphacademy.neo4j.com/courses/cypher-fundamentals/)

# ollama
Ollama provides a capability to use many LLM Models in a common way. It also gives us a standard model to follow when creating embeddings and conversations with agents.

### Training
- [Rust Teacher](https://k33g.hashnode.dev/create-a-genai-rust-teacher)
- [Rust Ollama By Example](https://youtu.be/OcH-zT5VNgM)

# [wasmCloud](https://wasmcloud.com/docs/concepts/)
wasmCloud is the component system we use for Agents.

this allows us:
  - [Components](https://wasmcloud.com/docs/concepts/components)
  - Actors
  - Interfaces
  - [Providers](https://wasmcloud.com/docs/concepts/providers)
  - Hosts
  - nats connectivity through [lattice](https://wasmcloud.com/docs/concepts/lattice)

and a methodology already tuned to follow [Functional Reactive Programming](https://www.freecodecamp.org/news/functional-reactive-programming-frp-imperative-vs-declarative-vs-reactive-style-84878272c77f/) and [Domain Driven Design](https://www.youtube.com/watch?v=L3SvIKdLt88).

### Training
- [Examples](https://wasmcloud.com/docs/tour/hello-world)
- [Video](https://youtu.be/bhKqr-mrhb4)
- [Hello Universe](https://wasmcloud.com/docs/tour/why-wasmcloud)

# DNS
DNS is responsible for managing the Domain Naming System, Internet Domain Names, Object Names, indexing, and forwarding those names to external providers such as Cloudflare.

  - Domain Objects all have names
  - Network connected hosts all have names
  - Objects in Object Stores all have CID (ContentIdentifiers)
  - Subjects in NATS are managed names from here

### Training
[Tutorial](https://calomel.org/unbound_dns.html)

# IPA
Identity, Policy and Audit is where we manage people.

  - Single Sign On
  - Radius Network Management
  - OAUTH, OIDC, OLAP
  - Role Management
  - API Key Generation

### Training
- [Planning](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/planning_identity_management/index)
- [FreeIPA](https://youtu.be/lH7I-omZ4PA)

# [Vault Warden](https://github.com/dani-garcia/vaultwarden)
Vault Warden provides secure secrets management with a friendly interface.

### Training
- [Wiki](https://github.com/dani-garcia/vaultwarden/wiki)

# Web
[Leptos](https://leptos.dev/) provides capabilities for Portal and Projection access (such as dashboards).

### Training
- [Leptos Book](https://book.leptos.dev/getting_started/index.html)
- [Video](https://youtu.be/GWB3vTWeLd4)

## Other Training Material 

### NixOS
- [Script in any language](https://youtu.be/qRE6kf30u4g?si=qceqJ95RdFpQpSmi)
- [Nixos-anywhere](https://youtu.be/U_UwzMhixr8?si=4WrK3w7c85F-vzEi)
- [Deploying NixOS](https://youtu.be/vm-Sj1V529I?si=qH5_cx36joaMdXgs)
- [Nix Language](https://youtu.be/x-9bBPbsZwc?si=G-LgvrIoifDKo5rM)

#### DDD
- [Ubiquitous Language](https://youtu.be/yWDaBdV-SL8?si=5m04Kg0jcEKbKU19)
- [Bounded Contexts and Sub Domains](https://youtu.be/NvBsEnDgA4o?si=gcaIxE1YmmZdCI3b)
- [EventStorming](https://www.youtube.com/live/v4xLxmpAFdI?si=45pXJBAi6KQFYGlW)

#### NATS
- [Message Sending Toolkit](https://youtu.be/5NXvU17a-iU?si=lp4PdwBchDoWNYJs)
- [Connect ANY Auth System](https://youtu.be/VvGxrT-jv64?si=lWktD03kJUVvd5uT)
- [Leaf Nodes](https://youtu.be/WH55czo1BNk?si=wEAM6cL5IJrvoRDd)
- [Stream Processing](https://youtu.be/EA2Pco3EvpU?si=jSXVz45HCNBY0poy)

#### Conceptual Spaces
- [The Geometry of Thinking](https://youtu.be/Y3_zlm9DrYk?si=EXaCz4E2xOUuYcD9)
- [The Geometry of Meaning](https://youtu.be/L0X9mEe9aY0?si=UWrBkWgMI8K-jmgr)
- [The Shape of Language](https://youtu.be/0PbaEvm22G0?si=nesSqFOm4RUQQqQO)
- [A Thousand Brains](https://youtu.be/XK-Vksr3IT8?si=vJIthdJ419bVfl6_)
- [Conceptual Spaces and Social Interactions](https://youtu.be/XK-Vksr3IT8?si=vJIthdJ419bVfl6_)
- [Conceptual Blending](https://youtu.be/53QRyH3mVVM?si=aZhasguPEQvFVzMf)

#### Category Theory
- [Category Theory for the working Programmer](https://youtube.com/playlist?list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM_&si=us29wC4bq3Pn_Zse)
- [Graph Data Models](https://youtu.be/SmOExZx9TaU?si=A-MEe1nbv1caQ33m)
- [Interface Based Design](https://youtu.be/JMP6gI5mLHc?si=dSf0pSmBRoQ6Gio9)

#### AI
- [Agents as MicroServices](https://youtu.be/_aTEI3ISkQA?si=moD3HZOpe3tEIW4A)
- [Llama3 Fine-tuning](https://youtu.be/pK8u4QfdLx0?si=fnwTCyebryT8fhRG)
- [AI = Language](https://youtu.be/7m1x66psgqA?si=8xl9BDon42gbTuMZ)
- [LangGraph](https://youtu.be/v9fkbTxPzs0?si=8zh692Un8cMmAvsV)
- [Long Term Memory and Self Improvement](https://youtu.be/7LWTZqksmSg?si=X6i4kITRNUYWeIby)

#### Programming
- [Graph Visualization](https://youtu.be/4x3sK-URLF4?si=c1LVRmTqGzNNeHOh)
- [Visualizing Data](https://youtu.be/5pCdw-PV0Js?si=EDkiIzjGK1XZJM7R)
- [Building WASM Apps with Rust](https://youtu.be/ie13kswrWu4?si=rnln5PxRjQMiui5j)
- [Build a reactive system](https://youtu.be/GWB3vTWeLd4?si=_KUYHYwJt_YmD_v4)

#### Business Models
- [Mastering Value Propositions](https://youtu.be/35ST-37PPXc?si=eSR88qxEbHCeAqV0)
- [Testing before building is the key to success](https://youtu.be/LRGkWhjZfd4?si=iKqXdxdQE6oPsP94)
