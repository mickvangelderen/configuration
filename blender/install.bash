#!/usr/bin/env bash

sudo --validate | exit 1

sudo apt-get install nvidia-cuda-toolkit blender --yes
