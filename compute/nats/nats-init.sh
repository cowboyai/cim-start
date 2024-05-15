# Intent: 
#   Idempotent initialization of an Operator
#   and initial accounts/users in a NATS server

# beware - total destruction, you'll get an error if they already exist
# rm -rf ./nats/nsc/


# these are starter Accounts, you will add a bunch of these
Accounts=(
    "CIM"
    "Administrator"
    "Accounting"
    "Inventory"
    "Delivery"
    "Config"
    "Metadata"
    "Projections"
    "KeyValues"
    "Objects"
    "Services"
    "Agents"
    "Employee"
    "Database"
    "Development"
    "DevOps"
)

# init a fresh instance
nsc init -d ./nsc/stores
nsc add operator --generate-signing-key --sys --name cowboyai

nsc edit operator --sk generate

nsc edit operator --system-account SYS --require-signing-keys --account-jwt-server-url "nats://0.0.0.0:4222"


for account in ${Accounts[@]}; do
  nsc add account $account
  nsc edit account $account --sk generate
done

nsc add user --account CIM cim
nsc add user --account Administrators admin
nsc add user --account Accounting accountingAgent
nsc add user --account Inventory inventoryAgent
nsc add user --account Delivery deliveryAgent
nsc add user --account Config read
nsc add user --account Config write
nsc add user --account Metadata read
nsc add user --account Metadata write
nsc add user --account Projections read
nsc add user --account Projections write
nsc add user --account Database read
nsc add user --account Database write
nsc add user --account Objects read
nsc add user --account Objects write
nsc add user --account Services cmd
nsc add user --account Services qry
nsc add user --account Services event
nsc add user --account Agents ollama
nsc add user --account Agents neo4j
nsc add user --account Agents nats

#people
mkdir ./secrets/cowboyai/
nsc generate creds -a CIM -n cim > ./secrets/cowboyai/CIM.cim.creds
nsc generate creds -a Administrators -n admin > ./secrets/cowboyai.administrators.admin.creds
nsc generate creds -a Development -n steele > ./secrets/cowboyai.development.steele.creds
nsc generate creds -a Marketing -n jacob > ./secrets/cowboyai.marketing.jacob.creds
nsc generate creds -a Accounting -n david > ./secrets/cowboyai.accounting.david.creds
nsc generate creds -a delivery -n deliveryAgent > ./secrets/cowboyai.delivery.deliveryAgent.creds

# orgs
nsc generate creds -a Config -n read > ./secrets/cowboyai.config.read.creds
nsc generate creds -a Config -n write > ./secrets/cowboyai.config.write.creds
nsc generate creds -a Metadata -n read > ./secrets/cowboyai.metadata.read.creds
nsc generate creds -a Metadata -n write > ./secrets/cowboyai.metadata.write.creds
nsc generate creds -a Projections -n read > ./secrets/cowboyai.projections.read.creds
nsc generate creds -a Projections -n write > ./secrets/cowboyai.projections.write.creds
nsc generate creds -a Objects -n read > ./secrets/cowboyai.objects.read.creds
nsc generate creds -a Objects -n write > ./secrets/cowboyai.objects.write.creds
nsc generate creds -a Database -n read > ./secrets/cowboyai.database.read.creds
nsc generate creds -a Database -n write > ./secrets/cowboyai.database.write.creds
nsc generate creds -a Services -n cmd > ./secrets/cowboyai.services.cmd.creds
nsc generate creds -a Services -n qry > ./secrets/cowboyai.services.qry.creds
nsc generate creds -a Services -n event > ./secrets/cowboyai.services.event.creds
nsc generate creds -a Agents -n ollama > ./secrets/cowboyai.agents.ollama.creds
nsc generate creds -a Agents -n neo4j > ./secrets/cowboyai.agents.neo4j.creds
nsc generate creds -a Agents -n nats > ./secrets/cowboyai.agents.nats.creds

nsc generate config --nats-resolver --sys-account SYS > ./secrets/cowboyai-resolver.conf

#nats-server -c ./secrets/cowboyai-resolver.conf
#nsc push -A

# smoke test
# nats-server -c ./secrets/cowboyai-resolver.conf   
# cargo run
# nats context add localhost --creds secrets/cowboyai.agents.nats.creds --server localhost:4222 --description "CIM-NATS" --select
# nats pub agents.nats.qry "status"

# This should respond with an event saying: "We have just started a conversation... 
# or "We are are talking about x using the mistral model..."
# try just typing the single word status in the middle of a conversation on OpenAI... 
# You'll be certain to get some interesting and bizarre results
# there are several keywords, which used without any other context will just 
# reply with sensible results of a Command if there is one associated with the word or phrase
# We are sensibly adding Domain Context when appropriate.

# nats-server --signal quit

# echo "done."
