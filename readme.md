# cim-start
A starting point for CIM - Composable Information Machine.

CIM can be huge, but it starts small. A single configuration and we have a working, portable environment.

![CIM Architecture](doc/CIMArchitecture.svg)

git is acting as our repository of storage.

CIM will transport us into the future very quickly and let us enjoy information as it is supposed to be... connected.

Traditionally, we have a hundred things to think about just to get started. Let's start in the middle, with a browser and a git repository. This structure is all we need for a CIM, but we will quickly outgrow it as we proceed. We will just want more capability and to add that, we need to consume more resources.

CIM ia a massive abstraction, we need to get rid of the technology noise. The tech is still there, it's just sent to the background so we can focus on the information and not all the ways we can process it.  We know we can process it, making the decision how has now become the fulcrum for a successful information system.

CIM has 3 things:
  Command: 
    Change the State of the CIM
  Query: 
    Observe the current State of the CIM
  Event: 
    Declare the CIM has changed State

Everything evolves from that idea.
  Who owns this?
  Where do I store the Events?
  What can a Command do?
  How do I ask questions?
  What are all the dependencies?
  Where are my files?

These are all reasonable expectations from an Information Machine. The idea was supposed to be simple, but somehow it has exploded into a million acronyms we cannot understand.

We return to the simple, but that doesn't equate to less capable, in fact it becomes quite the opposite.

The way we generally think of "computers" is really some sort of glorified calculator that can hold and work with my information.  We all know they can do more, but they have been relegated to number crunchers and not semantics.

Humans are semantic creatures. We apply meaning to everything, consciously or subconsciously, we do it, it is engrained into how our brain works.  For some reason we still don't treat our information agents that way.

To simplify this let's look at a graph:

Me -> command/query -> the universe of information -> events -> Me

And this loop cycle just continues as we process information.

I need a way to pre-process things so I am not the engine.

This is what a CIM does, it let's me interface to everything I interact with. In the past this was nearly an impossible feat, but technology has brought us to a point where it is not only possible, but a distinct advantage to move to right now.

Some of the technologies we use will have a fairly steep learning curve to become an expert. Using the system and learning as we go is an intricate feature of the CIM.

Queries to AI about anything in the CIM is already built in, we just have to connect it to something that makes sense.

This eliminates most of the steepness of the learning curve if you have a ready made assistant to help you and one that builds its own synaptic references in the background.

Even if you have never heard of any of these technologies, follow along. CIM will help you through Sage, a User Interface designed for designing and working with information, let's be distinct, we will talk about a lot of technology along the way, but we are concerned about the Information and how it applies to my Domain model over any particular preference for technology.

We certainly don't expect you to abandon your tools... CIM is a new tool, with a new purpose. It resides along with everything you already know as part of your Domain.

We start with 2 things:
A Domain
  - a boundary around a collection of related information
  - an environment, some place for work to take place
  
We need to start here because everything we add or build into the next stages become part of the language of our Domain.

CIM conveniently extracts a language tailored to your Domain and how you use it. It's like the dialect you use in your home as opposed to writing a speech.

This would be incredibly difficult to do manually, but there have been many successful ways to do this in the past, such as the zettelkasten method.

Rather than impose this on you to manually recreate, the CIM will extract from everything you build and re-process it to create a language for your own use, but also for connecting semantically to Large Language Models and future AI capable processors.

Start by cloning this template repository and then open the folder

[using the template](./Using_this_template.md)
