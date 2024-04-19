# Communications
Now that I have a Domain, how does it communicate?

This is going to throw you... to localhost.

Wait, I don't connect to a server?

Yes, you do... one in the localhost.

That "comms" server then takes care of everything else.

CIM is built differently.
Oh, you have some network client you built...
No, this is a directed graph of Subjects on tops of [nats](https://nats.io).

How do I make a Web Server talk?
It talks to a local nats server.

What about my Databases?

nats figures that out for us, by Domain reference, but I still just ask my local machine.

Well then, I can just do this without you and use nats. Yes, you can... 

Did you spend over a decade researching and developing ways to make a messaging system work inside of a distributed Domain? We did.

Everything in a CIM communicates by Message.
Messages are one of 3 things: a Command (cmd), a Query (qry) or an Event (evt)

nats is our choice for message transport. Why nats?  It fits our model. You can do this with any MQTT style of client, but then you also get to figure out how to manage those queues and how to manage all the endpoints and policies. We have been doing it since the ethernet was invented.

We have tried a bunch of other ways to do this and settled on nats because it absolutely fits the model we are looking for, a durable, Subject based messaging system based on our Domain and designed to scale.

We can even do this with traditional tools such as Operating System dependent technologies, network shares, linux namespaces, user accounts and tcp streams... Good luck managing that on any level over a few machines.

We want to manage a Domain Model and Generate our technology needs... This was very clunky until recently. Code Generation meant Templates and mostly String Replacement without any real semantic content.

The Domain Model will always endeavor to become the Source of Truth, it may not be there initially and the Domain has to go ask for permission or guidance, but eventually it catches up.

From this "Source of Truth" we project our needs, whether that is a database, a dashboard, or some other business need. Different technologies have different generation techniques, some are still string replacement, but that gets enhanced by LLMs to work with semantic information in a vastly different way than we did in past techniques.

Instead of trying to corral everything we already have, let's create a fresh model and have the model replicate what we are already doing, then what we are already doing become the initial "Acceptance Tests" for taking over that particular part of Domain functionality.

This makes communication the #1 vital part of our working system and the messaging platform had better be robust.

nats is that robust.

We can depend on it and forget about hooking up 20 other ways to send messages.

Can I use nats to handle local message traffic on a web page? Yes, you can, though that may not be optimal for everything it is definitely how you will talk to anything in the Domain that isn't resident locally.

Where does my web server talk to the API? nats.
Where do I look up files? nats. 
How do I query my database? nats.

It's all nats... OMG, single point of failure...

Nope, nats is clustered and distributed.

A configuration is going to let the local nats Leaf Node talk to the nats Domain Cluster.
I don't have to figure that out, it's already stored in a configuration with all the right secrets referenced.

This eliminates about 95% of my problems with networking and how do I get things from here to there.

We move from handling each individual Entity and Value into a common way to make everything talk.

>I don't care what server it lives on, just give it to me. Your server moved? I don't care, where is the data I asked for?

>What do you mean I need to create an account to get the data?  Login... Again? 

These are all common problems with making systems communicate.

We just stop that in it's tracks.

This is a system and the system knows how to talk to itself without you telling it how.

Forget about connecting to 15 different URLs just to make an API work...

The API is just... there... available by message just like I would talk to it in the docs, or differently if you choose to do so...

Go to this REST address... fine, we just ship the payload into nats and let nats figures out where that goes and how to give you a response.  Javascript long polling... goodbye. WebSockets... goodbye. CORS... goodbye.

Management. This is what we want, not another limitation of point-to-point connections I have to continually monitor.

We have a couple new ideas to think about.

1.  I now have a universal stream of events I can draw from in real time.

2.  I can publish Commands and Queries to a local address and get responses from anywhere in the CIM.

> magic.

magic indeed.

This does eliminates a mountain of frustration if you are coming from a development past. Seriously, NixOS, git, nats, and benthos are that robust.

Think of it like this...

Every machine I make has some local functionality it needs to produce.
The machine can receive a stream of events.
The machine can make local queries and commands to remote resources.

Wait, what?

That's right.  What about DNS and Permissions and all that stuff?
It's in there, we just configure it all in the Domain and stop worrying about it.

I don't like your configurations...
Fine, make your own.

I don't like your...
Fine, make your own.

Seriously, if you want to make a Raspberry Pi your DNS Server, go ahead. At the very least you will know how it is configured and be able to reproduce it if it every fails... or move it to a massive server because you now have to serve 10,000 clients.

CIM is an Enabling technology, not a limiting one.

If you want a machine that runs Windows and makes Excel Files, that is perfectly fine.
If you want a machine that does nothing but report the temperature, then why do you need a text editor installed? You don't.

These "machines" send Commands and Queries, and Receive Events... other than that, you can make it "do" anything and get told what it did.

You may have Zero computers, you make have 10,000. It doesn't matter, you need to manage information.

When we abstract this out we can say:
  - Use this Configuration
  - Use this Hardware
  - I am this Person
  - Load it with these Events

And suddenly I have a working system in seconds, why would I try to manually install anything any more?

What about backups?  What is a backup? It's just a copy of data, sometimes in  a prepared format.  The Object Store can just do that for you... If you configure the Object Store to make a minimum of 3 copies, that's what it does, there is your "backup". If you need disaster recovery, you build an Object Store Cluster that has nodes in different Data Centers.  We already know how this works, now we just deploy it instead of figuring all that stuff out.

The Event Store *IS* your backup. So we make replicas of it and store it on differnt devices. It is totally immutable, so once written, it never, ever changes. You cannot delete it, although you can make snapshots to rollup the past and reduce active size versus archived size.

If you like playing around in free and open environments, keep doing that... on a dedicated system. When you are done playing around (i.e. developing and testing) you add it to the Domain and can then use that new technique you just made anywhere in the Domain.

It just boils down to a different way of thinking about things.

I don't have a "computer" any more, I have an Information Machine and that is a distributed thing that lives across the internet but acts like it's local. It has a structure and that structure is simple, has zero dependencies, it's a pile of text. I can transform that text into some working information system... repeatedly... with the same results.

I just got reliability of information and I am no longer chained to a vendor. Everything is portable and versioned via my Object Stores and their Event Stream.

Is this Perfect?
Certainly not, but we are evolving our way there.

[Comms](./comms.md)