# Intent: 
#   Idempotent initialization of an Operator
#   and initial accounts/users in a NATS server

# beware - total destruction
rm -rf ./nats/nsc/stores/lucyslemonade

Accounts=(
    "Partners"
    "IT"
    "Marketing"
    "Accounting"
    "Inventory"
    "Delivery"
    "Config"
    "Metadata"
    "Projections"
    "Objects"
    "Services"
    "Agents"
)

# init a fresh instance
nsc init -d ./nats/nsc/stores
nsc add operator --generate-signing-key --sys --name lucyslemonade

nsc edit operator --sk generate

nsc edit operator --system-account SYS --require-signing-keys --account-jwt-server-url "nats://0.0.0.0:4222"


for account in ${Accounts[@]}; do
  nsc add account $account
  nsc edit account $account --sk generate
done

nsc add user --account Partners lucy
nsc add user --account IT luke
nsc add user --account Marketing lane
nsc add user --account Accounting janet
nsc add user --account Inventory maggie
nsc add user --account Delivery jose
nsc add user --account Config read
nsc add user --account Config write
nsc add user --account Metadata read
nsc add user --account Metadata write
nsc add user --account Projections read
nsc add user --account Projections write
nsc add user --account Objects read
nsc add user --account Objects write
nsc add user --account Services cmd
nsc add user --account Services qry
nsc add user --account Services event
nsc add user --account Agents sage

#people
nsc generate creds -a Partners -n lucy > ./secrets/lucyslemonade.partners.lucy.creds
nsc generate creds -a IT -n luke > ./secrets/lucyslemonade.it.luke.creds
nsc generate creds -a Marketing -n lane > ./secrets/lucyslemonade.marketing.lane.creds
nsc generate creds -a Accounting -n janet > ./secrets/lucyslemonade.accounting.janet.creds
nsc generate creds -a Inventory -n maggie > ./secrets/lucyslemonade.inventory.maggie.creds
nsc generate creds -a Delivery -n jose > ./secrets/lucyslemonade.delivery.jose.creds

# orgs
nsc generate creds -a Config -n read > ./secrets/lucyslemonade.config.read.creds
nsc generate creds -a Config -n write > ./secrets/lucyslemonade.config.write.creds
nsc generate creds -a Metadata -n read > ./secrets/lucyslemonade.metadata.read.creds
nsc generate creds -a Metadata -n write > ./secrets/lucyslemonade.metadata.write.creds
nsc generate creds -a Projections -n read > ./secrets/lucyslemonade.projections.read.creds
nsc generate creds -a Projections -n write > ./secrets/lucyslemonade.projections.write.creds
nsc generate creds -a Objects -n read > ./secrets/lucyslemonade.projections.read.creds
nsc generate creds -a Objects -n write > ./secrets/lucyslemonade.projections.write.creds
nsc generate creds -a Services -n cmd > ./secrets/lucyslemonade.projections.cmd.creds
nsc generate creds -a Services -n qry > ./secrets/lucyslemonade.projections.qry.creds
nsc generate creds -a Services -n event > ./secrets/lucyslemonade.projections.event.creds
nsc generate creds -a Agents -n sage > ./secrets/lucyslemonade.agents.sage.creds

nsc generate config --nats-resolver --sys-account SYS > ./secrets/resolver.conf

#nats-server -c ./secrets/resolver.conf
#nsc push -A

# smoke test
# nats-server -c ./secrets/resolver.conf   
# cargo run
# nats context add localhost --creds secrets/lucyslemonade.agents.sage.creds --server localhost:4222 --description "Localhost" --select
# nats pub agents.sage.qry "What is Lucy's Lemonade?"

# nats-server --signal quit

# echo "done."
