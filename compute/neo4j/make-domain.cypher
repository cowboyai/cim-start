// Domain
CREATE (domain:Domain {name:"CowboyAI", uuid:"3d1bd0cf-46e0-46e2-8b0b-f479e2cba396"})<-[relationship:IDENTIFIED_AS]-(fqdn:FQDN {name:"cim.thecowboy.ai"}) RETURN domain, fqdn, relationship;

// Organizations
CREATE (orgs:Organization {name:"Cowboy AI, LLC"});

// People
CREATE (people:Person {full_name:"Harry Steele Price, IV", name:"Steele"});
CREATE (people:Person {full_name:"David Kopilovitch", name:"David"});
CREATE (people:Person {full_name:"Jacob Kopilovitch", name:"Jace"});

// Domain Owner
MATCH (domain:Domain {name: "CowboyAI"})
MATCH (orgs:Organization {name: "Cowboy AI, LLC"})
CREATE (orgs)-[r:OWNS]->(domain);

// Employees
MATCH (org:Organization {name: "Cowboy AI, LLC", type: "LLC"})
MATCH (person:Person {name: "Steele"})
CREATE (org)-[r:employs {position: "Chief Science Officer", is_founder: true, is_member: true}]->(person);

MATCH (org:Organization {name: "Cowboy AI, LLC"})
MATCH (person:Person {name: "David"})
CREATE (org)-[r:employs {position: "COO", is_founder: true, is_member: true}]->(person);

MATCH (org:Organization {name: "Cowboy AI, LLC"})
MATCH (person:Person {name: "Jace"})
CREATE (org)-[r:employs {position: "CEO", is_founder: true, is_member: true}]->(person);

