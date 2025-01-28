**# Building a CIM**

A CIM starts with a root idea or domain, composed of interconnected modules.

Think of this as a greenfield project—you’re starting from scratch, building a complete system from the ground up.

You might be wondering, *“Okay, but how do I actually construct one? How do I even begin?”*

It all starts with something simple: a "domain."

You get an interactive Web site to start interacting and seeing what is going on, we will add Domain Events and populate those from ordinary programs.

This "domain" is defined by three basic elements: a **Name**, a **Purpose**, and an **ID**.  
The ID is automatically generated as a UUID, so all you really need to provide are the Name and Purpose.

*“That’s it? Just a name and purpose? This feels trivial—get to the point!”*

But here’s the thing: without these, you have no direction. Without a clear purpose, you’re just shouting into the void, hoping for meaning to emerge.

A CIM is about building a structured system of information. This information serves an intended purpose—maybe it’s for managing business workflows, sensor monitoring, accounting, vehicle maintenance, or any other context where encapsulating information makes sense.

The key here is that *your purpose drives everything*. My purpose might differ from yours, and that’s the beauty of it. You’re creating something specific to your needs, and that “something” must have a clear purpose.

When we talk about building this “something,” we’re essentially instructing the system on how to be constructed. Yes, this involves decisions about software design and execution environments—but at its core, it’s about aligning your system with its purpose. You can certainly change this, but if you do... what about all the stuff that was meaningful in context at the time. That's all retained with Event Sourcing.

If all you’re doing is piecing together pre-built software components without understanding their role in the bigger picture, what value does that serve? The focus here isn’t on *how* you implement it but *why* you’re implementing it in the first place.

This guide exists to help you implement *your* vision. Sure, we could dive into technical jargon and programming concepts, but that’s not how we naturally communicate. I don’t talk to my colleagues in “for loops,” and I certainly don’t think in them either. We communicate in abstract, contextual terms—and that’s exactly how we’ll approach building your CIM.

## Start the CIM...
if you've cloned this repo, open a terminal type:

```bash
just start
```
This will launch ```cargo leptos watch```
and you will have a web app at [http://localhost:4200]

If you prefer, you can just edit the yaml.

```yaml
domain:
  - name: "CIM"
  - id: <some-uuid-v7>
  - purpose: "Integrate AI into my business workflows"
```

This lives in the git repo. Yes, it's data. Yes, it's structure. So is all this nix stuff. 

A "flake" is a way to package a "configuration".

I have no idea where this will run, or how it will evolve yet, I just know I am starting here. in this git repository, everything I do begins, and is tracked, from here.

We have a ton of freedom...