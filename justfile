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

buildimage:
    nix build .#cimImage

bin:
  result/bin/cim

load:
  docker load < result

loadnew:
  # just build
  just buildimage
  just load
  just tag-latest

tag-latest:
  docker tag cim:latest thecowboyai/cim-start:latest

push:
  docker push thecowboyai/cim-start:latest

drun:
  docker run --rm \
  -it thecowboyai/cim-start:latest \
  -e XDG_RUNTIME_DIR=/run/user/1000 \
  -e WAYLAND_DISPLAY=wayland-0 \
  -e QT_QPA_PLATFORM=wayland \
  -e GDK_BACKEND=wayland \
  -v /run/user/1000/wayland-1:/run/user/1000/