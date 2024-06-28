# CIM-Ollama
>Get up and running with large language models locally.

Currently supported [Models](https://ollama.com/library).

A few selected models we tend to favor...

The image size is currently 32G, so about 7 or 8 models can be cached.
You are free to change the size of the drive in [configuration.nix](./configuration.nix)

| Model |	Parameters |	Size |	Download|
|-------|------------|-------|----------|
| Code Llama 	        |7B 	|3.8GB 	  | pull codellama|
| Llava      	        |7B 	|4.1GB 	  | pull llava|
| Open Chat 	        |7B 	|4.1GB 	  | pull openchat|
| Mistral 	          |7B 	|4.1GB 	  | pull mistral|
| Llama 2 	          |7B 	|3.8GB 	  | pull llama2|
| Magicoder           |7B 	|3.8GB 	  | pull magicoder|
| Neural Chat 	      |7B 	|4.1GB 	  | pull neural-chat|
| Llama 2 Uncensored 	|7B 	|3.8GB 	  | pull llama2-uncensored|
| Llama 2 13B 	      |13B  |7.3GB 	  | pull llama2:13b|
| Vicuna 	            |7B 	|3.8GB 	  | pull vicuna|

This server will establish a running ollama instance ready to talk over the local NATS server at http://127.0.0.1:4222 using ollama.cmd, ollama.qry and ollama.evt channels

Instead of issuing curl commands or talking to rest, we simply send Messages to our CIM.
The content of the Message is exactly the syntax of the Rest API for simplicity and documentation.
We just make it convenient to get the message there, let you load-balance, and make multi-agent decisions, more on that soon.

At first we want to establish the ability to chat.

These are all underlying Commands that will be extracted based on the content of your message.
We utilize natural language programming to allow you to just have a conversation and not have to remember dozens of commands.

## Cmd:

**PullModel**
  - Pull a remote model to local
    - examples
      - "pull the vicuna model"
      - "pull vicuna"
      - "vicuna"
      - These will all pull the model and tell you when it's ready.
      - If you specify a model that is not loaded, there is a setting to auto-download it.
      - Once we start pulling these models, they are cached locally and can be shared between instances.
      - There is a setting for the default model. We download mistral on first run if no models are present.
      - 
**Generate**
  - Generate a response for a given prompt with a provided model. This will start a new chat. This is a stream.
    - examples"
      - "start a new llava chat, here are your instructions..."
      - "let's start over"
      - "tell me a story" (when no chat has been started, just start talking.)
      - "generate" (you will get a reply that the model is ready for a new chat)
      - If you do not specify a model, the default is used (currently mistral, change it in settings)

**Chat**                 
  - Generate the next message in a chat with a provided model. This is a stream.
    - examples:
      - "can you give me that in json format?" (to continue the chat and get a different response)
      - "try again"
      - "... some continued conversation until instructed to start a new chat."
      - abandon the chat for 5 minutes and it resets (you can reload the conversation)

**GetChat**
  - Get a previous chat
    - get any previous chat and continue, branch or abandon it.

**GetChatInfo**
  - retrieve the metadata about a chat
  
**GenerateEmbedding**  
  - Generate embedding from a model
    - ask the model to analyze text for RAG and respond with an array of vectors.

**SaveEmbedding**  
  - Generate embedding from a model
    - ask the model to analyze text for RAG and respond with an array of vectors.

**CreateModel**               
  - Create a model (this is how to create Agents)

**PushModel**              
  - Push a model (to the Ollama store, id required)

**CopyModel**            
  - Copy a model and give it a new name    

**DeleteModel**          
  - Delete a model     

**GetObject**
  - attach a file (such as an image or document)

**SaveObject**
  - attach a file (such as an image or document)

**Settings**
  - Change settings

## Qry:

**ShowModelInfo**                 
  - show the model settings

**ListModels**
  - list local models

**AvailableModels**
  - list remote models

**GetSettings**
  - Get Settings (of user)

**GetVersion**
  - get version of ollama server

## Evt:

**ModelPulled**
  - Pulled a Model

**ResponseGenerated**
  - Generated a Response

**ChatSent**
  - msg for chat sent (ack)

**EmbeddingGenerated**
  - embedding has been embedded

**EmbeddingSaved**
  - embedding saved as an Object for future retrieval

**ModelCreated**
  - a new model has been created

**ModelPushed**
  - model pushed (to ollama servers)

**ModelCopied**
  - model copied

**ModelDeleted**
  - model deleted

**BlobSaved**
  - large object saved for reference (cid provided)

**BlobRetrieved**
  - Large object read (cid provided)

**ChatRetrieved**
  - Historical chat retrieved

**ChatInfoRetrieved**
  - Chat metadta retrieved
