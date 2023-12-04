.PHONY: up
up:
	DOCKER_GROUP_ID=$$(getent group docker | cut -d ':' -f 3) docker compose up -d

.PHONY: down
down:
	docker compose down
