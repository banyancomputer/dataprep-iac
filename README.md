# Dataprep IaC

This repository contains the infrastructure as code for the Dataprep project.

Assumes Ubuntu 22.04 LTS.
## ansible

[//]: # (## terraform)

## hosts

## env

Used to configure commands to run on remote machines.

## utils

## scripts

### benchmark

Used to configure, generate data for, and run large scale benchmarks on `dataprep` tool. 
Can target local machines or remote instances.
See the [README](_benchmark/README.md) for more information.

### demo

Used to configure, generate data for, and run a demo of the `dataprep` tool.
Designed to target a Hetzner SX134 instance.
See the [README](_demo/README.md) for more information.