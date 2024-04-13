# CIM Developement Environment
The CIM Development Environment is a NixOS VM tailored to run tests and deployments to the CIM-DEV network.

This is where we flesh out all the events that happen for the construction of our Domain.

It is where we build and use the system to visualize what is actually going on.

# Testing
Testing is done in at least 3 phases:
- **Unit Testing**
  - Testing individual parts by dynamic range. 
    - aka *Property Testing*
    - Instead of writing tests for specific input/output examples, you define properties or invariants that the code should obey for all possible inputs. A property is a high-level specification of the expected behavior. For example, a property for sorting a list could be: "The sorted list should contain the same elements as the original list."
- **Build Testing**
  - Testing that all the parts build what they are supposed to build and that they connect as expected.
  - Integration Testing and Load Testing are fulfilled in this range of testing
- **Acceptance Testing**
  - Testing individual inputs and outputs for expected results.
  - Compare expected business operation results to be fulfilled by specific inputs
  