# Example project using a flexible project layout

> **Warning**: This project should be considered [alpha maturity](https://docs.improbable.io/reference/latest/shared/release-policy#maturity-stages) and is intended for early evaluation. Config files and worker directories are not laid out as best practice or as an example of good project layout - instead, they're laid out to demonstrate the flexibility now available in the project layout.

## What is it?
This is a simple SpatialOS project with two C# server workers (`HelloWorker` and `DiceWorker`) and one C# client worker (`Client`).

It doesn't require any specific locations for the SpatialOS files - you can put them anywhere in the project as long as you reference them in the `spatialos.json` file.

> **Note**: SpatialOS expects the workers to be pre-built, and only contains information on how to run them. This means the `spatial worker build` command is unavailable - you're responsible for building your workers (see [Building the project](#building-the-project) below).

#### Prerequisites

See the [SpatialOS documentation](https://docs.improbable.io/reference/latest) to set up the `spatial` CLI.

Run `spatial update` to ensure you have the latest version of the `spatial` command line tool which includes the features required for this example project.

Mac users: ensure that `msbuild` is on your PATH. `msbuild` is provided by Mono.

Windows users: ensure that `MSBuild.exe` is on your PATH. `MSBuild.exe` is provided by the .NET Framework.

Bash is required for running the build script, although as an alternative you can complete these steps manually. There are several options to install bash on Windows, although we recommend [GitBash](https://gitforwindows.org/).

We've tested the project with the following:
* Mono 4.4 (Mac)
* .NET Framework 4.5 (Windows)
* GitBash 2.18 (Windows)

## How do I use it?
The custom layout is enabled by the `spatial` tool detecting a [new-format spatialos.json](docs/reference/project-configuration.md) file. 

We have introduced three new spatial CLI commands under the `alpha` subcommand: `spatial alpha local launch`, `spatial alpha cloud upload` and `spatial alpha cloud launch`. These commands only work for FPL projects. In order to use them, you need to:
* be inside a directory containing a FPL-format `spatialos.json`, **or** 
* reference a FPL-format `spatialos.json` using the `--main_config` flag

You can access this information at any time by using the `--help` flag in the `spatial` command line tool.

## Building the project
Run `./build.sh` to build the workers and compile the schema descriptor. You can complete these steps manually if required.

Workers are built in their own bin directories:
* HelloWorker: `HelloWorker/bin`
* DiceWorker: `OtherWorkers/DiceWorker/bin`
* Client: `OtherWorkers/Interactive/client/bin`

## Cleaning the project
Run `./clean.sh` to delete all build files, including worker binaries and any intermediate files generated during the build process. Alternatively, run `git clean -xdf`.

## Running the project locally

To launch a local instance of SpatialOS running the project, run
```bash
$ spatial alpha local launch
```
from the SpatialOS directory (or from any location by adding the `--main_config=\<path to spatialos.json\>` flag). This starts SpatialOS locally and runs the server workers `HelloWorker` and `DiceWorker`.

You can optionally set the `--launch_config` flag to specify a filepath to the [launch configuration](docs/reference/launch-configuration.md) of your deployment. If the flag is not set, the spatial CLI will use launch configuration specified in the `launch_config` field of your [project configuration](docs/reference/project-configuration.md) as a fall back.

As soon as your deployment is running, you can connect client-workers to it. You can find the client-worker binaries in `OtherWorkers/Interactive/client/bin/x64/ReleaseWindows` (or `ReleaseMacOS` for Mac). Connect your client-worker by opening a second terminal to run the binary directly (from inside the `ReleaseWindows` or `ReleaseMacOS` directories):
* Windows: `./Client.exe localhost 7777 <client_id>`
* macOS: `mono --arch=64 Client.exe localhost 7777 <client_id>`

This connects a client-worker that pings the `HelloWorker` and `DiceWorker` every few seconds and then prints the response.

### Logs location
The logs are stored in `logs` subdirectory of the location where your `spatialos.json` file is. For example, if my `spatialos.json` file is in `/workspace/project/SpatialOS`, the SpatialOS logs will go to `/workspace/project/SpatialOS/logs`.

## Running the project in the cloud

To upload your project assembly to the cloud:
```bash
$ spatial alpha cloud upload -a <your-assembly-name>
```

To start a deployment in the cloud:
```bash
$ spatial alpha cloud launch -d <your-deployment-name> -a <your-assembly-name>
```

## Known Issues
There are no known issues at the moment.

## Reference documentation
[Project configuration file](docs/reference/project-configuration.md)

[Launch configuration file](docs/reference/launch-configuration.md)

[Server worker configuration file](docs/reference/server-worker-configuration.md)

[Client worker configuration file](docs/reference/client-worker-configuration.md)

## Migration Guide
[FAQ](docs/migration-guide/faq.md)

## Changelog
Changes to this repository are documented [here](docs/changelog.md).