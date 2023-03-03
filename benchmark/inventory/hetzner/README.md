# Hetzner 
We purchased and configured a Hetzner server in Germany to run benchmarks on. This is a good way to get a consistent environment for benchmarking.

## Provisioning the instance
This is already taken care of. The server is setup with:
- Ubuntu 22.04
- A user called `user` accessible by key authentication only
- `user` is a passwordless sudoer for all commands (this scope should be limited later) but can also run non-priviliged commands.
- You can log in with an SSH key from the Banyan team
- All you have to do is save our provided SSH key at `~/.ssh/id_hetzner` on your local machine
- The `host` file in this directory contains the IP address of the server and is set up to use the SSH key at that path

## Setting up the instance
There's nothing do here except install dependencies.

After appropriately configuring and moving `env/env.instance.hetzner`, you can do this with the following commands:
```bash
# Return to the root of the `benchmark` directory
cd ../../..
# Set up the instance
./scripts/setup.sh
```
You should only need to do this once -- probably not ever unless you need to re-install dependencies or the dependencies change.

### Destroying the instance
Don't worry about it. This is supposed to stay available.

done! :tada: 
