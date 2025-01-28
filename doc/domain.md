### Domain

A **Domain** in this context refers to a conceptual structure that supports reasoning about computation through approximation and limits. While this draws inspiration from mathematical domain theory, we use it as a guiding principle rather than rigidly applying the math. Domains are treated as *destinations*—a goal to improve towards until the underlying mathematical tests work.

Domains are not necessarily hierarchical; they are "topological spaces," meaning they have a shape or structure, but it's not constrained to a tree-like form. In computer science, we often default to hierarchical sets like filesystems, hosts, and programs. However, we aim to break free from this limitation and think in terms of **graphs**, specifically **Merkle Directed Acyclic Graphs (Merkle DAGs)**. These graphs allow us to represent relationships more flexibly and avoid the pitfalls of rigid hierarchies.

For example, if users are organized under hosts in a hierarchy, you must repeat user data for every host. By linking them as modules, you effectively break the hierarchy because the user domain exists outside the host domain. This approach emphasizes that domains are related but not confined to tree structures. Instead, we see domains as interconnected graphs that can consume and interact with other domains without enforcing a strict hierarchy.

Merkle DAGs play a crucial role here because they allow us to organize "blocks" of data (specific sets of bits) into structures where every block can be uniquely identified by a **Content Identifier (CID)**. This is foundational for distributed systems like NixOS, which generates immutable derivations with distinct CIDs. By combining these CIDs into larger structures, we can describe entire systems or datasets with a single CID using methodologies like **IPLD (InterPlanetary Linked Data)**. CIM leverages IPLD to manage its object store and event store, starting with Git as both an object repository and an event store.

---

### Events

An **event** is anything that has already happened and can be described. A **Domain Event** is an event that has occurred and is relevant within a specific domain. Events differ from logs in that they are structured for reactivity rather than just being a sequential record of actions.

Event stores and log files share similarities—they both represent sequential logs of transactions—but event stores are designed for structured reactivity. Git serves as an excellent example of an event store because it records changes (commits) in an immutable, append-only log. Each commit represents a snapshot of the repository at a specific time, containing metadata such as the author, timestamp, and description of changes. This aligns with event sourcing principles by capturing every change as an event in chronological order within Git's Directed Acyclic Graph (DAG).

NixOS also integrates this concept by recommending that every `flake.nix` resides at the root of a Git repository. This is because Git commits serve as Nix's event store, enabling reproducibility and traceability across system states. While Git provides an initial implementation for events in CIM, additional message buses and dedicated event stores will be introduced over time to build a complete ecosystem driven by events.

---

### Key Points

- **Domains**:
  - Are conceptual structures resembling graphs rather than hierarchies.
  - Use Merkle DAGs to organize data into uniquely identifiable blocks via CIDs.
  - Allow flexible relationships between entities without enforcing rigid hierarchies.
  - Leverage IPLD for distributed systems like CIM's object and event stores.

- **Events**:
  - Represent things that have already happened; domain events are those relevant to the domain.
  - Differ from logs by being structured for reactivity.
  - Git acts as an event store by recording immutable commits in chronological order.
  - NixOS utilizes Git commits as its event store for reproducibility and traceability.

By thinking in terms of graphs and events rather than hierarchies and logs, we unlock new possibilities for building distributed systems that are modular, reactive, and scalable.
