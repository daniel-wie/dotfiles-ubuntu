#!/bin/bash

# https://aviatesk.github.io/JETLS.jl/release/#index/server-installation/install
julia -e 'using Pkg; Pkg.Apps.add(; url="https://github.com/aviatesk/JETLS.jl", rev="release")'
