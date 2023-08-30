#!/usr/bin/env bash

make

cd ./build/
ghdl -e --std=08 --ieee=synopsys -fsynopsys -fexplicit -o "$1_test" "$1_test"
ghdl -r --std=08 --ieee=synopsys -fsynopsys -fexplicit "$1_test" --wave="$1_wave.ghw" --stop-time=1ms
