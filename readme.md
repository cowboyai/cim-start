# Information Machine
A system or device designed to handle the processing, storage, and communication of information.

# Composable Information Machine
CIM is indeed such a system, composed of many devices. Composition is a way to assemble multiple parts into a greater whole.

We want a "machine" that I can configure from scratch, deploy anywhere I need it, and self-partitions, scales and heals.

# Communication implies language
If we are responsible for communicating, then we are responsible for language.
No two human beings speak the exact same language, though they are able to communicate.
There is an underlying notion of charades that allows human beings to have a back and forth exchange of symbols, sounds, gestures and actions that point to understanding.

We can teach that to an AI. Large Language Models are only a part of the solution.
While being able to interpret and generate well-formed communication, it is a general tool.
It is similar to trying to have a conversation while looking up the words and phrases in a dictionary.

We have created a framework for language to accomplish this in the modern information technology world.
While utilizing the best capabilities of LLMs, we must provide proper Context for the conversation to have any meaning.

Have you ever sat in a meeting where you where not well versed on a subject and they were talking and you heard the english, but occassionally  term came into a sentence and it just made no sense.

This is usually how we talk to computers.

We have no mutual context and either the machine is directed through programming to work with the human through an API or "interface to humans" or it has a very limited structure to allow the input of data.
Every "program" we use has a different "interface" and there is no consistent way to consolidate all this.

There are many "frameworks" available to make all this happen nicely, some you may like, some you may hate, but they are all very opinionated on what you do and how you do it.

Unfortunately, these all come at a very steep learning curve and usually have some flavor of proprietary language associated with them that we must learn and conform to.

# LLMs are not AI
OK,  this is an opinion, but here is our reasoning:

  1. LLMs have no memory
  2. LLMs do not reason, they imply based on statistics
  3. Parameters may be biased
  4. Enunciation and Inflection is lost (omni models help tremendously)
  5. Knowledge is very generic
  6. Context can be focused, but other context is lost unless specified
  7. LLMs do not function like brains

LLMs process and generate text by understanding the relationships between words and phrases in large datasets. While admirable, and indeed cracks modeling languages and translating between them accurately.

This does not infer that the model "knows" what a duck actually is.
The model can describe a duck in the same way other humans have described a duck in the past, but it cannot intuitively tell you that is a creature with conciousness, the ability to make it's own decisions, can self-heal most damage, and has the ability to reproduce. It cannot tell you anything it does not already know. Ask it how a duck obtains conciousness.  While humans have no decicive conclusion to this question, we do have theories we can regurgitate and we can also speculate.

# LLM Text Generation is not Speculation.
Ask an LLM to tell you a story. It will do exactly that. These are not creations of it's "brain", but rather the most likely series of words to convey an idea.

# Where do LLM's form those ideas?
We must add this capability for "understanding" to our AI.  The AI is a different thing, it has Memory, Domains, Bounded Contexts and a Ubiquitous Language.

Your "Ubiquitous Language" is the way you talk to yourself. This is similar, but different to the way you talk to others. Your business is the same, it has it's own language. If you are like most of the populkation, you haven't defined it, it's just "there".  Maybe you have a dictionary of terms, and some taxonomies, but is the language something you can teach someone else?

AI is something we must build individually. Artificial General Intelligence is not the purpose of an LLM. LLMs are just similar to a part of a human that processes language... It must not only associate words, but it also must generate commands from that interpretation to move your mouth, tongue, vocal chords, and breathe in just the right way to form audible symbolic representations of those interpretations.

LLMs don't do that, we need some sort of processor to do that.

We chose to make a virtual von Nuemann arcitecture as the overall idea.

CIM treats the entire system the way we normally think of a single computer to date.

I have a general notion of working with information, I need to assemble the structures and functionality that will produce that information. This means adding software to a computer, operating systems, programs, display capabilities, etc.

Generally, there is some way of dealing with this, but it is usually a very manual process.

We have many ways of doing this with many machines today, we have ideas like docker and kubernetes and virtual machines and simple storage services (S3) and ubiquitous broadband.

Just a few years ago, the inroduction to "information machines" meant go get a laptop and connect it to the internet. Or do everything on your smartphone and cloud services.

These methods work, and they place YOU as the central coordinator.

We want a central coordinator for all our information, a concierge for information.

One thing we know with certainty. Information and our interpretation of it will change... constantly.

How do I deal with storing it and the scaling growth of the equipment required to process it.

This is part of the intent of a CIM.

Create the thing that can bring all this information together no matter how I create it or where it lives.

Extract a language for me so that I can better understand what I am doing, but also be able to communcate and teach those ideas to others, including what we want to call AI. 

# LLMs provide generic information
Most LLMs are trained across the entire scope of human knowledge. This is great to have billions of cross-references and could be considered the equivalent of going to high school. I get enough general knowledge to function in the world, but to "good" at anything, I will need to improve these techniques and specialize in a few areas.

This is the idea of "Agents".

# Agents
Agents are LLM Specialists. They a way to add focused information to the generalized knowledge of an LLM so it will understand more semantic knowledge for a secific subject.

As we build our "Information Machine" we will see many patterns emerge. Those patterns are what we want to capture and place into proper contextual boundaries to be useful.

Agents will become the tools we use over "programs" or "apps" in the near future.

We see the worlds of programming and data structuring significantly changing in the next few years.

We will still need developers, but mostly to verify code and test it rather than to write it.
The Code Generation od LLMs is phenomenal when properly trained to produce structured code according to rules of the language instead of just past usage. 

# Code Generation
For most of my career, "code generation" really meant "string replacement".
We would create templates for code as scaffolding, then have automation insert names and values into the template.

Later it got better with tools to actually cause a compiler to produce code, but this turned into a new language to produce the code that was in yet a different language. Yikes.

Yes, as "developers" we are really linguists who work to translate a human idea into a machine executable language.

That is exactly what LLMs do, and do very well.

We use LLMs along with a [Domain](./doc/Domain.md) to compose a [CIM](./cim.readme.md)

[Our Tech Stack](./techstack.md)