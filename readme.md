# Information Machine
A system or device designed to handle the processing, storage, and communication of information.

# Composable Information Machine
CIM is indeed such a system, composed of many devices. Composition is a way to assemble multiple parts into a greater whole.

We want a "machine" that I can configure from scratch, deploy anywhere I need it, and can self-partition, scale and heal.

We don't build servers anymore, we build systems,and those systems are distributed.

# Communication implies language
If we are responsible for communicating, then we are responsible for language.
No two human beings speak the exact same language, though they are able to communicate. There is an underlying notion of charades that allows human beings to have a back and forth exchange of symbols, sounds, gestures and actions that point to understanding.

We can teach that to an AI. Large Language Models are only a part of the solution.
While being able to interpret and generate well-formed communication, it is a general tool. We have created a framework for language to accomplish this in the modern information technology world. While utilizing the best capabilities of LLMs, we provide proper Context for the conversation to have any meaning.

This includes understanding how to build a system, which is a directed series of events. Building these comes at a very steep learning curve and solutions usually have some flavor of proprietary language associated with them that we must learn and conform to.  What if we got to build the language? I don't mean a "programming language" I mean a "domain specific language" with the domain being my information.

We have a general notion of working with information, We need to assemble the structures and functionality that will produce that information. This means adding software to a computer, operating systems, programs, display capabilities, etc.

Generally, there is some way of dealing with this, but it is usually a very manual process. Even typical deployment solutions still need quite a lot of manual intervention to move things around and communicate between disconnected systems.

We have many ways of doing this with many machines today, we have ideas like docker and kubernetes and virtual machines and simple storage services (S3) and ubiquitous broadband.

Just a few years ago, the introduction to "information machines" meant go get a laptop and connect it to the internet. Or do everything on your smartphone and cloud services.

These methods work, and they place YOU as the central coordinator.

We want a central coordinator for all our information, a concierge for information. This would include an immutable series of events of what happened.

One thing we know with certainty. Information and our interpretation of it will change... constantly. How do I deal with storing it and the scaling growth of the equipment required to process it.

This is part of the intent of a CIM.

Create the thing that can bring all this information together no matter how I create it or where it lives.

Extract a language for me so that I can better understand what I am doing, but also be able to communcate and teach those ideas to others, including what we want to call AI. 

# Code Generation
For most of my career, "code generation" really meant "string replacement".
We would create templates for code as scaffolding, then have automation insert names and values into the template.

Later it got better with tools to actually cause a compiler to produce code, but this turned into a new language to produce the code that was in yet a different language. Yikes.

Yes, as "developers" we are really linguists who work to translate a human idea into a machine executable language.

To create systems, we need a core language and we chose nix. nix allows us to coordinates information systems in a deterministic way, while remaining agnostic about how we configure those systems.

Essentially, any "compute system" is a package of structured information.
How can I reliably repeat and replicate that information efficiently.

# To Begin
git is our Event Store.
flake.nix is our start.

We are going to walk through building operational systems with nix and NixOS.

[Build a CIM](build-cim.md)

[Our Tech Stack](./techstack.md)