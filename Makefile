# Variables
DOCKER_COMPOSE = cd srcs && docker compose

VOLUME_PATH = /home/emran/data

# Colors for pretty output
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
RESET = \033[0m

# Targets
all: create_volumes up

# Create volume directories
create_volumes:
	@echo "$(YELLOW)Creating volume directories...$(RESET)"
	@mkdir -p $(VOLUME_PATH)/wordpress
	@mkdir -p $(VOLUME_PATH)/mariadb
	@echo "$(GREEN)Volume directories created.$(RESET)"

# Build and start containers
up:
	@echo "$(YELLOW)Building and starting containers...$(RESET)"
	@$(DOCKER_COMPOSE) up --build -d
	@echo "$(GREEN)Containers are running.$(RESET)"

# Stop and remove containers
down:
	@echo "$(YELLOW)Stopping containers...$(RESET)"
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)Containers stopped.$(RESET)"

# Display container status
ps:
	@echo "$(YELLOW)Container status:$(RESET)"
	@$(DOCKER_COMPOSE) ps

# View logs
logs:
	@$(DOCKER_COMPOSE) logs

# Stop and remove containers, networks, images, and volumes
clean: down
	@echo "$(YELLOW)Removing all containers, networks, images, and volumes...$(RESET)"
	@docker system prune -a --volumes -f
	@echo "$(GREEN)All Docker resources removed.$(RESET)"

# Remove volume directories
clean_volumes:
	@echo "$(YELLOW)Removing volume directories...$(RESET)"
	@rm -rf $(VOLUME_PATH)/wordpress
	@rm -rf $(VOLUME_PATH)/mariadb
	@echo "$(GREEN)Volume directories removed.$(RESET)"

# Full cleanup
fclean: clean clean_volumes

# Rebuild the whole project
re: fclean all

# Help
help:
	@echo "$(YELLOW)Available commands:$(RESET)"
	@echo "  $(GREEN)make$(RESET) or $(GREEN)make all$(RESET): Create volumes and start containers"
	@echo "  $(GREEN)make up$(RESET): Build and start containers"
	@echo "  $(GREEN)make down$(RESET): Stop containers"
	@echo "  $(GREEN)make ps$(RESET): Show container status"
	@echo "  $(GREEN)make logs$(RESET): View container logs"
	@echo "  $(GREEN)make clean$(RESET): Remove all Docker resources"
	@echo "  $(GREEN)make clean_volumes$(RESET): Remove volume directories"
	@echo "  $(GREEN)make fclean$(RESET): Full cleanup (containers and volumes)"
	@echo "  $(GREEN)make re$(RESET): Rebuild the project from scratch"

.PHONY: all create_volumes up down ps logs clean clean_volumes fclean re help