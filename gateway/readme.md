# Gateway
This is your adaptation of a foreign API into your ecosystem.

The goal here is to map the API into our canonical messaging safely.

While just exposing the API is perfectly fine, you would then need to handle point-to-point communications.

CIM Operates on a Message Bus. 

This means all communication is sent to the Bus and the Bus figures out where to send it.

It also means I don't have to troubleshoot all the possible communication problems...

We send a message, get an acknowledgement the message was received and potentially more Events containing any results of the message.

This is far easier to manage than handling a dozen APIs individually no matter how well written.
Just managing that network is a problem.

With NATS, all we need is a connection to a server, either local or remote and we are done.
APIs route themselves over the connected NATS servers to arrive at the proper destination in the Domain.