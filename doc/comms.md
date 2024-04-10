# Comms
Comms is the way CIM communicates.

Well isn't this just nats?

Yes, the transport layer is nats, but the Subjects are all controlled by the Domain, and we do special things with Jetstream, the KV Store, and the Object Store.

Commands are simply a Message wrapper for nats.

We let nats handle all the boilerplate like Messagid, Subject, Servers, and Authentication while we focus on the important part, the actual Command.

A Command is literally anything that is changing State in a CIM.  Update Queries, those aren't queries... they are Commands.
What time is it? perfect example of a query... but WHERE did you ask that? I may be asking for local time or the time on the server in Dubai... whatever Context you are in is what we will be responding to.

Context is not something we need to pass around, but there are some caveats for grouping things together like transactions and causing other commands to propagate.

Comms handles all the Domainy stuff while nats just delivers messages. Transforming messages is mostly relegated to benthos.

To make a Service available on the Domain, we simply package a nats client and a way to send and receive messages.
If the service is responsible for UI, it can focus on that and stop worrying about how to talk to the database.

You could do this with a Docker Container, nats-server and some command-line scripts.

We are talking about nearly zero dependencies here even at an operating system level.  I only care about an ability to send and receive messages over nats and the functionality of my service.  The Domain is what manages everything and building a service is just an extension of the Domain.

Comms is responsible for doing the mapping between the message platform and your service.
If you talk to a JSON API and need to send JSON, then Comms deals with whatever format your Service is in and MAPS that into the correct JSON syntax for you through the other tool combined into Comms, [benthos](https://benthos.dev).

Benthos let's us transform streams on the fly.
Anything communicating over nats can potentially be transformed by a benthos stream process.
Do I have to use benthos?
nope... built them in Rust, or JavaScript, or C#, whatever you like.
We build in benthos to give you a default, awesome tool and we got tired of hand-coding boring boilerplate that benthos handles already.

Delivery guarantees can be a dodgy subject. Benthos processes and acknowledges messages using an in-process transaction model with no need for any disk persisted state, so when connecting to at-least-once sources and sinks it's able to guarantee at-least-once delivery even in the event of crashes, disk corruption, or other unexpected server faults. We didn't want to build that...

If you want to build that yourself, go ahead.

Sometimes the components that come with Benthos aren't enough. Luckily, Benthos has been designed to be easily plugged with whatever components you need. You can either write plugins directly in Go (recommended) or you can have Benthos run your plugin as a subprocess.

We write most of ours as a subprocess in Rust, so we have plenty of examples for you to follow.

The bottom line here is that CIM deals with how to talk to the Domain and you no longer have to worry about that, you just process streams. If the stream gets messed up, Comms handles that and you don't have to... Commands, Queries and Events, sent to localhost... not IP Addresses, Reverse Proxies, Load Balancers and direct API calls.

## Message Structure

```rust
pub enum DomainContent {
    Event(DomainEvent),
    Command(DomainCommand),
    Query(DomainQuery),
}

pub struct Msg {
  pub id: Uuid,
  pub metadata: Hashmap,
  pub content: Option<DomainContent>,
}
```

We will dive in to DomainContent soon, but these will be your Domain Contracts for what Content looks like.
There are also outside wrappers from nats that have even more message data and standard patterns for Schemas.

Here is how things break down:

- Every Message has a Unique ID
- Messages are Sequenced
- A Correlation Identifier may be added to group messages
- A Causation Identifier may be added to show direct causation (what Command caused this Event to propagate)
- All Messages have an Owner
- Metadata is a simple Key Value Array
- Content is a Generic construct tailored to the Domain

We persist ALL Events into an Event Store
- Content over a configured threshold size will offload 
- Content to the Object Store and receive a Content-Address
- Content-Addresses are universally unique identifiers for a Directed Acyclic Graph of data blocks 
- Content-Addresses may be retrieved from Comms
- Content-Addresses are IPFS Compatible
- Content-Addresses may be structured with IPLD

Think of this scenario:
- I am adding a 100 Page PDF to my CIM
- This is too big to be passing around internally inside the message
- Comms receives the AddDocument Command
- Comms sees the size of the payload is large
- Comms extracts the payload and stores it into the Object Store with authorization constraints
- Comms forwards the Message intact, replacing Content with a CID instead of Bits
- Event Listeners receive the Event that Document-CID has been added
- Event Listeners who need the Content retrieve the CID, passing along authorization
- CID Content is delivered

Using this methodology, the Event Stream remains optimized.
Large Objects do not get passed through the Messaging System, they are off-loaded to the Object System.
The Object System is like a file system where you may put and get Content by CID.
If you have ever used IPFS, this works the same way, we just use a different network technology to pass bits around the system.

If you only ever have a single Leaf Node, this is pretty boring, but still solves a massive problem for us: file sharing. How does one thing share files with another thing.

For Comms, it is a simple get(cid) and it just delivers it to you. cids also have names, so asking for the name instead of a cid works too. We generally don't manually request these things manually, and that is the magic of the Object Store and Messaging.

I have a CID... 
- If I need to render this Content, I can fetch it with the CID or one of many Names for the CID... anywhere I have a connection to Comms.
- I can name it anything I want and that Name is now part of the Domain with a Relationship to the CID.
- I save LOCALLY, if it is needed elsewhere, the Domain Listeners will fetch it an move it around.

For example, I have told my Domain that I want 3 copies of all Objects. If I am only Local, it just makes 3 copies...

>That isn't very safe.

If we have a Domain Cluster (typically we do) then the Local Comms system has broadcast to the Domain that it has a new Object and anyone interested can retrieve it. The Domain is the manager, it knows where Content is needed and will relocate things as needed to optimize storage in the background.

That means that if you add Content and that Content is related to a Website that Projects the Content, it will move the Object Data close to the Website for optimization automatically.

Object Stores are just S3 Buckets with an Event Model for adding and retrieving objects (they don't have to be large).
What we call large, may not seem large to you, but Message Payloads should be kept as small as possible.
We aren't usually processing payload inside the message traffic, that is a Domain function, not the Comms function.
There are exceptions for mapping, but these are still offloaded processes and if we are processing, we can also retrieve CID Content.

We can send a million messages a second if they remain small.

git does the same thing with large files through the LFS Plugin.

Large files can slow down versioning, tremendously.
If you use the LFS Plugin, and you commit a large file
git will pull it out of the commit and put the file into an Object Store then replace the file in the commit with a pointer to the Object in the Object Store.

We are doing the exact same thing for Messages. The Integrity of the DomainContent is preserved in the Object Store. Object Stores are distributed throughout a CIM and can load balance and optimize themselves.

Imagine adding a playlist of a thousand Music files you use for promotional materials.

If you want to persist the music along with the playlist, you can absolutely do that, but we wouldn't want the Events to reflect the entire music file 10 or 12 times as it travels around the system. Instead, the Music is saved to a CID, and the CID is then the Content of the Message and we know that to get the Music, we retrieve the CID.

This will also apply to anything like Documents we don't trust that need virus scans, etc.

This is the entire beauty of Comms. I have Messaging to any functionality my Domain can provide and it is shared securely throughout the platform, no matter where it lives.  This is so much easier than even setting up a "home lab". Hardware becomes just some way to run functionality and I can send it around without thinking about where it lives and how to connect to it.

Now compare this to something like Docker and a Web App.
Sure, I can do a lot of this wrapped in a Docker container, then I have to deal with the File System, sharing Data, opening ports and a whole lots of other things I really don't care about in day-to-day usage of my information.

Comms frees us from this dilemma in Domain Communications.

Create a Message
Send it to Comms
Get an Event containing the Response

This is not that different from some things we have done in the past...
But can't that just make Comms act like a backend Web Server.
YES, now you are seeing the value.
I can have a Local WASM Web Client or even a Command Line Interface
That Web Client can talk to ta Local Comms server
ALL Domain access is potentially available through Messages

This can be done for ANY Domain Resource.
Make it available through Comms, anything in the Domain with Authority can now access it.
Virtual Machines, Virtual Applications, Virtual everything basically, all controlled through a distributed Domain.

We have been trying to accomplish this basically since we first networked two machines together.
The problem has always been money, proprietary systems, and speed, but that is a totally relative thing.
Speed is now sufficient as network speeds and reliability are as good as local hardware.

Now, it is a matter of cost and psychology.

[Messaging](./messaging.md)