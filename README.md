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
