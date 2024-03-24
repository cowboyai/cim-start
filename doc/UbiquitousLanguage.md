# The Ubiquitous Language
This is the dynamic Language of the Domain.
While we could make this language from a bunch of meetings with domain experts; we can simply extract it from usage.

Wait... What?

That's right. Built on the fly. No Schemas, No Constants.

Eek... How do I Type anything?

Let's turn that around...
When I Type things, distinguishing they are a special kind of thing, do I just make up the names or is there a logic to the words we use.

We have some kind of logic being applied and whatever that may be, we can detect the patterns and suggest those going forward.

If you have used any modern code editor, you have probably used a Language Server and the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/). This tells you how to format code documents and whether you have syntax errors in the code.
Now imagine your Domain Language available this way... through Comms.

If we sit down with a team of architects and domain experts we can certainly develop a Ubiquitous Language in a few months or years... Ummmm... Faster please.

By the same token, if we are adding a bunch of related things into a graph, we can just look at the graph and tell you what you are using. We can also see that hey, you are using some weird phrase here and we normally use this other term. And this can apply throughout the CIM.

You have a Language, a Domain Specific Language, it is persisted and we can access it through a Language Server just the same way and allow our tools to have direct insight into our language and make suggestions based on that language.

While this is nothing new, language servers I mean, building a DSL on the fly from a private system and providing usage in editing tools certainly is.

If you love semantics, we open an entire linguistic arsenal into your Domain Model's Language.

Armed with this Language, We can go from Domain to Domain and have perfect contextual clarity. Building one of these in the past was a massive undertaking and an ordeal of effort no less than forming the scriptures of a religion.

This is not how human beings typically organize themselves.
Usually John thinks of an idea, Sally names it, and Eric and Steven use that name going forward.  Then Sally decides to change the name and things get weird.

We have to start with a base somewhere... that is where the LLMs come into play.  These are terrific generalized tools that have really cracked the way language is built and how each word semantically relates to another.

To get the full use out of these tools, were need a dialect translation and that is where the Ubiquitous Language comes in. This augments the LLM about the Domain Specific Language inside the context of our Domain.

Augmenting LLMs with your naturally used language tunes the LLM into a better response, more directly related to the context we are in.

## How do we do this?

Since we know from this architecture that everything becomes an Event, we simply tap the Event Stream and make a Projection to the Language Graph in real time, using an eventually consistent methodology.

### CIMs have persisted Event Streams
A persisted Event Stream is a sequence of Events written to long term storage that can be queried to select a collection of events about any specific topic inside the CIM. This allows us to understand and share Content with any other authorized CIM to partition information into logical boundaries based on Subject Context.

There is an Attention Mechanism and Transformer system built into LLMs and we optimize those interactive capabilities through vectorized semantic search of your DSL in real time.

This sets a CIM apart from other methodologies.

You are building a natural human interface into your information, as you build more information.

The Sequence of Events, along with the Object Store content of the information are all we need to recreate the entire language.

This allows us to make a nomadic system based on our Domain and store it, replicate it, and run it anywhere I can connect a nats server and an API.

[Inventory](./Inventory.md)