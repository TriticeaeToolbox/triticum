# Docker Setup

## Docker Images

 - **postgres_dockerfile**
     - Source: https://github.com/solgenomics/postgres_dockerfile
 - **breedbase_dockerfile**
     - Source: https://github.com/solgenomics/breedbase_dockerfile
     - Modified `prepare.sh` to use the TriticeaeToolbox forks for the `sgn` and `triticum` repositories.

## Directory Structure

- Created the `/opt/breedbase` directory to hold all breedbase related files
- **Directories**:
    - **bin/** contains helper scripts, such as the `breedbase` script which can be used to start / stop the database and web containers.
    - **config/** contains the sgn config files used for each instance of a web container (the `sgn_local.conf` file used for the sgn web app).
    - **mnt/** contains directories mounted to the web container for persistent storage
    - **postgresql/** contains the postgres data directory mounted to the database container for persistent data storage
    - **repos/** contains git repositories, such as the `sgn` and `triticum` repos which are mounted to the web container for easier modification outside of the docker container.

## Usage

The `breedbase` script in `/opt/breedbase/bin` includes commands to get the status of the breedbase database and web containers as well as starting and stopping the containers.

```
  BREEDBASE HELPER UTILITY
  ------------------------
  Usage: /opt/breedbase/bin/breedbase <command> [arguments]

  Commands:
    status                  Get the status of the breedbase database and web containers
    start                   Start the breedbase database container and all defined web containers
    stop                    Stop the breedbase database container and all defined web containers
    start_db                Start the breedbase postgres database container
    stop_db                 Stop the breedbase postgres database container
    start_web <instance>    Start the breedbase web site container for the specified instance
    stop_web <instance>     Stop the breedbase web site container for the specified instance
    log <instance>          Display the breedbase web site error log for the specified instance
    bash <instance>         Start bash shell in the web container for the specified instance
    reload <instance>       Reload the sgn web-app (to incorporate perl file changes)
```    

---

The web container mounts the following host directories to docker directories:

| Host | Docker |
|-------|-------|
| `$web_mnt_dir`/archive | /home/production/archive |
| `$web_mnr_dir`/public | /home/production/public |
| `$web_mnr_dir`/prod | /export/prod |
| `$sgn_repo` | /home/production/cxgn/sgn |
| `$instance_repo` | /home/production/cxgn/`$instance_repo_name` |
| `$instance_config` | /home/production/cxgn/sgn/sgn_local.conf |

Where each variable is defined separately for each instance of the web container.

**Example:** triticum

| Variable | Definition |
|-----------|-----------|
| `$web_mnt_dir` | /opt/breedbase/mnt/triticum |
| `$sgn_repo` | /opt/breedbase/repos/sgn |
| `$instance_repo` | /opt/breedbase/repos/triticum |
| `$instance_repo_name` | triticum |
| `$instance_config` | /opt/breedbase/config/triticum.conf |


 
