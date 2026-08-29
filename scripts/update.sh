#!/bin/bash

sudo apt update
sudo apt upgrade

uv tool upgrade --all
julia -e 'using Pkg; Pkg.Apps.update()'
