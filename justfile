default:
    @just --list

# Run 'cargo run' on the project
run *ARGS:
    cargo run {{ARGS}}

watch *ARGS:
	bacon watch -- -- {{ ARGS }}

start: 
    bacon run

build:
    nix build .#cim

bin:
  result/bin/cim