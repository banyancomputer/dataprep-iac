# Dataprep IaC

This repository contains the infrastructure as code for the Dataprep project.

## Dependencies
- Python
- Ansible

## Layout

Assumes Ubuntu 22.04 LTS.
### ansible

A library of ansible scripts for managing dependencies, services, users, and tasks.

[//]: # (## terraform)

### hosts
Host files for targetting specific hosts.

### env

Env files used to configure sets of tools. These are discussed in further READMEs

### scripts

Helper scripts to run against hosts

## Workflows

### Benchmark

Used to configure, generate data for, and run large benchmarks on the `dataprep` tool. 
See the [README](BENCHMARK.md) for more information.

### demo

Used to configure, generate data for, and run a demo of the `dataprep` tool.
Designed to target a Hetzner SX134 instance and integrate with NFS client for sharing output.
See the [README](DEMO.md) for more information.