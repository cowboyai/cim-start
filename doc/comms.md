# Comms
Comms is the way CIM communicates.

Well isn't this just nats?

Yes, the transport layer is nats, but the Subjects are all controlled by the Domain.

Commands are simply a Message wrapper for nats.

We let nats handle all the boilerplate like Messagid, Subject, Servers, and Authentication while we focus on the important part, the actual Command.

A Command is literally anything that is changing State in a CIM.  Update Queries, those aren't queries... they are Commands.
What time is it? perfect example of a query... but WHERE did you ask that? I may be asking for local time or the time on the server in Dubai... whatever Context you are in is what we will be responding to.

Context is not something we need to pass around, but there are some caveats for grouping things together like transactions and causing other commands to propagate.

Comms handles all the Domainy stuff while nats just delivers messages. Transforming messages is relegated to benthos.

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
We build in benthos to give you a default, awesome tool.

Delivery guarantees can be a dodgy subject. Benthos processes and acknowledges messages using an in-process transaction model with no need for any disk persisted state, so when connecting to at-least-once sources and sinks it's able to guarantee at-least-once delivery even in the event of crashes, disk corruption, or other unexpected server faults.

If you want to build that yourself, go ahead.

Sometimes the components that come with Benthos aren't enough. Luckily, Benthos has been designed to be easily plugged with whatever components you need.

You can either write plugins directly in Go (recommended) or you can have Benthos run your plugin as a subprocess.

We write most of ours in Rust, so we have plenty of examples for you to follow.

The bottom line here is that CIM deals with how to talk to the Domain and you no longer have to worry about that, you just process streams. If the stream gets messed up, Comms handles that and you don't have to... Commands, Queries and Events... not IP Addresses, Reverse Proxies and Load Balancers.



