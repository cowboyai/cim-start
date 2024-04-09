# Compiling things...
We have to compile...
There are a hundred ways to set this up...
we suggest:
https://nixos.org/manual/nixpkgs/stable/#rust
https://nixos.org/manual/nixpkgs/stable/#compiling-rust-crates-using-nix-instead-of-cargo


# Why should I use Nix?
nix offers us an immutable store for everything running on the system.
While cargo will compile everything, it won't do anything about the environment you are running in.
Nix takes care of all that, we can wrap our application in any sort of compute environment required.
Then we can deploy it automatically, checking all the tests before deployment.
