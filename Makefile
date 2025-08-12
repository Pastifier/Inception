build:
	docker compose -f srcs/docker-compose.yml build --no-cache
	docker image prune -f
up:
	docker compose -f srcs/docker-compose.yml up
down:
	docker compose -f srcs/docker-compose.yml down