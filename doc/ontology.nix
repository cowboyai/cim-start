{
  ontology = {
    nixConcepts = {
      # Fundamental Nix & Flakes Terminology
      core = [
        "`flake`"
        "`inputs`"
        "`outputs`"
        "`packages`"
        "`apps`"
        "`nixosModules`"
        "`nixosConfigurations`"
        "`devShells`"
        "`templates`"
        "`derivation`"
        "`store`"
        "`module`"
        "`component`"
        "`morphism`"
      ];

      # Extended Nix Infrastructure & Usage
      infra = [
        "`container`"
        "`virtual machines`"
        "`bare metal`"
        "`cloud`"
        "`docker`"
        "`kubernetes`"
        "`data center`"
      ];

      # Git & Repository-Related
      repos = [
        "`remote`"
        "`git`"
        "`repo`"
        "`url`"
        "`submodules`"
      ];

      # Nix Concept Relationships
      relationships = {
        "flake" = {
          definition = "A Nix concept bundling inputs/outputs into a reproducible unit.";
          includes = [ "inputs" "outputs" "packages" "apps" "devShells" ];
        };

        "inputs" = {
          definition = "References to external Nix packages or code.";
          usedBy = [ "flake" ];
        };

        "outputs" = {
          definition = "Defined results from a flake (packages, apps, etc.).";
          usedBy = [ "flake" ];
        };

        "packages" = {
          definition = "Buildable artifacts (often derivations) defined in a flake.";
          usedBy = [ "outputs" ];
        };

        "apps" = {
          definition = "Runnable commands exposed by a flake.";
          relatedTo = [ "packages" ];
        };

        "nixosModules" = {
          definition = "Nix modules to configure systems at a higher level of abstraction.";
          extends = [ "module" ];
        };

        "nixosConfigurations" = {
          definition = "Full system definitions for NixOS-based systems.";
          dependsOn = [ "nixosModules" ];
        };

        "devShells" = {
          definition = "Developer environments produced by a flake.";
          relatedTo = [ "packages" ];
        };

        "templates" = {
          definition = "Reusable skeletons or scaffolds for new projects.";
          relatedTo = [ "flake" ];
        };

        "derivation" = {
          definition = "A low-level build instruction that results in a store path.";
          usedBy = [ "flake" "packages" ];
        };

        "store" = {
          definition = "Location where Nix stores build outputs.";
          usedBy = [ "derivation" ];
        };

        "module" = {
          definition = "A configuration unit that can be combined with other modules.";
        };

        "component" = {
          definition = "A piece of software or configuration that can be assembled into a system.";
        };

        "morphism" = {
          definition = "A function or transformation applied to produce a derivation.";
          relatedTo = [ "derivation" ];
        };
      };
    };

    dddConcepts = {
      # Core DDD & Event-Sourcing Terminology
      core = [
        "`domain`"
        "`DDD`"
        "`Eventsourcing`"
        "`ubiquitous language`"
        "`domain events`"
        "`entity`"
        "`event`"
        "`actions`"
        "`bounded context`"
      ];

      # Supporting DDD Structures
      structures = [
        "`aggregate`"
        "`value object`"
        "`repository`"
        "`service`"
      ];

      # Miscellaneous DDD and Business
      business = [
        "`component`"
        "`application`"
        "`events`"
        "`distributed information systems`"
        "`business processes`"
        "`domain approach`"
        "`authoritative`"
      ];

      # DDD Concept Relationships
      relationships = {
        "domain" = {
          definition = "A sphere of knowledge or activity that the software addresses.";
        };

        "DDD" = {
          definition = "A methodology focusing on a model-driven approach to complex software.";
          includes = [ "ubiquitous language" "bounded context" "domain events" ];
        };

        "Eventsourcing" = {
          definition = "Capturing changes in state as a series of events.";
          publishes = [ "domain events" ];
        };

        "ubiquitous language" = {
          definition = "A shared language bridging developers and domain experts.";
          fosters = [ "communication" "consistency" ];
        };

        "domain events" = {
          definition = "Occurrences in the domain that are relevant to the model.";
          usedBy = [ "Eventsourcing" ];
        };

        "entity" = {
          definition = "An object with identity tracked through a lifecycle.";
        };

        "event" = {
          definition = "A record of something that happened in the system.";
        };

        "actions" = {
          definition = "Operations that lead to state changes, often resulting in new events.";
        };

        "bounded context" = {
          definition = "A boundary within which a specific domain model is consistently applied.";
        };

        "aggregate" = {
          definition = "A cluster of domain objects treated as a unit.";
        };

        "value object" = {
          definition = "An object that is identified only by its properties, with no unique identity.";
        };

        "repository" = {
          definition = "Mediates between the domain and data mapping layers.";
        };

        "service" = {
          definition = "Stateless domain operation that doesn't naturally fit an entity or value object.";
        };

        "component" = {
          definition = "An encapsulated part of the system, also used in Nix for packaging.";
        };

        "application" = {
          definition = "A running process or system delivering domain functionality.";
          relatedTo = [ "component" ];
        };

        "events" = {
          definition = "A general reference to occurrences changing or reflecting domain state.";
        };

        "distributed information systems" = {
          definition = "Systems whose components are located on networked computers.";
        };

        "business processes" = {
          definition = "Workflows or procedures that fulfill the requirements of the domain.";
        };

        "domain approach" = {
          definition = "Strategies emphasizing the importance of domain concepts in architecture.";
        };

        "authoritative" = {
          definition = "A source considered official or definitive for a domain concept.";
        };
      };
    };
  };
}
