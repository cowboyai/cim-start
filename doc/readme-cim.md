# Information Machine 
A system or device created to process, store, and communicate information.

# Composable Information Machine
A CIM is an "information machine" built from multiple interconnected components. Composition allows individual parts to come together, forming a cohesive and more powerful whole.

The goal is to create a "machine" that can be configured from the ground up, deployed wherever it's needed, and designed to self-partition, scale seamlessly, and recover autonomously.

In today’s world, we no longer build standalone servers—we build distributed systems. These systems are dynamic, adaptable, and designed to function as a unified network.

# Communication Implies Language  
If we are responsible for communication, we are inherently responsible for language. While no two people speak the exact same language, humans rely on shared symbols, gestures, and sounds—a kind of *charades*—to exchange understanding.  

This principle can extend to AI. Large Language Models (LLMs) are a powerful tool for generating and interpreting communication, but they are only part of the solution. To make conversations meaningful, we must provide proper **Context**.  

Building systems is essentially a directed series of events, but the process is often complex and tied to proprietary languages that demand steep learning curves. What if we could create our own language? Not a "programming language," but a **domain-specific language** tailored to our information.

Working with information involves assembling structures and functionality—installing software, configuring operating systems, setting up programs, displays, and more. Today’s solutions, like Docker, Kubernetes, virtual machines, and cloud services, have made this easier but still require significant manual effort to coordinate disconnected systems.

Historically, managing "information machines" meant using laptops or smartphones connected to the internet to talk to back-end servers. These methods work but place *you* as the central coordinator. Cloud vendors typically draw you in and then you are stuck there.

What we need is an **information concierge**—a central system that coordinates everything for us while maintaining an immutable record of events. This system must adapt to the inevitable changes in information, its location, and scale with the growing demands of processing and storage.

This is part of the intent of a CIM.

Create the thing that can bring all this information together no matter how I create it or where it lives.

Extract a language for me so that I can better understand what I am doing, but also be able to communcate and teach those ideas to others, including what we want to call AI. 

# Code Generation
For much of my career, "code generation" was essentially glorified string replacement: we built templates as scaffolding and automated the insertion of names and values. Over time, tools improved, enabling compilers to generate code. However, this often introduced yet another layer of abstraction—a new language to generate code in a different language—adding unnecessary complexity. 

At its core, software development is about linguistics: translating human ideas into machine-executable instructions. To create robust systems, we need a foundational language. For this, we chose Nix, which enables deterministic coordination of information systems while remaining agnostic about their configuration. 

In essence, any "compute system" is just a structured package of information. The challenge lies in reliably replicating and scaling that structure efficiently. Nix excels here by ensuring reproducibility and consistency, eliminating the guesswork from system configuration and deployment.

# To Begin
git is our Event Store.
[flake.nix](./flake.nix) is our start.

We are going to walk through building operational systems with nix and NixOS.

[Build a CIM](build-cim.md)

[Our Tech Stack](./techstack.md)