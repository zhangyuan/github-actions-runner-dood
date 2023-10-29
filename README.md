# Github Actions runner via Docker outside of Docker

This is a basic setup of Github Actions runner in docker with docker-compose. Althought it can work in common cases, be ware of the following cases:

* If the job consists of service container and the the job runs directly on the runner, and job won't be able to access the service via port. This is because the docker daemon runs on the host machine, thus the service container is exposed on the host machine. To solve the issue, you may have to run the runner on the host rather than in docker (e.g. https://github.com/zhangyuan/setup-github-actions-runner-on-vm ), or run the job in the container.

## Build the image

```bash
docker compose build --progress=plain
```

## Run the runner


Create the `.env` file, and run the container:

```bash
docker compose run runner run
```

or launch the container in the background:

```bash
docker compose up -d
```

## Prune docker data with crontab

```bash
echo "0 0 * * * docker system prune -f" | crontab -
```
