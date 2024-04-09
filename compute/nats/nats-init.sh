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
nsc add operator --generate-signing-key --sys --name CIM-start

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
mkdir ./secrets/cim-start/
nsc generate creds -a CIM -n cim > ./secrets/cim-start/CIM.cim.creds
nsc generate creds -a Administrators -n admin > ./secrets/cim-start.administrators.admin.creds
nsc generate creds -a Marketing -n lane > ./secrets/cim-start.inventory.inventoryAgent.creds
nsc generate creds -a Accounting -n janet > ./secrets/cim-start.accounting.accountingAgent.creds
nsc generate creds -a delivery -n deliveryAgent > ./secrets/cim-start.delivery.deliveryAgent.creds

# orgs
nsc generate creds -a Config -n read > ./secrets/cim-start.config.read.creds
nsc generate creds -a Config -n write > ./secrets/cim-start.config.write.creds
nsc generate creds -a Metadata -n read > ./secrets/cim-start.metadata.read.creds
nsc generate creds -a Metadata -n write > ./secrets/cim-start.metadata.write.creds
nsc generate creds -a Projections -n read > ./secrets/cim-start.projections.read.creds
nsc generate creds -a Projections -n write > ./secrets/cim-start.projections.write.creds
nsc generate creds -a Objects -n read > ./secrets/cim-start.objects.read.creds
nsc generate creds -a Objects -n write > ./secrets/cim-start.objects.write.creds
nsc generate creds -a Database -n read > ./secrets/cim-start.database.read.creds
nsc generate creds -a Database -n write > ./secrets/cim-start.database.write.creds
nsc generate creds -a Services -n cmd > ./secrets/cim-start.services.cmd.creds
nsc generate creds -a Services -n qry > ./secrets/cim-start.services.qry.creds
nsc generate creds -a Services -n event > ./secrets/cim-start.services.event.creds
nsc generate creds -a Agents -n ollama > ./secrets/cim-start.agents.ollama.creds
nsc generate creds -a Agents -n neo4j > ./secrets/cim-start.agents.neo4j.creds
nsc generate creds -a Agents -n nats > ./secrets/cim-start.agents.nats.creds

nsc generate config --nats-resolver --sys-account SYS > ./secrets/cim-start-resolver.conf

#nats-server -c ./secrets/cim-start-resolver.conf
#nsc push -A

# smoke test
# nats-server -c ./secrets/cim-start-resolver.conf   
# cargo run
# nats context add localhost --creds secrets/cim-start.agents.nats.creds --server localhost:4222 --description "CIM-NATS" --select
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
