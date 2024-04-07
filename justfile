default:
    @just --list

# Auto-format the source tree
fmt:
    treefmt

# Run 'cargo run' on the project
run:
    ./run.sh

# Run 'cargo build' or 'build vm' on the project
build:
    ./build.sh

# Run 'cargo test' on the project
test *ARGS:
    cargo test {{ARGS}}

# Run 'cargo watch' to run the project (auto-recompiles)
watch *ARGS:
    cargo watch -x "run -- {{ARGS}}"

