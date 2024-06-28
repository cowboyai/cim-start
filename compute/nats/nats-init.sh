# Intent: 
#   Idempotent initialization of an Operator
#   and initial accounts/users in a NATS server

# exit if they already exist, this is for initialization only, not maintenance
if [ -d /nats/nsc/ ]; then
  echo "nats exists... exiting."
else
  echo "Initializing nats..."
  mkdir -p /nats/nsc
  cd /nats
fi


# these are starter Accounts, you will add a bunch of these
Accounts=(
    "CIM"
    "Administrators"
    "Accounting"
    "Inventory"
    "Marketing"
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
nsc init -d /nats/nsc/stores
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

nsc add user --account Development steele
nsc add user --account Accounting david
nsc add user --account Marketing jacob


#people
mkdir -p /nats/secrets/
nsc generate creds -a CIM -n cim > /nats/secrets/cowboyai.CIM.cim.creds
nsc generate creds -a Administrators -n admin > /nats/secrets/cowboyai.administrators.admin.creds
nsc generate creds -a Development -n steele > /nats/secrets/cowboyai.development.steele.creds
nsc generate creds -a Marketing -n jacob > /nats/secrets/cowboyai.marketing.jacob.creds
nsc generate creds -a Accounting -n david > /nats/secrets/cowboyai.accounting.david.creds
nsc generate creds -a Delivery -n deliveryAgent > /nats/secrets/cowboyai.delivery.deliveryAgent.creds

# orgs
nsc generate creds -a Config -n read > /nats/secrets/cowboyai.config.read.creds
nsc generate creds -a Config -n write > /nats/secrets/cowboyai.config.write.creds
nsc generate creds -a Metadata -n read > /nats/secrets/cowboyai.metadata.read.creds
nsc generate creds -a Metadata -n write > /nats/secrets/cowboyai.metadata.write.creds
nsc generate creds -a Projections -n read > /nats/secrets/cowboyai.projections.read.creds
nsc generate creds -a Projections -n write > /nats/secrets/cowboyai.projections.write.creds
nsc generate creds -a Objects -n read > /nats/secrets/cowboyai.objects.read.creds
nsc generate creds -a Objects -n write > /nats/secrets/cowboyai.objects.write.creds
nsc generate creds -a Database -n read > /nats/secrets/cowboyai.database.read.creds
nsc generate creds -a Database -n write > /nats/secrets/cowboyai.database.write.creds
nsc generate creds -a Services -n cmd > /nats/secrets/cowboyai.services.cmd.creds
nsc generate creds -a Services -n qry > /nats/secrets/cowboyai.services.qry.creds
nsc generate creds -a Services -n event > /nats/secrets/cowboyai.services.event.creds
nsc generate creds -a Agents -n ollama > /nats/secrets/cowboyai.agents.ollama.creds
nsc generate creds -a Agents -n neo4j > /nats/secrets/cowboyai.agents.neo4j.creds
nsc generate creds -a Agents -n nats > /nats/secrets/cowboyai.agents.nats.creds

nsc generate config --nats-resolver --sys-account SYS > /nats/secrets/cowboyai-resolver.conf

nats-server -c /nats/secrets/cowboyai-resolver.conf&
nsc push -A

# smoke test
# nats-server -c /nats/secrets/cowboyai-resolver.conf   
# cargo run
# nats context add localhost --creds /nats/secrets/cowboyai.agents.nats.creds --server localhost:4222 --description "CIM-NATS" --select
# nats pub agents.nats.qry "status"
# This should respond with an event.

nats-server --signal quit

echo "done."
