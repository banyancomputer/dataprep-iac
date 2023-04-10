# dataprep-iac: Benchmark

Repository for orchestrating benchmarks in local and remote environments.
All you have to do is setup some keys, write some configs, and run the scripts :tada:

## Dependencies
- Python
- Ansible

## Benchmark Process Overview
This directory provides IaC meant for running `dataprep` on large amounts of data.
It is meant to be used a performance metric tool for realistic workflows.
As such it runs the whole `pack` and `unpack` process on a series of inputs, and measures the time it takes to complete.
It does *not* perform multiple iterations of the process on the same input -- it is not a statistically driven benchmark.
It is not necessarily meant as a developer tool for identifying performance bottlenecks, though it can (eventually) be used for that purpose once those types of benchmarks are added.
As a developer on `dataprep` you should:
- Develop and test your code locally
- Run project benchmarks on your local machine to get a baseline for performance using `cargo bench`
- If you observe performance gains, and want to verify them on a larger scale, run benchmarks on a remote machine:
  - Push your code to a branch on GitHub
  - Install the latest version of your branch on the remote machine (described below)
  - Run benchmarks on the remote machine using this repository (described below)
  - Compare and publicly share your results:
    - Pull the results of the benchmark from the remote machine (described below)
    - Compare the results of the benchmark on your local machine and the remote machine
    - If note-worthy, share your results with team. Commit your results to the repository in a branch named after the one you used to run the benchmark. Open a PR when you gather enough data and are ready to share your results.

## Benchmark Process Assumptions and Organization
The benchmark process is meant to be run across different instances and environments while maintaining a consistent setup, configuration, and run process.
As such, the following behavior and assumptions are made. If they do not make sense, look at an example `env/env.instance.*` and come back to this section.
You should make sure that these assumptions are true for your environment before running the benchmark process.

[//]: # (TODO: Git versioned benchmarks)
[//]: # (- Version control is important. The benchmark process will keep track of what commit you are benchmarking, and will save the results of the benchmark in a folder named after that commit.)

- When running the benchmark (described below), the benchmark process will iterate over all files and directories in your
`INPUT_PATH` and run the end-to-end `pack` and `unpack` process on each one.
- So long as the `INPUT_PATH` is a directory, and has at least one file or directory in it, the benchmark will run. 
- Results will be saved on the instance under the name of the file or directory that was benchmarked.
- The `PACKED_PATH` is where outputs of `dataprep pack` are placed. It should have enough space to store the output of any `pack` process that is run on the inputs in `INPUT_PATH`. These files are cleaned up after an input is processed.
- The `UNPACKED_PATH` should have enough space to store the output of any `unpack` process that is run on the inputs in `INPUT_PATH` (It should be at least as large as `INPUT_PATH`). These files are cleaned up after an input is processed.
- The `MANIFEST_PATH` should have enough space to store any manifests output by `dataprep pack`. These files are cleaned up after an input is processed.
- The `RESULT_PATH` is where the benchmark process will save the results of the benchmark. It should have enough space to store the results of all inputs in `INPUT_PATH`. These files persist after the benchmark process is complete. 

So long as you setup your inputs and environment to reflect these assumptions, you should be able to run the benchmark process on any instance or local environment.

## Supported instance types
- hetzner
  - This is an AX101 dedicated server from Hetzner.

## Setting up your environment 
Read the documentation for your instance type in `inventory/<instance_type>/README.md`.
Once you've read the documentation for your instance type, copy `env/env.instance.<instance_type>` to `env/env.instance` and configure it to your liking.
Each example environment file has a description of what each variable does and how to configure it. 

## Setting up your instance
After reading documentation for your instance type, you should be able to provision and setup your instance.
Follow the instructions in `inventory/<instance_type>/README.md` to provision your instance.
If applicable, follow the instructions in `inventory/<instance_type>/README.md` to setup your instance:

```bash
# Setup the instance
./scripts/setup.sh
```

You shouldn't have to setup instances more than once, so coordinate with others when sharing instances. 

## (Finally) Running benchmarks 

### Checking if a benchmark is running on the instance
Benchmarks can be long-running processes, depending on the size of the inputs you are testing. Be sure to coordinate with other users of the instance to ensure that no one else is running a benchmark on the instance.
Just in case, you can check if a benchmark is running on the instance with the following command:
```bash
# Check if a benchmark is running on the instance
./scripts/benchmark/check.sh
```
This command should let you know if a benchmark is running on the instance, which is indicated by whether `BENCH_PATH/.benchmark` exists on the instance.

Sometimes an ssh connection can be lost while a benchmark is running, and the benchmark process will not be able to clean up after itself. You should configure your control machine to 
have a longer timeout in order to avoid this, but if you do run into this issue, you can manually clean up the instance with the following command:
```bash
# Clean up flags and artifacts from a benchmark that was interrupted
./scripts/benchmark/clear.sh
```
Only run this command if you are sure that no benchmark is running on the instance, or if you are sure that the benchmark is no longer running.

NOTE: Right now, this just clears the flag file and deletes artifacts. The `dataprep` command may still be running on the instance, and you will need to manually kill it.

TODO: Figure out a way to handle this in a more robust way using ansible.

TODO: Look into using `screen` or `tmux` to run the benchmark process in the background.

TODO: Look into how much of the benchmark can be orchestrated on the instance itself, and how much needs to be orchestrated from the control machine.

### Installing the latest version of your branch + tools
The benchmark process uses the `dataprep` repository to handle installing the latest version of your branch on the instance, and to pull the results of the benchmark from the instance.
After configuring `env.instance`, configure `env/env.git` to point to your branch of `dataprep` you are working on. 
Then, run the following command:
```bash
# Install the latest version of your branch on the instance
./scripts/install.sh
```
This will install the specified branch of `dataprep` on the instance, and will install the `fake-file` tool on the instance.

### Generating or placing Inputs
You are responsible for ensuring that the `INPUT_PATH` is populated with the data you want to test. The `INPUT_PATH` is configured in `env.instance`.
If you have a specific dataset you want to test, you will need to place it in the `INPUT_PATH` on the instance manually.

TODO: Figure out a way to automate this process.

If you do not have a specific dataset, and want to use randomly generated data, you can use the `generate.sh` script to generate a dataset for you. This script will generate a dataset of the size you specify, and place it in the `INPUT_PATH`.
Be sure you have installed `fake-file` using the above step.

After configuring `env.generate`, run the following command:
```bash
# Generate fake files for testing. 
./scripts/input/generate.sh
```
This script will generate a dataset of the size you specify, and place it in the `INPUT_PATH`.

Note, this can be a long-running process, and instances have finite storage. Be sure to reasonably configure the size of the dataset you want to generate.
Also make sure to alert any team members that may be working on the instance that you are generating a dataset.

If you would like to clear the `INPUT_PATH` after you are done testing, you can use the `clear.sh` script:
```bash
# Clear the INPUT_PATH
./scripts/input/clear.sh
```

### Running the Benchmark
After:
- configuring `env.instance`
- installing the latest version of your branch on the instance
- generating or placing inputs in the `INPUT_PATH`
run the following command to run the benchmark:
```bash
# Run the configured benchmarks 
./scrips/benchmark/run.sh
```
This will run the benchmarks on the instance, and save the results in the `RESULT_PATH` on the instance.

You should be able to configure an IFTTT webhook to alert you when the benchmark is complete or as it progresses (see later section for setting up IFTTT).

Otherwise, you can check the status of the benchmark with the following command:
```bash
# Check the status of a long-running benchmark
./scripts/benchmark/check.sh
```

### Pulling the results of the benchmark
Results should appear at the `RESULT_PATH` on the instance. You can copy them to your working directory with
```bash
# Copy the results of the benchmark to your working directory
./scripts/results.sh
```
You should see them organized by instance, time run, and input in the `results` directory.

### Cleaning up the instance
After you are done running the benchmark without fail using ansible, you should not need to clean up the instance.
See the documentation for your instance type for more information on how to clean up the instance, if necessary.
For example, it is recommended to delete AWS instances after you are done using them.

## Setting up IFTTT
NOTE (amiller68): When I last tested this, my key did not work at all! Something may have changed with IFTTT.

You can configure `env/env.ifttt` to send you notifications when the benchmark is complete or as it progresses.
You will need to create an IFTTT account and configure a webhook to send notifications to your phone:
- Create an IFTTT account
- Create a new applet
  - Select "Webhooks" as the trigger. Use the "Receive a web request with a JSON payload" trigger. Call this trigger "benchmark-notification"
  - Select "Notifications" as the action. Use the "Send a rich notification from the IFTTT app" action.
- Configure the webhook
  - Go to https://ifttt.com/services/maker_webhooks/settings
  - Copy the key from the URL at the bottom of the page. 
  - Configure `env/env.ifttt` s.t. `IFTTT_TEST_WEBHOOK_KEY=<your key>`
- Download the IFTTT app on your phone