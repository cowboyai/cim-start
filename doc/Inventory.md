# CIM Inventory
CIM has the concept of an Inventory.
This is every resource available to the Domain.
It's not just the stuff sitting in your warehouse, it's all the Configurations and the Ubiquitous Language.

Why am I building a language? See [Ubiquitous Language](./UbiquitousLanguage.md)

Does this all require a Graph Database?

No. Essentially, the Event Store is already a Graph Database, the Object Store is also a Graph Database.

Not that they are running on top of some database infra-structure, they are simply stored on a persistence layer in graph format.

You could make this work on any file system you are comfortable using.  These file systems will have different limitations and we would need to worry about all those.

If we think of files as inputs or outputs, things become a little bit more clear.  Afterall, "files" are a construct of the Operating System (OS). The OS is giving you a pile of blocks organized into a sequence you think of as a "file" which in fact, is a name pointer to a graph of blocks. It's just hidden from you.

A Node is the same thing. If a Node is collection of blocks that we have named, it's is logically the exact same thing we think of as a "file".

"File" is a convenient term brought to us from the context of Paper. This is a collection of papers we put together into a "file".

In the Information World, we can dispose of this base structure and look at the real thing: a graph of blocks. We are going to call these Content and they have a Content-Address.

As long as we consider this our inventory, we are in good shape. Speaking of shape, that is something we care a great deal about.

Shape is going to be formed by "Category". Categories are not the same thing as a group, a collection, or a set. They have their own set of ideas and axioms. When we refer to "Category" we do so in the terms of "Category Theory" and this becomes an essential part of our Inventory Structure.

Inventory for a CIM is therefore the Category of every Resource it has access to.

That is why we are starting at Domain, and then adding the other requirements. The Domain is what we care about and different Domains have different requirements.

These are the Core Categories CIMs usually have:
  Domain
  People
  Organizations
  Agents
  Operators
  Accounts
  Users
  Resources
  Entities
  Values
  Commands
  Queries
  Events
  Aggregates
  Policies
  Behaviors
  Projections
  Maps
  Location
  Signals
  Functions

These are the abstractions that make up our Base Inventory.
You will surely add Domain Specific additions to this as you proceed.