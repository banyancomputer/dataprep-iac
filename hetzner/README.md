# Hetzner
Hetzner is a German cloud provider that has some pretty cheap dedicated servers.
We use them for running benchmarks and other tests.

## Setting up the instance
We were lazy and just used the Hetzner console to set up the instance.
We deployed an AX101 instance with Ubuntu 22.04 installed. To get it to work, we had to do the following:
- Create an Ubunutu installation
- Restart the server
- Wait for the server to come back up. You'll get an email when it's ready.
- Log in to the server via SSH + the password you receive in the email
- Create your first ssh key for the instance
  - Create a new ssh key pair on your local machine. Name it `id_hetzner`
  - Add the ssh key to your ssh agent
- Add your ssh key to the server and require public key authentication
- Check if you can log in with your ssh key
- Once you can disable password authentication

You should now be able to log in to the server with your ssh key, and add
new ssh keys to the server.

## Connecting to the instance
If someone else has already set up the instance, you can connect to it by doing the following:

- Generate a new ssh key pair
  - put this ssh key under `~/.ssh/id_hetzner`
- share this key with someone who has access to the server. We use a password manager for this.
- get them to add your ssh key to the server as an allowed key
- log in to the server with your ssh key

Since the server runs as root, you should be able to do anything you want on the server now.