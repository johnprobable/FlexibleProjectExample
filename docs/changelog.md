# Changelog

* **18 Feb 2019:**
  * Added a `build.sh` script to each worker so that it is possible to build a single worker with the script.
  * Added a `download_dependencies.sh` script to `SpatialOS/scripts/` for downloading schema compiler, standard library schemas and SDKs. 
  * Added a `generate-schema-descriptor.sh` script to `SpatialOS/scripts/` for generating a schema descriptor from the schemas. 
  * Added a `utils.sh` script to `SpatialOS/scripts` for storing paths to workers, tools, schemas.
  * Added a `build-project.sh` script to `SpatialOS/scripts/`. It calls other scripts to build the project.
  * Removed `build.sh` and `clean.sh`.
  * Moved `deployment.json` from `SpatialOS/` to `SpatialOS/launch_configs/`.
  * Modified `*.csproj` in all worker folders so that all dependencies point to the files inside the worker dir.
  * Flattened all worker folders into the top dir and modified `SpatialOS/spatialos.json` to reflect the changes to worker paths.
* **15 Feb 2019:**
  * Changed the signature of the `spatial alpha cloud upload` and `spatial alpha cloud launch` CLI commands: Replaced all positional arguments with mandatory flags. For more information, please run the commands with the `--help` flag.
  * Removed the `--optimize_for_runtime_v2` CLI flag and added a new `--using_old_loadbalancer` flag for `spatial alpha local launch`. We now optimize for the [new Runtime](https://docs.improbable.io/reference/latest/releases/upgrade-guides/upgrade-runtime) by default. Please set the `--using_old_loadbalancer` flag if you want to start a local deployment with the old Runtime.
  * Merged the content of the world configuration file (`world.json`) into the [launch configuration](reference/launch-configuration.md). We no longer support using the world configuration file.
  * Added a `streaming_query_interval` field to the [launch configuration](reference/launch-configuration.md).
  * Added a `launch_config` field in the [project configuration](reference/project-configuration.md).
  * Added `loginRateLimit` and `connectionCapacityLimit` fields to the [client-worker configuration](reference/client-worker-configuration.md).
  * Added `launcherCommand` and `launcherArguments` fields to the `uploadConfiguration` section of the [client-worker configuration](reference/client-worker-configuration.md).
* **30 Jan 2019:** 
  * Moved the snapshot file from `./shared`  to `./SpatialOS/snapshots`.
  * Added this changelog.
  * Added a known issues section to the [readme](../README.md#known-issues).
  * Added a [FAQ section](migration-guide/faq.md).
  * Upgraded the deployment launch configuration to use the `small` template.
* **29 Jan 2019:** Upgraded code examples to use `spatial alpha local launch`, `spatial alpha cloud upload` and `spatial alpha cloud launch`.
* **22 Jan 2019:** Upgraded worker SDK version to `13.5.1`.
* **21 Jan 2019:** Added an upload configuration to the client-worker.
