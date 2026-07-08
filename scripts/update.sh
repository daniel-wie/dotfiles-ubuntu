#!/bin/bash

sudo apt update
sudo apt upgrade

cargo install-update --all
uv tool upgrade --all
julia -e 'using Pkg; Pkg.Apps.update()'
