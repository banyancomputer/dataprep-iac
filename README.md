# Dataprep IaC

This repository contains the infrastructure as code for the Dataprep project.

Assumes Ubuntu 22.04 LTS.
## ansible

A library of ansible scripts for managing dependencies, services, users, and tasks.

[//]: # (## terraform)

## hosts
Host files for targetting specific hosts.

## env

Env files used to configure sets of tools

## scripts

Helper scripts to run against hosts

### benchmark

Used to configure, generate data for, and run large benchmarks on the `dataprep` tool. 
See the [README](_benchmark/README.md) for more information.

### demo

Used to configure, generate data for, and run a demo of the `dataprep` tool.
Designed to target a Hetzner SX134 instance.
See the [README](_demo/README.md) for more information.