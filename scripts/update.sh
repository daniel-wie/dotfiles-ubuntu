#!/bin/bash

sudo apt update
sudo apt upgrade

cargo install-update --all
uv tool upgrade --all
