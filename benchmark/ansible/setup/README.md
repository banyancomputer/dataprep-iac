# Instance Setup Playbooks
A set of playbooks for setting up instances to run benchmarks on.
These playbooks should run to get an instance ready to run benchmarks on.
Anything specific to the instance type and how it implements the benchmark process should be implemented
in an instance-specific playbook in this directory.
i.e. `aws.yml` is a playbook that:
- installs dependencies such as git, rust, etc.
- mounts the volumes on the instance