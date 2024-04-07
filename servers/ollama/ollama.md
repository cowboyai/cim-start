# Ollama
>Get up and running with large language models locally.

Currently supported [Models](https://ollama.com/library).

A few selected models we tend to favor

| Model |	Parameters |	Size |	Download|
|-------|------------|-------|----------|
| Code Llama 	        |7B 	|3.8GB 	  | ollama pull codellama|
| Open Chat 	        |7B 	|4.1GB 	  | ollama pull openchat|
| Mistral 	          |7B 	|4.1GB 	  | ollama pull mistral|
| Llama 2 	          |7B 	|3.8GB 	  | ollama pull llama2|
| Neural Chat 	      |7B 	|4.1GB 	  | ollama pull neural-chat|
| Llama 2 Uncensored 	|7B 	|3.8GB 	  | ollama pull llama2-uncensored|
| Llama 2 13B 	      |13B  |7.3GB 	  | ollama pull llama2:13b|
| Vicuna 	            |7B 	|3.8GB 	  | ollama pull vicuna|

This server will establish a running ollama instance ready to talk over the local NATS server at http://127.0.0.1:4222

Instead of issuing curl commands or talking to rest, we simply send Messages to our CIM.
The content of the Message is exactly the syntax of the Rest API for simplicity and documentation.
We just make it convenient to get the message there, let you load-balance, and make multi-agent decisions, more on that soon.

At first we want to establish the ability to chat.

## Cmd:

pull
  - pull a model:      pull `model`
generate
  - Generate a response for a given prompt with a provided model. This is a stream.    
chat                 
  - Generate the next message in a chat with a provided model. This is a stream.
embeddings  
  - Generate embeddings from a model         
create               
  - Create a model
push              
  - Push a model   
copy            
  - Copy a model     
delete          
  - Delete a model     
blobs
  - attach a file (such as an image or document)

## Qry:

show                 
  - show the settings
tags
  - list tags requested
version
  - get version of ollama server

## Evt:

pulled              --> Pulled a Model
generated           --> Generated a Response
chat_sent           --> msg for chat sent
embedded            --> embedding has been embedded
created             --> model created
pushed              --> model pushed (to ollama servers)
copied              --> model copied
deleted             --> model deleted
blob_saved          --> large object saved for reference
blob_retrieved      --> large object read
